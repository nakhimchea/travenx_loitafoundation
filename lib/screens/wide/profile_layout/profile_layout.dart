import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/screens/wide/profile_layout/login.dart';
import 'package:travenx_loitafoundation/screens/wide/profile_layout/profile.dart';

class ProfileLayout extends StatefulWidget {
  final bool isLoggedIn;
  final String displayName;
  final String phoneNumber;
  final String profileUrl;
  final String backgroundUrl;
  final void Function() cleanProfileCallback;
  final void Function() loggedInCallback;
  final void Function() getProfileCallback;
  const ProfileLayout({
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
  _ProfileLayoutState createState() => _ProfileLayoutState();
}

class _ProfileLayoutState extends State<ProfileLayout> {
  @override
  Widget build(BuildContext context) {
    return !widget.isLoggedIn
        ? Login(
            loggedInCallback: widget.loggedInCallback,
            getProfileCallback: widget.getProfileCallback,
          )
        : Profile(
            loggedInCallback: widget.loggedInCallback,
            displayName: widget.displayName,
            phoneNumber: widget.phoneNumber,
            profileUrl: widget.profileUrl,
            backgroundUrl: widget.backgroundUrl,
            cleanProfileCallback: widget.cleanProfileCallback,
          );
  }
}
