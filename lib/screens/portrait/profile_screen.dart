import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/screens/portrait/profile_screen/login.dart';
import 'package:travenx_loitafoundation/screens/portrait/profile_screen/profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoggedIn = false;

  void _toggleLoggedIn() => setState(() => _isLoggedIn = !_isLoggedIn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !_isLoggedIn
          ? Login(loggedInCallback: _toggleLoggedIn)
          : Profile(loggedInCallback: _toggleLoggedIn),
    );
  }
}
