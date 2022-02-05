import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> hasProfileData(
    String atUserId,
  ) async =>
      await _firestore
          .collection('profile_screen')
          .doc(atUserId)
          .get()
          .then((_document) => _document.data() != null ? true : false);

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
      });

  Future<void> updateProfileData(
    String atUserId,
    String key,
    String value,
  ) async =>
      await _firestore.collection('profile_screen').doc(atUserId).update({
        key: value,
      });
}
