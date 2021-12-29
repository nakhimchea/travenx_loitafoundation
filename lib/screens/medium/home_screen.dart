import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
            child: Container(
              height: double.infinity,
              color: Colors.orange.shade800,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}
