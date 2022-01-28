import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/screens/wide/profile_layout/profile_layout.dart';

class ChatScreen extends StatefulWidget {
  final bool isLoggedIn;
  final String displayName;
  final String phoneNumber;
  final String profileUrl;
  final String backgroundUrl;
  final void Function() cleanProfileCallback;
  final void Function() loggedInCallback;
  final void Function() getProfileCallback;
  const ChatScreen({
    Key? key,
    required this.isLoggedIn,
    required this.displayName,
    required this.phoneNumber,
    required this.profileUrl,
    required this.backgroundUrl,
    required this.cleanProfileCallback,
    required this.loggedInCallback,
    required this.getProfileCallback,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: ProfileLayout(
              isLoggedIn: widget.isLoggedIn,
              displayName: widget.displayName,
              phoneNumber: widget.phoneNumber,
              profileUrl: widget.profileUrl,
              backgroundUrl: widget.backgroundUrl,
              cleanProfileCallback: widget.cleanProfileCallback,
              loggedInCallback: widget.loggedInCallback,
              getProfileCallback: widget.getProfileCallback,
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.purple.shade800,
            ),
          ),
        ],
      ),
    );
  }
}
