import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/variable.dart';
import 'package:travenx_loitafoundation/icons/icons.dart';
import 'package:travenx_loitafoundation/screens/portrait/screens.dart';

import 'custom_nav_bar.dart';

class PortraitBody extends StatefulWidget {
  final bool isLoggedIn;
  final String displayName;
  final String phoneNumber;
  final String profileUrl;
  final String backgroundUrl;
  final void Function() cleanProfileCallback;
  final void Function() loggedInCallback;
  final void Function() getProfileCallback;
  const PortraitBody({
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
  _PortraitBodyState createState() => _PortraitBodyState();
}

class _PortraitBodyState extends State<PortraitBody> {
  List<Widget> _screens = [];

  final Map<String, List<IconData>> _icons = const {
    'ទំព័រដើម': [CustomOutlinedIcons.home, CustomFilledIcons.home],
    'សារ': [CustomOutlinedIcons.message, CustomFilledIcons.message],
    'កាបូប': [CustomOutlinedIcons.wallet, CustomFilledIcons.wallet],
    'គណនី': [CustomOutlinedIcons.user, CustomFilledIcons.user],
  };

  @override
  Widget build(BuildContext context) {
    setState(() => _screens = [
          HomeScreen(),
          ChatScreen(),
          WalletScreen(),
          ProfileScreen(
              isLoggedIn: widget.isLoggedIn,
              displayName: widget.displayName,
              phoneNumber: widget.phoneNumber,
              profileUrl: widget.profileUrl,
              backgroundUrl: widget.backgroundUrl,
              cleanProfileCallback: widget.cleanProfileCallback,
              loggedInCallback: widget.loggedInCallback,
              getProfileCallback: widget.getProfileCallback),
        ]);
    return DefaultTabController(
      length: _icons.length,
      child: Scaffold(
        backgroundColor: Theme.of(context).bottomAppBarColor,
        body: IndexedStack(
          index: selectedIndex,
          children: _screens,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: CustomNavBar(
            icons: _icons,
            selectedIndex: selectedIndex,
            onTap: (index) => setState(() => selectedIndex = index),
          ),
        ),
      ),
    );
  }
}
