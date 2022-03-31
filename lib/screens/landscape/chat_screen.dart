import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
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
            child: Container(),
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
