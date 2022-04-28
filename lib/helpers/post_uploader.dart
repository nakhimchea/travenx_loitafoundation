import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travenx_loitafoundation/models/post_object_model.dart';
import 'package:travenx_loitafoundation/services/firestore_service.dart';
import 'package:travenx_loitafoundation/services/storage_service.dart';

class PostUploader {
  FirestoreService _firestoreService = FirestoreService();
  final User? _currentUser = FirebaseAuth.instance.currentUser;
  final String _postId = DateTime.now().millisecondsSinceEpoch.toString();

  String _clientId = '';
  String _clientDisplayName = '';
  String _clientPhoneNumber = '';
  String _clientProfileUrl = '';

  List<String> _categories = [];
  List<XFile> _imagesFile = [];
  String _title = '';
  String _state = '';
  String _country = '';
  String _positionCoordination = '';
  double _price = 0;
  String? _openHours;
  String? _announcement;
  List<Activity>? _activities;
  Details? _details;
  List<String>? _policies;

  PostUploader({
    required List<String> categories,
    required List<XFile> imagesFile,
    required String title,
    required String state,
    required String country,
    required String positionCoordination,
    required double price,
    required String openHours,
    required String announcement,
    required List<Activity> activities,
    required Details details,
    required List<String> policies,
  }) {
    this._categories = categories;
    this._imagesFile = imagesFile;
    this._title = title;
    this._state = state;
    this._country = country;
    this._positionCoordination = positionCoordination;
    this._price = price;
    this._openHours = openHours;
    this._announcement = announcement;
    this._activities = activities;
    this._details = details;
    this._policies = policies;
  }

  Future<void> pushPostObject() async {
    final StorageService _storageService = StorageService();
    //TODO: get promotion true false, tabBar menu List
    try {
      final List<String> imageUrls = await _storageService.uploadPostImages(
          ownerId: _currentUser!.uid, postId: _postId, imagesFile: _imagesFile);
      await _firestoreService
          .getProfileData(_currentUser!.uid)
          .then((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
        _clientId = _currentUser!.uid;
        _clientDisplayName = documentSnapshot.get('displayName');
        _clientProfileUrl = documentSnapshot.get('profileUrl');
        _clientPhoneNumber = documentSnapshot.get('phoneNumber');
      }).whenComplete(() async {
        final Map<String, dynamic> data = {
          'clientId': _clientId,
          'clientDisplayName': _clientDisplayName,
          'clientProfileUrl': _clientProfileUrl,
          'clientPhoneNumber': _clientPhoneNumber,
          'imageUrls': imageUrls,
          'title': _title,
          'state': _state,
          'country': _country,
          'positionCoordination': _positionCoordination,
          'price': _price,
          'openHours': _openHours!,
          'announcement': _announcement!,
          'ratings': 5.0,
          'views': 0, //TODO: Remove from here and get directly from FireStore
          'activities': _activities!.map((element) => element.label).toList(),
          'details': {
            'mapImageUrl': _details!.mapImageUrl == ''
                ? 'assets/images/travenx.png'
                : _details!.mapImageUrl,
            'textDetail': _details!.textDetail,
          },
          'policies': _policies!,
          'postId': _postId,
        };
        //Upload to Promotion
        await _pushPromotion(atPostId: _postId, data: data);

        //Upload to IconMenus
        await _pushIconMenu(
            iconMenus: _categories, atPostId: _postId, data: data);

        //Upload to Province
        await _pushProvinces(province: _state, atPostId: _postId, data: data);

        //Upload to TabBar
        await _pushTabBar(tabName: 'កន្លែងថ្មី', atPostId: _postId, data: data);
        await _pushTabBar(tabName: 'ទាំងអស់', atPostId: _postId, data: data);

        //Link profile to Post
        await _firestoreService
            .addPostId2Profile(_clientId, _postId)
            .catchError((e) {
          print('Cannot get user ID: $e');
        });
      }).catchError((e) {
        print('Cannot get user IDD: $e');
      });
    } catch (e) {
      print('Unknown Error: $e');
    }
  }

  Future<void> _pushIconMenu({
    required List<String> iconMenus,
    required String atPostId,
    required Map<String, dynamic> data,
  }) async {
    for (String iconMenu in iconMenus)
      await _firestoreService.setIconMenuData(iconMenu, atPostId, data);
    await _firestoreService.setIconMenuData('តំបន់ទាំងអស់', atPostId, data);
  }

  Future<void> _pushProvinces({
    required String province,
    required String atPostId,
    required Map<String, dynamic> data,
  }) async {
    await _firestoreService.setProvinceData(province, atPostId, data);
    await _firestoreService.increaseProvinceCounter(province);
  }

  Future<void> _pushPromotion({
    required String atPostId,
    required Map<String, dynamic> data,
  }) async =>
      await _firestoreService.setPromotionData(atPostId, data);

  Future<void> _pushTabBar({
    required String tabName,
    required String atPostId,
    required Map<String, dynamic> data,
  }) async =>
      await _firestoreService.setTabBarData(tabName, atPostId, data);
}
