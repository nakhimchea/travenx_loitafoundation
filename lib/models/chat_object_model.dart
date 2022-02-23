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

final List<ChatObject> messageList = [
  ChatObject(
    imageUrl: 'assets/images/travenx_180.png',
    title: 'ឈ្មោះកន្លែង',
    latestMessage: 'Text Over Flow testing if working',
    dateTime: DateTime.now(),
  ),
  ChatObject(
    imageUrl: 'assets/images/travenx_180.png',
    title: 'ឈ្មោះកន្លែង',
    latestMessage: '',
    dateTime: DateTime.fromMillisecondsSinceEpoch(1312908481000),
  ),
  ChatObject(
    imageUrl: 'assets/images/travenx_180.png',
    title: 'ឈ្មោះកន្លែង',
    latestMessage: 'ផ្ញើរសារជាសម្លេង',
    dateTime: DateTime.now(),
    read: false,
  ),
  ChatObject(
    imageUrl: 'assets/images/travenx_180.png',
    title: 'ឈ្មោះកន្លែង',
    latestMessage: 'នៅមានបង',
    dateTime: DateTime.fromMillisecondsSinceEpoch(1312908481000),
  ),
  ChatObject(
    imageUrl: 'assets/images/travenx_180.png',
    title: 'ឈ្មោះកន្លែង',
    latestMessage: 'មានអត់បងឯង',
    dateTime: DateTime.now(),
  ),
  ChatObject(
    imageUrl: 'assets/images/travenx_180.png',
    title: 'ឈ្មោះកន្លែង',
    latestMessage: 'អ្នកបានផ្ញើរសារជាសម្លេងទៅ',
    dateTime: DateTime.fromMillisecondsSinceEpoch(1312908481000),
  ),
  ChatObject(
    imageUrl: 'assets/images/travenx_180.png',
    title: 'ឈ្មោះកន្លែង',
    latestMessage: 'Text Over Flow testing if working',
    dateTime: DateTime.now(),
  ),
  ChatObject(
    imageUrl: 'assets/images/travenx_180.png',
    title: 'ឈ្មោះកន្លែង',
    latestMessage: '',
    dateTime: DateTime.fromMillisecondsSinceEpoch(1312908481000),
  ),
  ChatObject(
    imageUrl: 'assets/images/travenx_180.png',
    title: 'ឈ្មោះកន្លែង',
    latestMessage: 'ផ្ញើរសារជាសម្លេង',
    dateTime: DateTime.now(),
    read: false,
  ),
  ChatObject(
    imageUrl: 'assets/images/travenx_180.png',
    title: 'ឈ្មោះកន្លែង',
    latestMessage: 'នៅមានបង',
    dateTime: DateTime.fromMillisecondsSinceEpoch(1312908481000),
  ),
  ChatObject(
    imageUrl: 'assets/images/travenx_180.png',
    title: 'ឈ្មោះកន្លែង',
    latestMessage: 'មានអត់បងឯង',
    dateTime: DateTime.now(),
  ),
  ChatObject(
    imageUrl: 'assets/images/travenx_180.png',
    title: 'ឈ្មោះកន្លែង',
    latestMessage: 'អ្នកបានផ្ញើរសារជាសម្លេងទៅ',
    dateTime: DateTime.fromMillisecondsSinceEpoch(1312908481000),
  ),
];
