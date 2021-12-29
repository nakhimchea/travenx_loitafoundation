import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/variable.dart';
import 'package:travenx_loitafoundation/icons/icons.dart';
import 'package:travenx_loitafoundation/screens/medium/screens.dart';

import 'custom_nav_bar.dart';

class MediumBody extends StatefulWidget {
  const MediumBody({Key? key}) : super(key: key);

  @override
  _MediumBodyState createState() => _MediumBodyState();
}

class _MediumBodyState extends State<MediumBody> {
  final List<Widget> _screens = [
    HomeScreen(),
    ChatScreen(),
    WalletScreen(),
  ];

  final Map<String, List<IconData>> _icons = const {
    'ទំព័រដើម': [CustomOutlinedIcons.home, CustomFilledIcons.home],
    'សារ': [CustomOutlinedIcons.message, CustomFilledIcons.message],
    'កាបូប': [CustomOutlinedIcons.wallet, CustomFilledIcons.wallet],
  };

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _icons.length,
      child: Scaffold(
        backgroundColor: Theme.of(context).bottomAppBarColor,
        body: IndexedStack(
          index: selectedIndex >= 3 ? 0 : selectedIndex,
          children: _screens,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: CustomNavBar(
            icons: _icons,
            selectedIndex: selectedIndex >= 3 ? 0 : selectedIndex,
            onTap: (index) => setState(() => selectedIndex = index),
          ),
        ),
      ),
    );
  }
}
