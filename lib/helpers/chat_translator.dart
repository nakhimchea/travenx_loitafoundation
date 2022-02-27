import 'package:travenx_loitafoundation/models/chat_object_model.dart';
import 'package:travenx_loitafoundation/services/firestore_service.dart';

Future<List<ChatObject>> chatTranslator(
    List<String> chatPostIds,
    List<String> chatWithUserIds,
    List<dynamic> selfPostIds,
    List<Map<String, dynamic>> chats) async {
  List<ChatObject> _chatObjects = [];

  assert(chatPostIds.length == chats.length);
  final FirestoreService _firestoreService = FirestoreService();
  for (int index = 0; index < chatPostIds.length; index++) {
    String? _imageUrl;
    String? _title;
    String? _latestMessage;
    DateTime? _dateTime;
    if (chats.elementAt(index).isNotEmpty) {
      if (selfPostIds.toString().contains(chatPostIds.elementAt(index))) {
        // Self Posts
        try {
          await _firestoreService
              .getProfileData(chatWithUserIds.elementAt(index))
              .then((documentSnapshot) {
            _imageUrl = documentSnapshot.get('profileUrl').toString();
            _title = documentSnapshot.get('displayName').toString();
          });
        } catch (e) {
          print(e);
        }
      } else {
        // chat-to Posts
        try {
          await _firestoreService
              .getPostData(chatPostIds.elementAt(index))
              .then((documentSnapshot) {
            _imageUrl = documentSnapshot.get('imageUrls')[0].toString();
            _title = documentSnapshot.get('title').toString();
          });
        } catch (e) {
          print(e);
        }
      }
      _latestMessage = chats.elementAt(index)['message'].toString();
      _dateTime = DateTime.fromMillisecondsSinceEpoch(
          int.parse(chats.elementAt(index)['dateTime'].toString()));
    }
    if (_imageUrl != null &&
        _title != null &&
        _latestMessage != null &&
        _dateTime != null)
      _chatObjects.add(ChatObject(
        imageUrl: _imageUrl!,
        title: _title!,
        latestMessage: _latestMessage,
        dateTime: _dateTime,
      ));
  }

  return _chatObjects;
}
