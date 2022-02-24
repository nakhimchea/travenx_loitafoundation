import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, kVPadding, textScaleFactor;
import 'package:travenx_loitafoundation/services/firestore_service.dart';

class Chat extends StatefulWidget {
  final String postTitle;
  final String postImageUrl;
  final String userId;
  final String clientId;
  final String postId;
  final String clientDisplayName;
  final String clientPhoneNumber;
  final String clientProfileUrl;
  const Chat({
    Key? key,
    required this.postTitle,
    required this.postImageUrl,
    required this.userId,
    required this.clientId,
    required this.postId,
    required this.clientDisplayName,
    required this.clientPhoneNumber,
    required this.clientProfileUrl,
  }) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Theme.of(context).colorScheme.brightness,
        backgroundColor: Theme.of(context).bottomAppBarColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).iconTheme.color,
            size: 18.0,
          ),
        ),
        title: Text(
          widget.postTitle,
          textScaleFactor: textScaleFactor,
          style: Theme.of(context).textTheme.headline3,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: kHPadding),
            child: GestureDetector(
                onTap: () => print('Profile Clicked...'),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 12.0,
                    top: 6.0,
                    bottom: 6.0,
                  ),
                  child: ClipOval(
                    child: widget.postImageUrl.split('/').first == 'assets'
                        ? Image(
                            image: AssetImage(widget.postImageUrl),
                            fit: BoxFit.cover,
                          )
                        : CachedNetworkImage(
                            imageUrl: widget.postImageUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, _) => ImageFiltered(
                              imageFilter:
                                  ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Image.asset(
                                'assets/images/travenx_180.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            errorWidget: (context, _, __) => Image.asset(
                              'assets/images/travenx_180.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                )),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MessageStreamer(),
            MessageSender(
              userId: widget.userId,
              clientId: widget.clientId,
              postId: widget.postId,
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStreamer extends StatelessWidget {
  const MessageStreamer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
    //StreamBuilder<QuerySnapshot>(
    //       stream: _firestore.collection('messages').snapshots(),
    //       builder: (context, snapshot) {
    //         if (!snapshot.hasData) {
    //           return Center(
    //             child: CircularProgressIndicator(
    //               backgroundColor: Colors.lightBlueAccent,
    //             ),
    //           );
    //         }
    //         final messages = snapshot.data.documents.reversed;
    //         List<MessageBubble> messageBubbles = [];
    //         for (var message in messages) {
    //           final messageText = message.data['text'];
    //           final messageSender = message.data['sender'];
    //
    //           final currentUser = loggedInUser.email;
    //
    //           final messageBubble = MessageBubble(
    //             sender: messageSender,
    //             text: messageText,
    //             isMe: currentUser == messageSender,
    //           );
    //
    //           messageBubbles.add(messageBubble);
    //         }
    //         return Expanded(
    //           child: ListView(
    //             reverse: true,
    //             padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
    //             children: messageBubbles,
    //           ),
    //         );
    //       },
    //     )
  }
}

class MessageBubble extends StatelessWidget {
  final String sender;
  final String text;
  final bool isMe;

  const MessageBubble({
    Key? key,
    required this.sender,
    required this.text,
    required this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0))
                : BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
            color: isMe
                ? Theme.of(context).primaryColor.withOpacity(0.7)
                : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black54,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageSender extends StatefulWidget {
  final String userId;
  final String clientId;
  final String postId;

  const MessageSender({
    Key? key,
    required this.userId,
    required this.clientId,
    required this.postId,
  }) : super(key: key);

  @override
  _MessageSenderState createState() => _MessageSenderState();
}

class _MessageSenderState extends State<MessageSender> {
  final TextEditingController _sendingMessageController =
      TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();

  String _message = '';
  bool _sendTapped = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kHPadding,
        vertical: kVPadding,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: _sendingMessageController,
              onChanged: (text) => setState(() => _message = text),
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Theme.of(context).iconTheme.color),
              autocorrect: false,
              enableSuggestions: false,
              cursorHeight: Theme.of(context).textTheme.bodyText1!.fontSize,
              decoration: InputDecoration(
                hintText: 'Aa',
                hintStyle: Theme.of(context).textTheme.bodyText1,
                fillColor: Theme.of(context).scaffoldBackgroundColor,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: kHPadding),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryIconTheme.color!,
                      width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryIconTheme.color!,
                      width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
              ),
            ),
          ),
          SizedBox(width: _message != '' ? kHPadding : 0.0),
          _message != ''
              ? GestureDetector(
                  onLongPress: () => setState(() => _sendTapped = true),
                  onLongPressEnd: (_) => setState(() => _sendTapped = false),
                  onTap: () async {
                    setState(() => _sendTapped = true);
                    _sendingMessageController.clear();
                    if (_message != '')
                      await _firestoreService
                          .getProfileData(widget.userId)
                          .then((DocumentSnapshot<Map<String, dynamic>>
                                  documentSnapshot) async =>
                              await _firestoreService.addChatMessage(
                                widget.userId,
                                widget.clientId,
                                widget.postId,
                                documentSnapshot.get('displayName'),
                                documentSnapshot.get('profileUrl'),
                                _message,
                              ))
                          .catchError((e) {
                        print('Cannot send a message: ${e.toString()}');
                      });
                    setState(() {
                      _message = '';
                      _sendTapped = false;
                    });
                  },
                  child: Icon(
                    Icons.send_rounded,
                    size: 32.0,
                    color: _sendTapped
                        ? Theme.of(context).primaryIconTheme.color
                        : Theme.of(context).primaryColor,
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
