import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/palette.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isLightMode => themeMode == ThemeMode.light;

  void toggleTheme(bool isOff) {
    themeMode = isOff ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}

class Travenx {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: LightPalette.scaffold,
    bottomAppBarColor: LightPalette.bottomNavBar,
    disabledColor: LightPalette.disableColor,
    cardColor: LightPalette.announcementColor, //Only Announcement Card
    primaryColor: Palette.primary,
    hintColor: Palette.tertiary,
    errorColor: Palette.quaternary,
    primaryIconTheme: IconThemeData(
      color: LightPalette.secondaryColor,
      opacity: 1.0,
    ),
    iconTheme: IconThemeData(
      color: LightPalette.textColor,
      opacity: 1.0,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: LightPalette.textColor,
        fontSize: 24.0,
        fontFamily: 'Nokora',
        fontWeight: FontWeight.w700,
      ),
      headline2: TextStyle(
        color: LightPalette.textColor,
        fontSize: 20.0,
        fontFamily: 'Nokora',
        fontWeight: FontWeight.w700,
      ),
      headline3: TextStyle(
        color: LightPalette.textColor,
        fontSize: 16.0,
        fontFamily: 'Nokora',
        fontWeight: FontWeight.w700,
      ),
      headline4: TextStyle(
        color: LightPalette.textColor,
        fontSize: 14.0,
        fontFamily: 'Nokora',
        fontWeight: FontWeight.w700,
      ),
      headline5: TextStyle(
        color: LightPalette.secondaryColor,
        fontSize: 10.0,
        fontWeight: FontWeight.w700,
      ),
      headline6: TextStyle(
        color: LightPalette.textColor,
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
      ),
      subtitle1: TextStyle(
        color: Palette.priceColor,
        fontSize: 12.0,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
      ),
      subtitle2: TextStyle(
        color: LightPalette.secondaryColor,
        fontSize: 10.0,
        fontWeight: FontWeight.w400,
      ),
      bodyText1: TextStyle(
        color: LightPalette.secondaryColor,
        fontSize: 14.0,
        fontFamily: 'Nokora',
        fontWeight: FontWeight.w400,
      ),
      button: TextStyle(
        color: LightPalette.secondaryColor,
        fontSize: 12.0,
        fontFamily: 'Nokora',
        fontWeight: FontWeight.w400,
      ),
      bodyText2: TextStyle(
        color: LightPalette.secondaryColor,
        fontSize: 10.0,
        fontFamily: 'Nokora',
        fontWeight: FontWeight.w400,
      ),
    ),
    primarySwatch: MaterialColor(
      0xFF30AD4C, //0%
      const <int, Color>{
        50: const Color(0xFF30AD4C), //10%
        100: const Color(0xFF30AD4C), //20%
        200: const Color(0xFF30AD4C), //30%
        300: const Color(0xFF30AD4C), //40%
        400: const Color(0xFF30AD4C), //50%
        500: const Color(0xFF30AD4C), //60%
        600: const Color(0xFF30AD4C), //70%
        700: const Color(0xFF30AD4C), //80%
        800: const Color(0xFF30AD4C), //90%
        900: const Color(0xFF30AD4C), //100%
      },
    ),
    colorScheme: ColorScheme.light(),
  );

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: DarkPalette.scaffold,
    bottomAppBarColor: DarkPalette.bottomNavBar,
    disabledColor: DarkPalette.disableColor,
    cardColor: DarkPalette.announcementColor, // Only Announcement Card
    primaryColor: Palette.primary,
    hintColor: Palette.tertiary,
    errorColor: Palette.quaternary,
    primaryIconTheme: IconThemeData(
      color: DarkPalette.secondaryColor,
      opacity: 1.0,
    ),
    iconTheme: IconThemeData(
      color: DarkPalette.textColor,
      opacity: 1.0,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: DarkPalette.textColor,
        fontSize: 24.0,
        fontFamily: 'Nokora',
        fontWeight: FontWeight.w700,
      ),
      headline2: TextStyle(
        color: DarkPalette.textColor,
        fontSize: 20.0,
        fontFamily: 'Nokora',
        fontWeight: FontWeight.w700,
      ),
      headline3: TextStyle(
        color: DarkPalette.textColor,
        fontSize: 16.0,
        fontFamily: 'Nokora',
        fontWeight: FontWeight.w700,
      ),
      headline4: TextStyle(
        color: DarkPalette.textColor,
        fontSize: 14.0,
        fontFamily: 'Nokora',
        fontWeight: FontWeight.w700,
      ),
      headline5: TextStyle(
        color: DarkPalette.secondaryColor,
        fontSize: 10.0,
        fontWeight: FontWeight.w700,
      ),
      headline6: TextStyle(
        color: DarkPalette.textColor,
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
      ),
      subtitle1: TextStyle(
        color: Palette.priceColor,
        fontSize: 16.0,
        fontWeight: FontWeight.w700,
      ),
      subtitle2: TextStyle(
        color: DarkPalette.secondaryColor,
        fontSize: 10.0,
        fontWeight: FontWeight.w400,
      ),
      bodyText1: TextStyle(
        color: DarkPalette.secondaryColor,
        fontSize: 14.0,
        fontFamily: 'Nokora',
        fontWeight: FontWeight.w400,
      ),
      button: TextStyle(
        color: DarkPalette.secondaryColor,
        fontSize: 12.0,
        fontFamily: 'Nokora',
        fontWeight: FontWeight.w400,
      ),
      bodyText2: TextStyle(
        color: DarkPalette.secondaryColor,
        fontSize: 10.0,
        fontFamily: 'Nokora',
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
