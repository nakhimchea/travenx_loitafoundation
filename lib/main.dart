import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:travenx_loitafoundation/config/variable.dart';
import 'package:travenx_loitafoundation/l10n/locales.dart';
import 'package:travenx_loitafoundation/providers/locale_provider.dart';
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
      appId: "1:757818286951:web:d119de9781b96542b905c2",
      measurementId: "G-4CHGQ6GHEX",
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider<LocaleProvider>(
          create: (context) => LocaleProvider(),
        ),
      ],
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        final localeProvider = Provider.of<LocaleProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Travenx',
          locale:
              localeProvider.locale ?? Locale.fromSubtags(languageCode: 'km'),
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: Locales.languages,
          themeMode: ThemeMode.light,
          theme: themeProvider.themeOption,
          darkTheme: Travenx.themeDarkGrey,
          home: ResponsiveDecider(),
          scrollBehavior: CustomScrollBehavior(),
        );
      },
    );
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => <PointerDeviceKind>{
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.invertedStylus,
        PointerDeviceKind.unknown,
      };
}

class ResponsiveDecider extends StatefulWidget {
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
      if (await _secureStorage.read(key: 'owmKey') == null)
        await _secureStorage.write(
            key: 'owmKey',
            value: await _firestore
                .collection('api_keys')
                .doc('owm')
                .get()
                .then((snapshot) => snapshot.get('key').toString()));

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

  bool _isLoading = false; //TODO: change this to true when app completed

  @override
  Widget build(BuildContext context) {
    displayScaleFactor = MediaQuery.of(context).size.width / 375;
    displayScaleFactor = displayScaleFactor > 1.5 ? 1.5 : displayScaleFactor;

    Future.delayed(const Duration(seconds: 2))
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
                          'assets/images/travenx.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(top: 80.0),
                      child: Text(
                        'Travenx',
                        textScaleFactor: displayScaleFactor,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 36.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Loading(color: Theme.of(context).highlightColor),
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
            landscapeBody: LandscapeBody(
              isLoggedIn: _isLoggedIn,
              displayName: _displayName,
              phoneNumber: _phoneNumber,
              profileUrl: _profileUrl,
              backgroundUrl: _backgroundUrl,
              cleanProfileCallback: _cleanProfileData,
              loggedInCallback: _toggleLoggedIn,
              getProfileCallback: _getProfileData,
            ),
            wideBody: WideBody(
              isLoggedIn: _isLoggedIn,
              displayName: _displayName,
              phoneNumber: _phoneNumber,
              profileUrl: _profileUrl,
              backgroundUrl: _backgroundUrl,
              cleanProfileCallback: _cleanProfileData,
              loggedInCallback: _toggleLoggedIn,
              getProfileCallback: _getProfileData,
            ),
          );
  }
}
