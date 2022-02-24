import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // HomeScreen
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

  Future<void> setIconMenuData(
    String iconMenu,
    String atPostId,
    Map<String, dynamic> data,
  ) async =>
      await _firestore
          .collection('home_screen')
          .doc('icon_menus')
          .collection(iconMenu)
          .doc(atPostId)
          .set(
            data,
            SetOptions(merge: true),
          )
          .catchError((e) {
        print('Cannot set merge icon menu data: ${e.toString()}');
      });

  Future<QuerySnapshot<Map<String, dynamic>>> getIconMenuData(
    String iconMenu,
    DocumentSnapshot? lastDoc,
  ) async =>
      lastDoc != null
          ? await _firestore
              .collection('home_screen')
              .doc('icon_menus')
              .collection(iconMenu)
              .startAfterDocument(lastDoc)
              .limit(2)
              .get()
              .catchError((e) {
              print('Cannot get icon menu data: ${e.toString()}');
            })
          : await _firestore
              .collection('home_screen')
              .doc('icon_menus')
              .collection(iconMenu)
              .limit(2)
              .get()
              .catchError((e) {
              print('Cannot get icon menu data: ${e.toString()}');
            });

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

  Future<QuerySnapshot<Map<String, dynamic>>> getPromotionData(
    DocumentSnapshot? lastDoc,
  ) async =>
      lastDoc != null
          ? await _firestore
              .collection('promotions')
              .startAfterDocument(lastDoc)
              .limit(2)
              .get()
              .catchError((e) {
              print('Cannot get promotion data: ${e.toString()}');
            })
          : await _firestore
              .collection('promotions')
              .limit(2)
              .get()
              .catchError((e) {
              print('Cannot get promotion data: ${e.toString()}');
            });

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

  Future<Map<String, dynamic>> getProvinceCounter() async => await _firestore
          .collection('home_screen')
          .doc('provinces_total_posts')
          .get()
          .then((snapshot) => snapshot.data()!)
          .catchError((e) {
        print('Cannot get province counter: $e');
      });

  Future<void> increaseProvinceCounter(
    String atProvince,
  ) async =>
      await _firestore
          .collection('home_screen')
          .doc('provinces_total_posts')
          .update({
        atProvince: int.parse(await getProvinceCounter()
                .then((data) => data[atProvince].toString())) +
            1
      }).catchError((e) {
        print('Cannot update value in provinces_total_posts: $e');
      });

  Future<void> decreaseProvinceCounter(
    String atProvince,
  ) async =>
      await _firestore
          .collection('home_screen')
          .doc('provinces_total_posts')
          .update({
        atProvince: int.parse(await getProvinceCounter()
                .then((data) => data[atProvince].toString())) -
            1
      }).catchError((e) {
        print('Cannot update value in provinces_total_posts: $e');
      });

  Future<QuerySnapshot<Map<String, dynamic>>> getProvinceData(
    String province,
    DocumentSnapshot? lastDoc,
  ) async =>
      lastDoc != null
          ? await _firestore
              .collection('home_screen')
              .doc('provinces')
              .collection(province)
              .startAfterDocument(lastDoc)
              .limit(3)
              .get()
              .catchError((e) {
              print('Cannot get icon menu data: ${e.toString()}');
            })
          : await _firestore
              .collection('home_screen')
              .doc('provinces')
              .collection(province)
              .limit(3)
              .get()
              .catchError((e) {
              print('Cannot get icon menu data: ${e.toString()}');
            });

  Future<void> setTabBarData(
    String tab,
    String atPostId,
    Map<String, dynamic> data,
  ) async =>
      await _firestore
          .collection('home_screen')
          .doc('tab_lists')
          .collection(tab)
          .doc(atPostId)
          .set(
            data,
            SetOptions(merge: true),
          )
          .catchError((e) {
        print('Cannot set merge icon menu data: ${e.toString()}');
      });

  Future<QuerySnapshot<Map<String, dynamic>>> getTabBarData(
    String tab,
  ) async =>
      await _firestore
          .collection('home_screen')
          .doc('tab_lists')
          .collection(tab)
          .limit(5)
          .get()
          .catchError((e) {
        print('Cannot get icon menu data: ${e.toString()}');
      });

  //ChatScreen
  Future<void> addChatMessage(
    String atUserId,
    String atClientId,
    String atPostId,
    String senderName,
    String senderProfileUrl,
    String? senderMessage,
  ) async {
    await _firestore
        .collection('chat_screen')
        .doc(atUserId)
        .collection(atPostId)
        .add({
      'senderName': senderName,
      'senderProfileUrl': senderProfileUrl,
      'senderMessage': senderMessage != null ? senderMessage : '',
    }).catchError((e) {
      print('Cannot add user message: ${e.toString()}');
    });
    await _firestore
        .collection('chat_screen')
        .doc(atClientId)
        .collection(atPostId)
        .doc('fromUserId')
        .collection(atUserId)
        .add({
      'senderName': senderName,
      'senderProfileUrl': senderProfileUrl,
      'senderMessage': senderMessage != null ? senderMessage : '',
    }).catchError((e) {
      print('Cannot add client message: ${e.toString()}');
    });
  }

  //TODO: Add retrieve data test and check logic for Client vs User
}
