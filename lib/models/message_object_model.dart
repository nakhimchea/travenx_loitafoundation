class MessageObject {
  final String imageUrl;
  final String title;
  final String latestMessage;
  final DateTime dateTime;
  final bool read;

  MessageObject({
    required this.imageUrl,
    required this.title,
    required this.latestMessage,
    required this.dateTime,
    this.read = true,
  });
}

final List<MessageObject> messageList = [
  MessageObject(
    imageUrl: 'assets/images/travenx_180.png',
    title: 'ឈ្មោះកន្លែង',
    latestMessage: 'Text Over Flow testing if working',
    dateTime: DateTime.now(),
  ),
  MessageObject(
    imageUrl: 'assets/images/travenx_180.png',
    title: 'ឈ្មោះកន្លែង',
    latestMessage: '',
    dateTime: DateTime.fromMillisecondsSinceEpoch(1312908481000),
  ),
  MessageObject(
    imageUrl: 'assets/images/travenx_180.png',
    title: 'ឈ្មោះកន្លែង',
    latestMessage: 'ផ្ញើរសារជាសម្លេង',
    dateTime: DateTime.now(),
    read: false,
  ),
  MessageObject(
    imageUrl: 'assets/images/travenx_180.png',
    title: 'ឈ្មោះកន្លែង',
    latestMessage: 'នៅមានបង',
    dateTime: DateTime.fromMillisecondsSinceEpoch(1312908481000),
  ),
  MessageObject(
    imageUrl: 'assets/images/travenx_180.png',
    title: 'ឈ្មោះកន្លែង',
    latestMessage: 'មានអត់បងឯង',
    dateTime: DateTime.now(),
  ),
  MessageObject(
    imageUrl: 'assets/images/travenx_180.png',
    title: 'ឈ្មោះកន្លែង',
    latestMessage: 'អ្នកបានផ្ញើរសារជាសម្លេងទៅ',
    dateTime: DateTime.fromMillisecondsSinceEpoch(1312908481000),
  ),
  MessageObject(
    imageUrl: 'assets/images/travenx_180.png',
    title: 'ឈ្មោះកន្លែង',
    latestMessage: 'Text Over Flow testing if working',
    dateTime: DateTime.now(),
  ),
  MessageObject(
    imageUrl: 'assets/images/travenx_180.png',
    title: 'ឈ្មោះកន្លែង',
    latestMessage: '',
    dateTime: DateTime.fromMillisecondsSinceEpoch(1312908481000),
  ),
  MessageObject(
    imageUrl: 'assets/images/travenx_180.png',
    title: 'ឈ្មោះកន្លែង',
    latestMessage: 'ផ្ញើរសារជាសម្លេង',
    dateTime: DateTime.now(),
    read: false,
  ),
  MessageObject(
    imageUrl: 'assets/images/travenx_180.png',
    title: 'ឈ្មោះកន្លែង',
    latestMessage: 'នៅមានបង',
    dateTime: DateTime.fromMillisecondsSinceEpoch(1312908481000),
  ),
  MessageObject(
    imageUrl: 'assets/images/travenx_180.png',
    title: 'ឈ្មោះកន្លែង',
    latestMessage: 'មានអត់បងឯង',
    dateTime: DateTime.now(),
  ),
  MessageObject(
    imageUrl: 'assets/images/travenx_180.png',
    title: 'ឈ្មោះកន្លែង',
    latestMessage: 'អ្នកបានផ្ញើរសារជាសម្លេងទៅ',
    dateTime: DateTime.fromMillisecondsSinceEpoch(1312908481000),
  ),
];
