import 'dart:io' show Platform;

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travenx_loitafoundation/config/variable.dart'
    show selectedIndex, displayScaleFactor;
import 'package:travenx_loitafoundation/icons/icons.dart';
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
      child: Container(
        color: Theme.of(context).bottomAppBarColor,
        child: SafeArea(
          top: false,
          left: false,
          right: false,
          child: ClipRect(
            child: Scaffold(
              extendBody: true,
              body: IndexedStack(
                index: selectedIndex,
                children: _screens,
              ),
              bottomNavigationBar: CurvedNavigationBar(
                color: Theme.of(context).bottomAppBarColor,
                buttonBackgroundColor: Colors.white.withOpacity(0.7),
                backgroundColor: Colors.transparent,
                index: selectedIndex,
                onTap: (index) => setState(() => selectedIndex = index),
                height: !kIsWeb && Platform.isIOS ? 50 : 60,
                animationCurve: Curves.easeInOutExpo,
                animationDuration: Duration(milliseconds: 400),
                items: _icons
                    .map(
                      (key, icon) => MapEntry(
                        key,
                        Icon(
                          key == _icons.keys.elementAt(selectedIndex)
                              ? icon[1]
                              : icon[0],
                          color: key == _icons.keys.elementAt(selectedIndex)
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).iconTheme.color,
                          size: icon[0] == CustomOutlinedIcons.wallet ||
                                  icon[1] == CustomFilledIcons.wallet
                              ? 26.0 * displayScaleFactor
                              : icon[0] == CustomOutlinedIcons.user ||
                                      icon[1] == CustomFilledIcons.user ||
                                      icon[0] == CustomOutlinedIcons.message ||
                                      icon[1] == CustomFilledIcons.message
                                  ? 29.0 * displayScaleFactor
                                  : 30.0 * displayScaleFactor,
                        ),
                      ),
                    )
                    .values
                    .toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
