import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode? themeMode;

  bool get isLightMode => themeMode == ThemeMode.light;

  void toggleTheme(bool isOff) {
    themeMode = isOff ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}

class Travenx {
  static final themeLightGrey = ThemeData(
    primaryColor: Palette.primary,
    focusColor: Color(0),
    hoverColor: Color(0),
    shadowColor: Color(0),
    canvasColor: Colors.white,
    scaffoldBackgroundColor: Color(0xFFF6F8FA),
    bottomAppBarColor: Colors.white,
    cardColor: Color(0xFFFCF4E9),
    dividerColor: Color(0),
    highlightColor: Palette.secondary,
    splashColor: Color(0),
    selectedRowColor: Color(0),
    unselectedWidgetColor: Color(0),
    disabledColor: Color(0xFFDADADA),
    secondaryHeaderColor: Color(0),
    backgroundColor: Color(0),
    dialogBackgroundColor: Color(0),
    indicatorColor: Color(0),
    hintColor: Palette.tertiary,
    errorColor: Palette.quaternary,
    toggleableActiveColor: Color(0),
    primaryIconTheme: IconThemeData(color: Colors.black),
    iconTheme: IconThemeData(color: Color(0xFF91949A)),
    primaryTextTheme: TextTheme(
      displayLarge: kDisplayPTextStyle.copyWith(
        color: Colors.black,
        fontSize: 28.0,
      ),
      displayMedium: kDisplayPTextStyle.copyWith(
        color: Colors.black,
        fontSize: 24.0,
      ),
      displaySmall: kDisplayPTextStyle.copyWith(
        color: Colors.black,
        fontSize: 20.0,
      ),
      titleLarge: kTitlePTextStyle.copyWith(
        color: Colors.black,
        fontSize: 18.0,
      ),
      titleMedium: kTitlePTextStyle.copyWith(
        color: Colors.black,
        fontSize: 16.0,
      ),
      titleSmall: kTitlePTextStyle.copyWith(
        color: Colors.black,
        fontSize: 14.0,
      ),
      headlineLarge: kHeadlinePTextStyle.copyWith(
        color: Color(0xFF91949A),
        fontSize: 16.0,
      ),
      headlineMedium: kHeadlinePTextStyle.copyWith(
        color: Color(0xFF91949A),
        fontSize: 14.0,
      ),
      headlineSmall: kHeadlinePTextStyle.copyWith(
        color: Color(0xFF91949A),
        fontSize: 12.0,
      ),
      labelLarge: kLabelPTextStyle.copyWith(
        color: Color(0xFF91949A),
        fontSize: 22.0,
      ),
      labelMedium: kLabelPTextStyle.copyWith(
        color: Color(0xFF91949A),
        fontSize: 20.0,
      ),
      labelSmall: kLabelPTextStyle.copyWith(
        color: Color(0xFF91949A),
        fontSize: 18.0,
      ),
      bodyLarge: kBodyPTextStyle.copyWith(
        color: Color(0xFF91949A),
        fontSize: 16.0,
      ),
      bodyMedium: kBodyPTextStyle.copyWith(
        color: Color(0xFF91949A),
        fontSize: 14.0,
      ),
      bodySmall: kBodyPTextStyle.copyWith(
        color: Color(0xFF91949A),
        fontSize: 12.0,
      ),
    ),
    textTheme: TextTheme(
      displayLarge: kDisplayTextStyle.copyWith(
        color: Colors.black,
        fontSize: 28.0,
      ),
      displayMedium: kDisplayTextStyle.copyWith(
        color: Colors.black,
        fontSize: 24.0,
      ),
      displaySmall: kDisplayTextStyle.copyWith(
        color: Colors.black,
        fontSize: 20.0,
      ),
      titleLarge: kTitleTextStyle.copyWith(
        color: Colors.black,
        fontSize: 18.0,
      ),
      titleMedium: kTitleTextStyle.copyWith(
        color: Colors.black,
        fontSize: 16.0,
      ),
      titleSmall: kTitleTextStyle.copyWith(
        color: Colors.black,
        fontSize: 14.0,
      ),
      headlineLarge: kHeadlineTextStyle.copyWith(
        color: Color(0xFF91949A),
        fontSize: 16.0,
      ),
      headlineMedium: kHeadlineTextStyle.copyWith(
        color: Color(0xFF91949A),
        fontSize: 14.0,
      ),
      headlineSmall: kHeadlineTextStyle.copyWith(
        color: Color(0xFF91949A),
        fontSize: 12.0,
      ),
      labelLarge: kLabelTextStyle.copyWith(
        color: Color(0xFF91949A),
        fontSize: 22.0,
      ),
      labelMedium: kLabelTextStyle.copyWith(
        color: Color(0xFF91949A),
        fontSize: 20.0,
      ),
      labelSmall: kLabelTextStyle.copyWith(
        color: Color(0xFF91949A),
        fontSize: 18.0,
      ),
      bodyLarge: kBodyTextStyle.copyWith(
        color: Color(0xFF91949A),
        fontSize: 16.0,
      ),
      bodyMedium: kBodyTextStyle.copyWith(
        color: Color(0xFF91949A),
        fontSize: 14.0,
      ),
      bodySmall: kBodyTextStyle.copyWith(
        color: Color(0xFF91949A),
        fontSize: 12.0,
      ),
    ),
    colorScheme: ColorScheme.light(),
  );

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFF101010),
    bottomAppBarColor: Colors.black,
    disabledColor: Color(0x33FFFFFF),
    cardColor: Color(0x66FCF4E9), // Only Announcement Card
    primaryColor: Palette.primary,
    hintColor: Palette.tertiary,
    errorColor: Palette.quaternary,
    highlightColor: Palette.secondary,
    primaryIconTheme: IconThemeData(
      color: Color(0xFF91949A),
      opacity: 1.0,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
      opacity: 1.0,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.white,
        fontSize: 24.0,
        fontWeight: FontWeight.w700,
      ),
      headline2: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.w700,
      ),
      headline3: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        fontWeight: FontWeight.w700,
      ),
      headline4: TextStyle(
        color: Colors.white,
        fontSize: 14.0,
        fontWeight: FontWeight.w700,
      ),
      headline5: TextStyle(
        color: Color(0xFF91949A),
        fontSize: 10.0,
        fontWeight: FontWeight.w700,
      ),
      headline6: TextStyle(
        color: Colors.white,
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
      ),
      subtitle1: TextStyle(
        color: Palette.secondary,
        fontSize: 12.0,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
      ),
      subtitle2: TextStyle(
        color: Color(0xFF91949A),
        fontSize: 10.0,
        fontWeight: FontWeight.w400,
      ),
      bodyText1: TextStyle(
        color: Color(0xFF91949A),
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
      ),
      button: TextStyle(
        color: Color(0xFF91949A),
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
      ),
      bodyText2: TextStyle(
        color: Color(0xFF91949A),
        fontSize: 10.0,
        fontWeight: FontWeight.w400,
      ),
    ),
    primarySwatch: MaterialColor(
      0xFF000000, //0%
      const <int, Color>{
        50: const Color(0xFF000000), //10%
        100: const Color(0xFF000000), //20%
        200: const Color(0xFF000000), //30%
        300: const Color(0xFF000000), //40%
        400: const Color(0xFF000000), //50%
        500: const Color(0xFF000000), //60%
        600: const Color(0xFF000000), //70%
        700: const Color(0xFF000000), //80%
        800: const Color(0xFF000000), //90%
        900: const Color(0xFF000000), //100%
      },
    ),
    colorScheme: ColorScheme.dark(),
  );
}
