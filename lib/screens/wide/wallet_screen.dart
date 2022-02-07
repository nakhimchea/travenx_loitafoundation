import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/screens/wide/profile_layout/profile_layout.dart';

class WalletScreen extends StatefulWidget {
  final bool isLoggedIn;
  final String displayName;
  final String phoneNumber;
  final String profileUrl;
  final String backgroundUrl;
  final void Function() cleanProfileCallback;
  final void Function() loggedInCallback;
  final void Function() getProfileCallback;
  const WalletScreen({
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
            child: Container(
              child: LayoutBuilder(
                builder: (context, constraints) => Image.asset(
                  'assets/images/profile_screen/scaffold_background.png',
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: LayoutBuilder(
                builder: (context, constraints) => Image.asset(
                  'assets/images/profile_screen/scaffold_background.png',
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
