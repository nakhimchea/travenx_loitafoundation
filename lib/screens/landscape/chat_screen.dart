import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.purpleAccent.shade200,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.purpleAccent.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
