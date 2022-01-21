import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';
import 'package:travenx_loitafoundation/config/variable.dart';
import 'package:travenx_loitafoundation/providers/responsive_widget.dart';
import 'package:travenx_loitafoundation/providers/theme_provider.dart';

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
    FacebookAuth.instance.webInitialize(
      appId: "307510611301408",
      cookie: true,
      xfbml: true,
      version: "v12.0",
    );
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
  @override
  Widget build(BuildContext context) {
    textScaleFactor =
        MediaQuery.of(context).size.height > MediaQuery.of(context).size.width
            ? MediaQuery.of(context).size.width / 375
            : MediaQuery.of(context).size.height / 667;
    textScaleFactor = textScaleFactor > 1.5 ? 1.5 : textScaleFactor;

    return ResponsiveLayout(
      portraitBody: PortraitBody(),
      mediumBody: MediumBody(),
      landscapeBody: LandscapeBody(),
    );
  }
}
