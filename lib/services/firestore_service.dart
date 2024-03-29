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
        'chats': [],
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
    List<dynamic> _postIds = await _readPostIds(atUserId).catchError((e) {
      print('Cannot read my postIds: ${e.toString()}');
    });
    if (!_postIds.toString().contains(postId.toString())) _postIds.add(postId);

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
    String language,
    String atPostId,
    Map<String, dynamic> data,
  ) async =>
      await _firestore
          .collection('promotions_' + language)
          .doc(atPostId)
          .set(
            data,
            SetOptions(merge: true),
          )
          .catchError((e) {
        print('Cannot set merge promotion data: ${e.toString()}');
      });

  Future<QuerySnapshot<Map<String, dynamic>>> getPromotionData(
    String language,
    DocumentSnapshot? lastDoc,
  ) async =>
      lastDoc != null
          ? await _firestore
              .collection('promotions_' + language)
              .startAfterDocument(lastDoc)
              .limit(2)
              .get()
              .catchError((e) {
              print('Cannot get promotion data: ${e.toString()}');
            })
          : await _firestore
              .collection('promotions_' + language)
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
          .orderBy('postId', descending: true)
          .limit(5)
          .get()
          .catchError((e) {
        print('Cannot get icon menu data: ${e.toString()}');
      });

  Future<DocumentSnapshot<Map<String, dynamic>>?> getPostData(
    String atPostId,
  ) async {
    DocumentSnapshot<Map<String, dynamic>>? _doc;
    await _firestore
        .collection('home_screen')
        .doc('icon_menus')
        .collection('តំបន់ទាំងអស់')
        .doc(atPostId)
        .get()
        .then((documentSnapshot) {
      if (documentSnapshot.exists && documentSnapshot.data()!.isNotEmpty)
        _doc = documentSnapshot;
    }).catchError((e) {
      print('Cannot get post data $atPostId: ${e.toString()}');
    });
    await _firestore
        .collection('home_screen')
        .doc('icon_menus')
        .collection('All')
        .doc(atPostId)
        .get()
        .then((documentSnapshot) {
      if (documentSnapshot.exists && documentSnapshot.data()!.isNotEmpty)
        _doc = documentSnapshot;
    }).catchError((e) {
      print('Cannot get post data $atPostId: ${e.toString()}');
    });
    return _doc;
  }

  Future<List<dynamic>> readRatings(
    String atPostId,
  ) async =>
      await _firestore
          .collection('ratings')
          .doc(atPostId)
          .get()
          .then((documentSnapshot) =>
              documentSnapshot.exists ? documentSnapshot.get('ratings') : [])
          .catchError((e) {
        print('Cannot retrieve rating data: ${e.toString()}');
      });

  Future<double> getRatingRate(
    String atPostId,
  ) async =>
      await readRatings(atPostId).then((ratings) {
        int total = 0;
        for (Map<String, dynamic> rating in ratings)
          total += int.parse(rating['rating'].toString());
        return total == 0 ? 5.0 : total / ratings.length;
      });

  List<int> getRatingExpression(
    List<dynamic> ratings,
    String atUid,
  ) {
    List<int> expression = [];
    for (Map<String, dynamic> rating in ratings)
      if (rating['uid'].toString().contains(atUid)) {
        try {
          expression.add(int.parse(rating['likes'].toString()));
          expression.add(int.parse(rating['dislikes'].toString()));
        } catch (e) {
          print('Cannot read integer likes and dislikes $e');
        }
        break;
      }
    return expression;
  }

  Future<void> setRatings4Post(
    String atPostId,
    String uid,
    Map<String, dynamic> data,
  ) async {
    List<dynamic> _ratings = await readRatings(atPostId).catchError((e) {
      print('Cannot read ratings: ${e.toString()}');
    });

    for (Map<String, dynamic> rating in _ratings)
      if (rating['uid'].toString().contains(uid)) {
        _ratings.remove(rating);
        break;
      }
    _ratings.add(data);

    await _firestore.collection('ratings').doc(atPostId).set(
      {'ratings': _ratings},
      SetOptions(merge: true),
    ).catchError((e) {
      print('Cannot add ratings to Post: $e');
    });
  }

  Future<List<dynamic>> readGallery(
    String atPostId,
  ) async =>
      await _firestore
          .collection('gallery')
          .doc(atPostId)
          .get()
          .then((documentSnapshot) =>
              documentSnapshot.exists ? documentSnapshot.get('imageUrls') : [])
          .catchError((e) {
        print('Cannot retrieve gallery data: ${e.toString()}');
      });

  Future<void> setGalleryImages(
    String atPostId,
    String uid,
    List<String> imageUrls,
  ) async {
    List<String> _gallery = await readGallery(atPostId).then((list) {
      List<String> convertedList = [];
      list.forEach((element) => convertedList.add(element.toString()));
      return convertedList;
    }).catchError((e) {
      print('Cannot read gallery: ${e.toString()}');
    });

    await _firestore.collection('gallery').doc(atPostId).set(
      {'imageUrls': imageUrls..addAll(_gallery)},
      SetOptions(merge: true),
    ).catchError((e) {
      print('Cannot add Gallery to Post: $e');
    });
  }

  Future<List<dynamic>> readViews(
    String atPostId,
  ) async =>
      await _firestore
          .collection('views')
          .doc(atPostId)
          .get()
          .then((documentSnapshot) =>
              documentSnapshot.exists ? documentSnapshot.get('viewers') : [])
          .catchError((e) {
        print('Cannot retrieve viewer data: ${e.toString()}');
      });

  Future<void> setViews4Post(
    String atPostId, [
    String? viewerId,
  ]) async {
    if (viewerId != null) {
      List<dynamic> _viewerIds = await readViews(atPostId).catchError((e) {
        print('Cannot read viewers: ${e.toString()}');
      });
      if (!_viewerIds.toString().contains(viewerId)) {
        _viewerIds.add(viewerId);
        await _firestore.collection('views').doc(atPostId).set(
          {'viewers': _viewerIds},
          SetOptions(merge: true),
        ).catchError((e) {
          print('Cannot add viewer to Post: $e');
        });
      }
    }
  }

  //ChatScreen
  Future<List<dynamic>> _readChats(
    String atUserId,
  ) async =>
      await getProfileData(atUserId).then((documentSnapshot) =>
          documentSnapshot.exists ? documentSnapshot.get('chats') : []);

  Future<void> addChat2Profile(
    String userId,
    String userDisplayName,
    String userPhoneNumber,
    String userProfileUrl,
    String postId,
    String clientId,
    String clientDisplayName,
    String clientPhoneNumber,
    String clientProfileUrl,
  ) async {
    final List<dynamic> _userChats = await _readChats(userId).catchError((e) {
      print('Cannot read previous user chats: ${e.toString()}');
    });
    final List<dynamic> _clientChats =
        await _readChats(clientId).catchError((e) {
      print('Cannot read previous client chats: ${e.toString()}');
    });

    bool _isExisted = false;
    for (Map<String, dynamic> userChat in _userChats)
      if (userChat['withUserId'].toString().contains(clientId) &&
          userChat['postId'].toString().contains(postId)) _isExisted = true;

    if (!_isExisted) {
      _userChats.add({
        'withPhoneNumber': clientPhoneNumber,
        'postId': postId,
        'withDisplayName': clientDisplayName,
        'withProfileUrl': clientProfileUrl,
        'withUserId': clientId,
      });
      _clientChats.add({
        'withPhoneNumber': userPhoneNumber,
        'postId': postId,
        'withDisplayName': userDisplayName,
        'withProfileUrl': userProfileUrl,
        'withUserId': userId,
      });
    }

    await _firestore.collection('profile_screen').doc(userId).set(
      {'chats': _userChats},
      SetOptions(merge: true),
    ).catchError((e) {
      print('Cannot add a chat to UserProfile: $e');
    });
    await _firestore.collection('profile_screen').doc(clientId).set(
      {'chats': _clientChats},
      SetOptions(merge: true),
    ).catchError((e) {
      print('Cannot add a chat to ClientProfile: $e');
    });
  }

  Future<void> addChatMessage(
    String atUserId,
    String atClientId,
    String atPostId,
    String senderName,
    String senderProfileUrl,
    String? message,
    String? attachmentUrl,
  ) async {
    final String _dateTime = DateTime.now().millisecondsSinceEpoch.toString();
    await _firestore
        .collection('chat_screen')
        .doc(atUserId)
        .collection(atPostId)
        .doc('withUserId')
        .collection(atClientId)
        .add({
      'senderUid': atUserId,
      'senderName': senderName,
      'senderProfileUrl': senderProfileUrl,
      'message': message != null ? message : '',
      'attachmentUrl': attachmentUrl != null ? attachmentUrl : '',
      'dateTime': _dateTime,
    }).catchError((e) {
      print('Cannot add user message: ${e.toString()}');
    });
    await _firestore
        .collection('chat_screen')
        .doc(atClientId)
        .collection(atPostId)
        .doc('withUserId')
        .collection(atUserId)
        .add({
      'senderUid': atUserId,
      'senderName': senderName,
      'senderProfileUrl': senderProfileUrl,
      'message': message != null ? message : '',
      'attachmentUrl': attachmentUrl != null ? attachmentUrl : '',
      'dateTime': _dateTime,
    }).catchError((e) {
      print('Cannot add client message: ${e.toString()}');
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamProfile(
    String atUserId,
  ) =>
      _firestore.collection('profile_screen').doc(atUserId).snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(
    String atUserId,
    String atPostId,
    String withUserId, {
    int? messageQuantity,
  }) =>
      messageQuantity != null
          ? _firestore
              .collection('chat_screen')
              .doc(atUserId)
              .collection(atPostId)
              .doc('withUserId')
              .collection(withUserId)
              .orderBy('dateTime', descending: true)
              .limit(messageQuantity)
              .snapshots()
          : _firestore
              .collection('chat_screen')
              .doc(atUserId)
              .collection(atPostId)
              .doc('withUserId')
              .collection(withUserId)
              .orderBy('dateTime', descending: true)
              .snapshots();

  // ProfileScreen
  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getUserPosts(
    String atUserId,
  ) async {
    List<DocumentSnapshot<Map<String, dynamic>>> posts = [];

    List<dynamic> _postIds = await _readPostIds(atUserId).catchError((e) {
      print('Cannot read my postIds: ${e.toString()}');
    });
    for (var _postId in _postIds)
      if (await getPostData(_postId) != null)
        posts.add((await getPostData(_postId))!);
    return posts;
  }
}
