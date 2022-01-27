import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.purple.shade800,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(),
          ),
          Expanded(
            child: Container(
              color: Colors.purple.shade800,
            ),
          ),
        ],
      ),
    );
  }
}
