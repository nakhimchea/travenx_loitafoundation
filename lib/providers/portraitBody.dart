import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/variable.dart';
import 'package:travenx_loitafoundation/icons/icons.dart';
import 'package:travenx_loitafoundation/screens/portrait/screens.dart';

import 'custom_nav_bar.dart';

class PortraitBody extends StatefulWidget {
  const PortraitBody({Key? key}) : super(key: key);

  @override
  _PortraitBodyState createState() => _PortraitBodyState();
}

class _PortraitBodyState extends State<PortraitBody> {
  final List<Widget> _screens = [
    HomeScreen(),
    ChatScreen(),
    WalletScreen(),
    ProfileScreen(),
  ];

  final Map<String, List<IconData>> _icons = const {
    'ទំព័រដើម': [CustomOutlinedIcons.home, CustomFilledIcons.home],
    'សារ': [CustomOutlinedIcons.message, CustomFilledIcons.message],
    'កាបូប': [CustomOutlinedIcons.wallet, CustomFilledIcons.wallet],
    'គណនី': [CustomOutlinedIcons.user, CustomFilledIcons.user],
  };

  @override
  Widget build(BuildContext context) {
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
