import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, textScaleFactor;

class Chat extends StatefulWidget {
  final String postTitle;
  final String postImageUrl;
  const Chat({
    Key? key,
    required this.postTitle,
    required this.postImageUrl,
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
            MessageSender(),
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

class MessageSender extends StatelessWidget {
  const MessageSender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _sendingMessageController =
        TextEditingController();

    String _message = '';

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: _sendingMessageController,
              onChanged: (text) {
                _message = text;
              },
              decoration: InputDecoration(
                hintText: 'Enter a value',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              _sendingMessageController.clear();
              //TODO: Add message to FireStore
            },
            child: Text(
              'Send',
              style: TextStyle(
                color: Colors.lightBlueAccent,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
