import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/screens/portrait/profile_screen/login.dart';
import 'package:travenx_loitafoundation/screens/portrait/profile_screen/profile.dart';

class ProfileScreen extends StatefulWidget {
  final bool isLoggedIn;
  final String displayName;
  final String phoneNumber;
  final String profileUrl;
  final String backgroundUrl;
  final void Function() cleanProfileCallback;
  final void Function() loggedInCallback;
  final void Function() getProfileCallback;
  final void Function() toggleNeedRefresh;
  const ProfileScreen({
    Key? key,
    required this.isLoggedIn,
    required this.displayName,
    required this.phoneNumber,
    required this.profileUrl,
    required this.backgroundUrl,
    required this.cleanProfileCallback,
    required this.loggedInCallback,
    required this.getProfileCallback,
    required this.toggleNeedRefresh,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !widget.isLoggedIn
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
              toggleNeedRefresh: widget.toggleNeedRefresh),
    );
  }
}
