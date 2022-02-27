class ChatObject {
  final String imageUrl;
  final String title;
  final String latestMessage;
  final DateTime dateTime;
  final bool read;

  ChatObject({
    required this.imageUrl,
    required this.title,
    required this.latestMessage,
    required this.dateTime,
    this.read = true,
  });
}
