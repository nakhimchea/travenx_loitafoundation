import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:travenx_loitafoundation/config/palette.dart';
import 'package:travenx_loitafoundation/config/variable.dart';
import 'package:travenx_loitafoundation/providers/responsive_widget.dart';
import 'package:travenx_loitafoundation/providers/theme_provider.dart';
import 'package:travenx_loitafoundation/widgets/custom_loading.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
      apiKey: "AIzaSyAdhhJKdC5-eH66MjJelC-VEeEaez4Xu0M",
      authDomain: "travenx.firebaseapp.com",
      projectId: "travenx",
      storageBucket: "travenx.appspot.com",
      messagingSenderId: "757818286951",
      appId: "1:757818286951:web:190a57f5758f8047b905c2",
      measurementId: "G-49E7VYY6B6",
    ));
    // FacebookAuth.instance.webInitialize(
    //   appId: "307510611301408",
    //   cookie: true,
    //   xfbml: true,
    //   version: "v12.0",
    // );
  } else
    await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Travenx',
          themeMode: themeProvider.themeMode,
          theme: Travenx.lightTheme,
          darkTheme: Travenx.darkTheme,
          home: ResponsiveDecider(),
        );
      },
    );
  }
}

class ResponsiveDecider extends StatefulWidget {
  const ResponsiveDecider({Key? key}) : super(key: key);

  @override
  _ResponsiveDeciderState createState() => _ResponsiveDeciderState();
}

class _ResponsiveDeciderState extends State<ResponsiveDecider> {
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

    try {
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
    } catch (e) {
      print(e);
    }
  }

  void _cleanProfileData() async {
    setState(() {
      _displayName = '';
      _phoneNumber = '';
      _profileUrl = '';
      _backgroundUrl = '';
    });
  }

  void _onRefresh() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final FlutterSecureStorage _secureStorage = FlutterSecureStorage(
        iOptions:
            IOSOptions(accessibility: IOSAccessibility.unlocked_this_device),
        aOptions: AndroidOptions(encryptedSharedPreferences: true));

    try {
      if (await _secureStorage.read(key: 'isAnonymous') == 'false') {
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
          _isLoggedIn = true;
        });
      }
    } catch (e) {
      print('Cannot read isAnonymous key: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _onRefresh();
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    textScaleFactor = MediaQuery.of(context).size.width / 375;
    textScaleFactor = textScaleFactor > 1.5 ? 1.5 : textScaleFactor;

    Future.delayed(Duration(seconds: 2))
        .whenComplete(() => setState(() => _isLoading = false));

    return _isLoading
        ? LayoutBuilder(
            builder: (context, constraints) => Scaffold(
              body: Stack(
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/profile_screen/scaffold_background.png',
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(top: 80.0),
                      child: Text(
                        'Travenx',
                        textScaleFactor: textScaleFactor,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 36.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Loading(color: Palette.priceColor),
                ],
              ),
            ),
          )
        : ResponsiveLayout(
            portraitBody: PortraitBody(
              isLoggedIn: _isLoggedIn,
              displayName: _displayName,
              phoneNumber: _phoneNumber,
              profileUrl: _profileUrl,
              backgroundUrl: _backgroundUrl,
              cleanProfileCallback: _cleanProfileData,
              loggedInCallback: _toggleLoggedIn,
              getProfileCallback: _getProfileData,
            ),
            mediumBody: MediumBody(
              isLoggedIn: _isLoggedIn,
              displayName: _displayName,
              phoneNumber: _phoneNumber,
              profileUrl: _profileUrl,
              backgroundUrl: _backgroundUrl,
              cleanProfileCallback: _cleanProfileData,
              loggedInCallback: _toggleLoggedIn,
              getProfileCallback: _getProfileData,
            ),
            landscapeBody: LandscapeBody(),
          );
  }
}
