import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, kVPadding, textScaleFactor;
import 'package:travenx_loitafoundation/icons/icons.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        //TODO: Push Screen when Search Button push to subscreen
        // ----------------- Merchant Push Icon Menu -------------------------- //TODO:
        // final User? _currentUser = FirebaseAuth.instance.currentUser;
        // String _postId = DateTime.now().millisecondsSinceEpoch.toString();
        // if (_currentUser != null) {
        //   try {
        //     await FirestoreService().getProfileData(_currentUser.uid).then(
        //         (DocumentSnapshot<Map<String, dynamic>>
        //             documentSnapshot) async {
        //       await FirestoreService().setIconMenuData('តំបន់ផ្សេងៗ', _postId, {
        //         'clientId': _currentUser.uid,
        //         'clientDisplayName': documentSnapshot.get('displayName'),
        //         'clientProfileUrl': documentSnapshot.get('profileUrl'),
        //         'clientPhoneNumber': documentSnapshot.get('phoneNumber'),
        //         'imageUrls': [
        //           'assets/images/travenx.png',
        //           'assets/images/travenx.png',
        //           'assets/images/travenx.png',
        //         ],
        //         'title': 'ដើរលេងបន្ទាប់',
        //         'location': 'ខេត្តកំពត កម្ពុជា',
        //         'positionCoordination':
        //             await GeoLocatorService().getCurrentCoordination(),
        //         'price': 0,
        //         'openHours': '9:00ព្រឹក-5:00ល្ងាច',
        //         'announcement':
        //             'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //         'briefDescription': {
        //           'ratings': 4.5,
        //           'distance': 60000,
        //           'temperature': 36,
        //           'views': 1236,
        //         },
        //         'activities': [
        //           'boating',
        //           'swimming',
        //           'relaxing',
        //           'fishing',
        //           'diving',
        //         ],
        //         'details': {
        //           'mapImageUrl': 'assets/images/travenx.png',
        //           'textDetail':
        //               'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //         },
        //         'policies': [
        //           'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //           'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //           'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //           'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //           'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //         ],
        //         'postId': _postId,
        //       });
        // await FirestoreService()
        //     .setIconMenuData('តំបន់ទាំងអស់', _postId, {
        //   'clientId': _currentUser.uid,
        //   'clientDisplayName': documentSnapshot.get('displayName'),
        //   'clientProfileUrl': documentSnapshot.get('profileUrl'),
        //   'clientPhoneNumber': documentSnapshot.get('phoneNumber'),
        //   'imageUrls': [
        //     'assets/images/travenx.png',
        //     'assets/images/travenx.png',
        //     'assets/images/travenx.png',
        //   ],
        //   'title': 'ដើរលេងបន្ទាប់',
        //   'location': 'ខេត្តកំពត កម្ពុជា',
        //   'positionCoordination':
        //       await GeoLocatorService().getCurrentCoordination(),
        //   'price': 0,
        //   'openHours': '9:00ព្រឹក-5:00ល្ងាច',
        //   'announcement':
        //       'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //   'briefDescription': {
        //     'ratings': 4.5,
        //     'distance': 60000,
        //     'temperature': 36,
        //     'views': 1236,
        //   },
        //   'activities': [
        //     'boating',
        //     'swimming',
        //     'relaxing',
        //     'fishing',
        //     'diving',
        //   ],
        //   'details': {
        //     'mapImageUrl': 'assets/images/travenx.png',
        //     'textDetail':
        //         'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //   },
        //   'policies': [
        //     'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //     'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //     'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //     'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //     'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //   ],
        //   'postId': _postId,
        // });
        //     }).catchError((e) {
        //       print('Cannot get user ID: $e');
        //     });
        //     await FirestoreService()
        //         .addPostId2Profile(_currentUser.uid, _postId)
        //         .catchError((e) {
        //       print('Cannot get user IDD: $e');
        //     });
        //   } catch (e) {
        //     print('Unknown Error: $e');
        //   }
        // }
        // ----------------- Merchant Push Promotion -------------------------- //TODO:
        // final User? _currentUser = FirebaseAuth.instance.currentUser;
        // String _postId = DateTime.now().millisecondsSinceEpoch.toString();
        // if (_currentUser != null) {
        //   try {
        //     await FirestoreService()
        //         .getProfileData(_currentUser.uid)
        //         .then((DocumentSnapshot<Map<String, dynamic>>
        //                 documentSnapshot) async =>
        //             await FirestoreService().setPromotionData(_postId, {
        //               'clientId': _currentUser.uid,
        //               'clientDisplayName': documentSnapshot.get('displayName'),
        //               'clientProfileUrl': documentSnapshot.get('profileUrl'),
        //               'clientPhoneNumber': documentSnapshot.get('phoneNumber'),
        //               'imageUrls': [
        //                 'assets/images/travenx.png',
        //                 'assets/images/travenx.png',
        //                 'assets/images/travenx.png',
        //               ],
        //               'title': 'ដើរលេងបន្ទាប់',
        //               'location': 'ខេត្តកំពត កម្ពុជា',
        //               'positionCoordination':
        //                   await GeoLocatorService().getCurrentCoordination(),
        //               'price': 0,
        //               'openHours': '9:00ព្រឹក-5:00ល្ងាច',
        //               'announcement':
        //                   'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //               'briefDescription': {
        //                 'ratings': 4.5,
        //                 'distance': 60000,
        //                 'temperature': 36,
        //                 'views': 1236,
        //               },
        //               'activities': [
        //                 'boating',
        //                 'swimming',
        //                 'relaxing',
        //                 'fishing',
        //                 'diving',
        //               ],
        //               'details': {
        //                 'mapImageUrl': 'assets/images/travenx.png',
        //                 'textDetail':
        //                     'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //               },
        //               'policies': [
        //                 'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //                 'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //                 'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //                 'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //                 'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //               ],
        //               'postId': _postId,
        //             }))
        //         .catchError((e) {
        //       print('Cannot get user ID: $e');
        //     });
        //     await FirestoreService()
        //         .addPostId2Profile(_currentUser.uid, _postId)
        //         .catchError((e) {
        //       print('Cannot get user IDD: $e');
        //     });
        //   } catch (e) {
        //     print('Unknown Error: $e');
        //   }
        // }
        // ----------------- Merchant Push Provinces -------------------------- //TODO:
        // final User? _currentUser = FirebaseAuth.instance.currentUser;
        // String _postId = DateTime.now().millisecondsSinceEpoch.toString();
        // if (_currentUser != null) {
        //   try {
        //     await FirestoreService().getProfileData(_currentUser.uid).then(
        //         (DocumentSnapshot<Map<String, dynamic>>
        //             documentSnapshot) async {
        //       await FirestoreService().setProvinceData('ពោធិ៍សាត់', _postId, {
        //         'clientId': _currentUser.uid,
        //         'clientDisplayName': documentSnapshot.get('displayName'),
        //         'clientProfileUrl': documentSnapshot.get('profileUrl'),
        //         'clientPhoneNumber': documentSnapshot.get('phoneNumber'),
        //         'imageUrls': [
        //           'assets/images/travenx.png',
        //           'assets/images/travenx.png',
        //           'assets/images/travenx.png',
        //         ],
        //         'title': 'ដើរលេងបន្ទាប់',
        //         'location': 'ខេត្តកំពត កម្ពុជា',
        //         'positionCoordination':
        //             await GeoLocatorService().getCurrentCoordination(),
        //         'price': 0,
        //         'openHours': '9:00ព្រឹក-5:00ល្ងាច',
        //         'announcement':
        //             'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //         'briefDescription': {
        //           'ratings': 4.5,
        //           'distance': 60000,
        //           'temperature': 36,
        //           'views': 1236,
        //         },
        //         'activities': [
        //           'boating',
        //           'swimming',
        //           'relaxing',
        //           'fishing',
        //           'diving',
        //         ],
        //         'details': {
        //           'mapImageUrl': 'assets/images/travenx.png',
        //           'textDetail':
        //               'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //         },
        //         'policies': [
        //           'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //           'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //           'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //           'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //           'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //         ],
        //         'postId': _postId,
        //       });
        //     }).catchError((e) {
        //       print('Cannot get user ID: $e');
        //     });
        //     await FirestoreService()
        //         .addPostId2Profile(_currentUser.uid, _postId)
        //         .catchError((e) {
        //       print('Cannot get user IDD: $e');
        //     });
        //     await FirestoreService().increaseProvinceCounter('ពោធិ៍សាត់');
        //   } catch (e) {
        //     print('Unknown Error: $e');
        //   }
        // }
        // ----------------- Merchant Push TabBar Menu ------------------------ //TODO:
        // final User? _currentUser = FirebaseAuth.instance.currentUser;
        // String _postId = DateTime.now().millisecondsSinceEpoch.toString();
        // if (_currentUser != null) {
        //   try {
        //     await FirestoreService().getProfileData(_currentUser.uid).then(
        //         (DocumentSnapshot<Map<String, dynamic>>
        //             documentSnapshot) async {
        //       await FirestoreService().setTabBarData('ល្បីប្រចាំខែ', _postId, {
        //         'clientId': _currentUser.uid,
        //         'clientDisplayName': documentSnapshot.get('displayName'),
        //         'clientProfileUrl': documentSnapshot.get('profileUrl'),
        //         'clientPhoneNumber': documentSnapshot.get('phoneNumber'),
        //         'imageUrls': [
        //           'assets/images/travenx.png',
        //           'assets/images/travenx.png',
        //           'assets/images/travenx.png',
        //         ],
        //         'title': 'ដើរលេងបន្ទាប់',
        //         'location': 'ខេត្តកំពត កម្ពុជា',
        //         'positionCoordination':
        //             await GeoLocatorService().getCurrentCoordination(),
        //         'price': 0,
        //         'openHours': '9:00ព្រឹក-5:00ល្ងាច',
        //         'announcement':
        //             'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //         'briefDescription': {
        //           'ratings': 4.5,
        //           'distance': 60000,
        //           'temperature': 36,
        //           'views': 1236,
        //         },
        //         'activities': [
        //           'boating',
        //           'swimming',
        //           'relaxing',
        //           'fishing',
        //           'diving',
        //         ],
        //         'details': {
        //           'mapImageUrl': 'assets/images/travenx.png',
        //           'textDetail':
        //               'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //         },
        //         'policies': [
        //           'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //           'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //           'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //           'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //           'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //         ],
        //         'postId': _postId,
        //       });
        //       await FirestoreService().setTabBarData('ទាំងអស់', _postId, {
        //         'clientId': _currentUser.uid,
        //         'clientDisplayName': documentSnapshot.get('displayName'),
        //         'clientProfileUrl': documentSnapshot.get('profileUrl'),
        //         'clientPhoneNumber': documentSnapshot.get('phoneNumber'),
        //         'imageUrls': [
        //           'assets/images/travenx.png',
        //           'assets/images/travenx.png',
        //           'assets/images/travenx.png',
        //         ],
        //         'title': 'ដើរលេងបន្ទាប់',
        //         'location': 'ខេត្តកំពត កម្ពុជា',
        //         'positionCoordination':
        //             await GeoLocatorService().getCurrentCoordination(),
        //         'price': 0,
        //         'openHours': '9:00ព្រឹក-5:00ល្ងាច',
        //         'announcement':
        //             'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //         'briefDescription': {
        //           'ratings': 4.5,
        //           'distance': 60000,
        //           'temperature': 36,
        //           'views': 1236,
        //         },
        //         'activities': [
        //           'boating',
        //           'swimming',
        //           'relaxing',
        //           'fishing',
        //           'diving',
        //         ],
        //         'details': {
        //           'mapImageUrl': 'assets/images/travenx.png',
        //           'textDetail':
        //               'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //         },
        //         'policies': [
        //           'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //           'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //           'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //           'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //           'ខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត កម្ពុជាខេត្តកំពត',
        //         ],
        //         'postId': _postId,
        //       });
        //     }).catchError((e) {
        //       print('Cannot get user ID: $e');
        //     });
        //     await FirestoreService()
        //         .addPostId2Profile(_currentUser.uid, _postId)
        //         .catchError((e) {
        //       print('Cannot get user IDD: $e');
        //     });
        //   } catch (e) {
        //     print('Unknown Error: $e');
        //   }
        // }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: kHPadding,
          vertical: kVPadding,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: kHPadding,
          vertical: kVPadding,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).disabledColor,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Row(
          children: [
            Icon(
              CustomOutlinedIcons.search,
              size: 26.0,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            Text(
              'ស្វែងរក',
              textScaleFactor: textScaleFactor,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
