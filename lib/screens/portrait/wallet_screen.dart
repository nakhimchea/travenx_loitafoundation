import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => Image.asset(
          'assets/images/profile_screen/scaffold_background.png',
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
