import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travenx_loitafoundation/config/variable.dart';
import 'package:travenx_loitafoundation/icons/icons.dart';
import 'package:travenx_loitafoundation/providers/custom_nav_bar.dart';
import 'package:travenx_loitafoundation/screens/portrait/screens.dart';

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

  @override
  Widget build(BuildContext context) {
    final Map<String, List<IconData>> _icons = {
      AppLocalizations.of(context)!.bNavHome: [
        CustomOutlinedIcons.home,
        CustomFilledIcons.home
      ],
      AppLocalizations.of(context)!.bNavChat: [
        CustomOutlinedIcons.message,
        CustomFilledIcons.message
      ],
      AppLocalizations.of(context)!.bNavWallet: [
        CustomOutlinedIcons.wallet,
        CustomFilledIcons.wallet
      ],
      AppLocalizations.of(context)!.bNavAccount: [
        CustomOutlinedIcons.user,
        CustomFilledIcons.user
      ],
    };

    setState(() => _screens = [
          HomeScreen(),
          ChatScreen(
              isLoggedIn: widget.isLoggedIn,
              displayName: widget.displayName,
              profileUrl: widget.profileUrl,
              loggedInCallback: widget.loggedInCallback),
          WalletScreen(
              isLoggedIn: widget.isLoggedIn,
              displayName: widget.displayName,
              profileUrl: widget.profileUrl,
              loggedInCallback: widget.loggedInCallback),
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
        body: IndexedStack(
          index: selectedIndex,
          children: _screens,
        ),
        bottomNavigationBar: Container(
          padding: !kIsWeb && Platform.isIOS
              ? const EdgeInsets.only(bottom: 10.0)
              : EdgeInsets.zero,
          color: Theme.of(context).bottomAppBarColor,
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
