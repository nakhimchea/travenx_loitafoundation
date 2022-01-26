import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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

  String _displayName = '';
  String _phoneNumber = '';
  String _profileUrl = '';
  String _backgroundUrl = '';

  void _getProfileData() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final FlutterSecureStorage _secureStorage = FlutterSecureStorage(
        iOptions:
            IOSOptions(accessibility: IOSAccessibility.unlocked_this_device),
        aOptions: AndroidOptions(encryptedSharedPreferences: true));

    Map<String, dynamic> _profileData = await _firestore
        .collection('profile_screen')
        .doc(await _secureStorage.read(key: 'userId'))
        .get()
        .then((snapshot) => snapshot.data()!);

    setState(() {
      _displayName = _profileData['displayName'];
      _phoneNumber = _profileData['phoneNumber'];
      _profileUrl = _profileData['profileUrl'];
      _backgroundUrl = _profileData['backgroundUrl'];
    });
  }

  void _cleanProfileData() async {
    setState(() {
      _displayName = '';
      _phoneNumber = '';
      _profileUrl = '';
      _backgroundUrl = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !_isLoggedIn
          ? Login(
              loggedInCallback: _toggleLoggedIn,
              setProfileCallback: _getProfileData,
            )
          : Profile(
              loggedInCallback: _toggleLoggedIn,
              displayName: _displayName,
              phoneNumber: _phoneNumber,
              profileUrl: _profileUrl,
              backgroundUrl: _backgroundUrl,
              cleanProfileCallback: _cleanProfileData,
            ),
    );
  }
}
