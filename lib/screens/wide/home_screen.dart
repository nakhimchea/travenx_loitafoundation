import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.orangeAccent.shade200,
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              color: Colors.orangeAccent.shade700,
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.orangeAccent,
            ),
          ),
        ],
      ),
    );
  }
}
