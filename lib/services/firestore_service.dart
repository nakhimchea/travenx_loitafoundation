import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot<Map<String, dynamic>>> getProfileData(
    String atUserId,
  ) async =>
      await _firestore
          .collection('profile_screen')
          .doc(atUserId)
          .get()
          .catchError((e) {
        print('Cannot retrieve profile data: ${e.toString()}');
      });

  Future<bool> hasProfileData(
    String atUserId,
  ) async =>
      await getProfileData(atUserId)
          .then((documentSnapshot) => documentSnapshot.exists ? true : false);

  Future<void> uploadProfileData(
    String atUserId,
    String? displayName,
    String? phoneNumber,
    String? profileUrl,
    String? backgroundUrl,
  ) async =>
      await _firestore.collection('profile_screen').doc(atUserId).set({
        'displayName': displayName,
        'phoneNumber': phoneNumber,
        'profileUrl': profileUrl,
        'backgroundUrl': backgroundUrl,
        'postIds': [],
      }).catchError((e) {
        print('Cannot upload profile data: ${e.toString()}');
      });

  Future<void> updateProfileData(
    String atUserId,
    String key,
    String value,
  ) async =>
      await _firestore.collection('profile_screen').doc(atUserId).update({
        key: value,
      }).catchError((e) {
        print('Cannot update profile data: ${e.toString()}');
      });

  Future<List<dynamic>> _readPostIds(
    String atUserId,
  ) async =>
      await getProfileData(atUserId).then((documentSnapshot) =>
          documentSnapshot.exists ? documentSnapshot.get('postIds') : []);

  Future<void> addPostId2Profile(
    String atUserId,
    dynamic postId,
  ) async {
    List<dynamic> _postIds = await _readPostIds(atUserId);
    _postIds.add(postId);

    await _firestore.collection('profile_screen').doc(atUserId).set(
      {'postIds': _postIds},
      SetOptions(merge: true),
    ).catchError((e) {
      print('Cannot add Post ID to UserProfile: $e');
    });
  }

  Future<void> setPromotionData(
    String atPostId,
    Map<String, dynamic> data,
  ) async =>
      await _firestore
          .collection('promotions')
          .doc(atPostId)
          .set(
            data,
            SetOptions(merge: true),
          )
          .catchError((e) {
        print('Cannot set merge promotion data: ${e.toString()}');
      });

  Future<QuerySnapshot<Map<String, dynamic>>> getPromotionData() async =>
      await _firestore.collection('promotions').limit(2).get();

  Future<void> setProvinceData(
    String province,
    String atPostId,
    Map<String, dynamic> data,
  ) async =>
      await _firestore
          .collection('home_screen')
          .doc('provinces')
          .collection(province)
          .doc(atPostId)
          .set(
            data,
            SetOptions(merge: true),
          )
          .catchError((e) {
        print('Cannot set merge province data: ${e.toString()}');
      });

  Future<QuerySnapshot<Map<String, dynamic>>> getProvinceData(
    String province,
  ) async =>
      await _firestore
          .collection('home_screen')
          .doc('provinces')
          .collection(province)
          .limit(2)
          .get();
}
