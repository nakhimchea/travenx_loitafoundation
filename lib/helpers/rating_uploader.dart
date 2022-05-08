import 'package:firebase_auth/firebase_auth.dart';
import 'package:travenx_loitafoundation/services/firestore_service.dart';

class RatingUploader {
  FirestoreService _firestoreService = FirestoreService();
  final User? _currentUser = FirebaseAuth.instance.currentUser;
  final String _dateTime = DateTime.now().millisecondsSinceEpoch.toString();

  String _comment = '';
  int _rating = 0;
  String _postId = '';

  RatingUploader({
    required String comment,
    required int rating,
    required String postId,
  }) {
    this._comment = comment;
    this._rating = rating;
    this._postId = postId;
  }

  Future<void> pushRating() async {
    try {
      final Map<String, dynamic> data = {
        'comment': _comment,
        'rating': _rating,
        'uid': _currentUser!.uid,
        'dateTime': _dateTime,
        'likes': 0,
        'dislikes': 0,
      };

      await _firestoreService.setRatings4Post(_postId, _currentUser!.uid, data);
    } catch (e) {
      print('Unknown Error: $e');
    }
  }
}
