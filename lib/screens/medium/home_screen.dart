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
            flex: 1,
            child: Container(
              color: Colors.orangeAccent.shade200,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.orangeAccent.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
