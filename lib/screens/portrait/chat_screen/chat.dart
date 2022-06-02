import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart'
    show kHPadding, kVPadding, textScaleFactor;
import 'package:travenx_loitafoundation/services/firestore_service.dart';

final FirestoreService _firestoreService = FirestoreService();

class Chat extends StatefulWidget {
  final String postTitle;
  final String postImageUrl;
  final String userId;
  final String userDisplayName;
  final String userProfileUrl;
  final String postId;
  final String withUserId;
  final String withDisplayName;
  final String withPhoneNumber;
  final String withProfileUrl;
  const Chat({
    Key? key,
    required this.postTitle,
    required this.postImageUrl,
    required this.userId,
    required this.userDisplayName,
    required this.userProfileUrl,
    required this.postId,
    required this.withUserId,
    required this.withDisplayName,
    required this.withPhoneNumber,
    required this.withProfileUrl,
  }) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).bottomAppBarColor,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          highlightColor: Colors.transparent,
          hoverColor:
              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
          splashColor:
              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).iconTheme.color,
            size: 18.0,
          ),
        ),
        title: Text(
          widget.postTitle,
          textScaleFactor: textScaleFactor,
          style: Theme.of(context).textTheme.displaySmall,
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
                        ? Image.asset(
                            widget.postImageUrl,
                            width: 45,
                            height: 45,
                            fit: BoxFit.cover,
                          )
                        : CachedNetworkImage(
                            imageUrl: widget.postImageUrl,
                            width: 45,
                            height: 45,
                            fit: BoxFit.cover,
                            placeholder: (context, _) => ImageFiltered(
                              imageFilter:
                                  ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Image.asset(
                                'assets/images/travenx_180.png',
                                width: 45,
                                height: 45,
                                fit: BoxFit.cover,
                              ),
                            ),
                            errorWidget: (context, _, __) => Image.asset(
                              'assets/images/travenx_180.png',
                              width: 45,
                              height: 45,
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
            _MessageStreamer(
              userId: widget.userId,
              userDisplayName: widget.userDisplayName,
              userProfileUrl: widget.userProfileUrl,
              postId: widget.postId,
              withUserId: widget.withUserId,
              withDisplayName: widget.withDisplayName,
              withProfileUrl: widget.withProfileUrl,
            ),
            _MessageSender(
              userId: widget.userId,
              withUserId: widget.withUserId,
              postId: widget.postId,
              currentUserDisplayName: widget.userDisplayName,
              currentUserProfileUrl: widget.userProfileUrl,
            ), // Cannot chat if currentUser is null
          ],
        ),
      ),
    );
  }
}

class _MessageStreamer extends StatelessWidget {
  final String userId;
  final String userDisplayName;
  final String userProfileUrl;
  final String postId;
  final String withUserId;
  final String withDisplayName;
  final String withProfileUrl;
  const _MessageStreamer({
    Key? key,
    required this.userId,
    required this.userDisplayName,
    required this.userProfileUrl,
    required this.postId,
    required this.withUserId,
    required this.withDisplayName,
    required this.withProfileUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestoreService.getMessages(userId, postId, withUserId),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (!snapshot.hasData)
          return const Center(child: CircularProgressIndicator.adaptive());

        final _messages = snapshot.data!.docs;
        List<_MessageBubble> _messageBubbles = [];
        for (var _message in _messages) {
          final senderUid = _message.get('senderUid');
          final senderName = _message.get('senderName');
          final senderProfileUrl = _message.get('senderProfileUrl');
          final message = _message.get('message');
          final attachmentUrl = _message.get('attachmentUrl');
          final dateTime = DateTime.fromMillisecondsSinceEpoch(
              int.parse(_message.get('dateTime').toString()));

          _messageBubbles.add(_MessageBubble(
            senderName: senderName,
            senderProfileUrl: senderProfileUrl,
            message: message,
            attachmentUrl: attachmentUrl,
            dateTime: dateTime,
            isMe: senderUid == userId,
          ));
        }

        return Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            reverse: true,
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: _messageBubbles,
          ),
        );
      },
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final String senderName;
  final String senderProfileUrl;
  final String message;
  final String attachmentUrl;
  final DateTime dateTime;
  final bool isMe;

  const _MessageBubble({
    Key? key,
    required this.senderName,
    required this.senderProfileUrl,
    required this.message,
    required this.attachmentUrl,
    required this.dateTime,
    required this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            senderName,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Material(
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0))
                : const BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
            color: isMe
                ? Theme.of(context).primaryColor.withOpacity(0.7)
                : Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                message,
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

class _MessageSender extends StatefulWidget {
  final String userId;
  final String withUserId;
  final String postId;
  final String currentUserDisplayName;
  final String currentUserProfileUrl;

  const _MessageSender({
    Key? key,
    required this.userId,
    required this.withUserId,
    required this.postId,
    required this.currentUserDisplayName,
    required this.currentUserProfileUrl,
  }) : super(key: key);

  @override
  _MessageSenderState createState() => _MessageSenderState();
}

class _MessageSenderState extends State<_MessageSender> {
  final TextEditingController _sendingMessageController =
      TextEditingController();

  String _message = '';
  String _attachmentUrl = '';
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
              cursorHeight: Theme.of(context).textTheme.bodyLarge!.fontSize,
              decoration: InputDecoration(
                hintText: 'Aa',
                hintStyle: Theme.of(context).textTheme.bodyLarge,
                fillColor: Theme.of(context).scaffoldBackgroundColor,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: kHPadding),
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryIconTheme.color!,
                      width: 1.0),
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryIconTheme.color!,
                      width: 1.0),
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1.0),
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
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
                          .addChatMessage(
                        widget.userId,
                        widget.withUserId,
                        widget.postId,
                        widget.currentUserDisplayName,
                        widget.currentUserProfileUrl,
                        _message,
                        _attachmentUrl,
                      )
                          .catchError((e) {
                        print('Cannot send a message: ${e.toString()}');
                      });
                    setState(() {
                      _message = '';
                      _attachmentUrl = '';
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
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
