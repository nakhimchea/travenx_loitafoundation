import 'package:flutter/material.dart';
import 'package:travenx_loitafoundation/config/configs.dart';
import 'package:travenx_loitafoundation/helpers/theme_type.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData? _themeOption = Travenx.themeLightGrey;

  ThemeData? get themeOption => _themeOption;

  void setTheme(ThemeType themeType) {
    switch (themeType) {
      case ThemeType.lightGrey:
        _themeOption = Travenx.themeLightGrey;
        break;
      case ThemeType.lightCoffee:
        _themeOption = Travenx.themeLightCoffee;
        break;
      case ThemeType.lightPink:
        _themeOption = Travenx.themeLightPink;
        break;
      case ThemeType.lightPurple:
        _themeOption = Travenx.themeLightPurple;
        break;
      case ThemeType.darkGrey:
        _themeOption = Travenx.themeDarkGrey;
        break;
      case ThemeType.lightBlue:
        _themeOption = Travenx.themeLightBlue;
        break;
      default:
        _themeOption = Travenx.themeLightGrey;
        break;
    }
    notifyListeners();
  }

  void clearTheme() {
    _themeOption = Travenx.themeLightGrey;
    notifyListeners();
  }
}

class Travenx {
  static final themeLightGrey = ThemeData(
    primaryColor: Palette.primary,
    focusColor: Colors.transparent,
    hoverColor: Colors.transparent,
    shadowColor: Colors.black26,
    canvasColor: Colors.white,
    scaffoldBackgroundColor: Color(0xFFF6F8FA),
    bottomAppBarColor: Colors.white,
    cardColor: Color(0xFFFCF4E9),
    dividerColor: Color(0),
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    selectedRowColor: Color(0),
    unselectedWidgetColor: Color(0),
    disabledColor: Color(0xFFDADADA),
    secondaryHeaderColor: Palette.secondary,
    backgroundColor: Colors.white,
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
  static final themeLightCoffee = ThemeData(
    primaryColor: Palette.primary,
    focusColor: Colors.transparent,
    hoverColor: Colors.transparent,
    shadowColor: Colors.black26,
    canvasColor: Color(0xFFBFCAB2),
    scaffoldBackgroundColor: Color(0xFFDCE6CD),
    bottomAppBarColor: Color(0xFFBFCAB2),
    cardColor: Color(0xFFFCF4E9),
    dividerColor: Color(0),
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    selectedRowColor: Color(0),
    unselectedWidgetColor: Color(0),
    disabledColor: Color(0x60BFCAB2),
    secondaryHeaderColor: Palette.secondary,
    backgroundColor: Color(0xFFBFCAB2),
    dialogBackgroundColor: Color(0),
    indicatorColor: Color(0),
    hintColor: Palette.tertiary,
    errorColor: Palette.quaternary,
    toggleableActiveColor: Color(0),
    primaryIconTheme: IconThemeData(color: Colors.black),
    iconTheme: IconThemeData(color: Color(0xFF49454E)),
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
        color: Color(0xFF49454E),
        fontSize: 16.0,
      ),
      headlineMedium: kHeadlinePTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 14.0,
      ),
      headlineSmall: kHeadlinePTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 12.0,
      ),
      labelLarge: kLabelPTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 22.0,
      ),
      labelMedium: kLabelPTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 20.0,
      ),
      labelSmall: kLabelPTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 18.0,
      ),
      bodyLarge: kBodyPTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 16.0,
      ),
      bodyMedium: kBodyPTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 14.0,
      ),
      bodySmall: kBodyPTextStyle.copyWith(
        color: Color(0xFF49454E),
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
        color: Color(0xFF49454E),
        fontSize: 16.0,
      ),
      headlineMedium: kHeadlineTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 14.0,
      ),
      headlineSmall: kHeadlineTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 12.0,
      ),
      labelLarge: kLabelTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 22.0,
      ),
      labelMedium: kLabelTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 20.0,
      ),
      labelSmall: kLabelTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 18.0,
      ),
      bodyLarge: kBodyTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 16.0,
      ),
      bodyMedium: kBodyTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 14.0,
      ),
      bodySmall: kBodyTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 12.0,
      ),
    ),
    colorScheme: ColorScheme.light(),
  );
  static final themeLightPink = ThemeData(
    primaryColor: Palette.primary,
    focusColor: Colors.transparent,
    hoverColor: Colors.transparent,
    shadowColor: Colors.black26,
    canvasColor: Color(0xFFEFB8C8),
    scaffoldBackgroundColor: Color(0xFFFFD8E4),
    bottomAppBarColor: Color(0xFFEFB8C8),
    cardColor: Color(0xFFFCF4E9),
    dividerColor: Color(0),
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    selectedRowColor: Color(0),
    unselectedWidgetColor: Color(0),
    disabledColor: Color(0x60EFB8C8),
    secondaryHeaderColor: Palette.secondary,
    backgroundColor: Color(0xFFEFB8C8),
    dialogBackgroundColor: Color(0),
    indicatorColor: Color(0),
    hintColor: Palette.tertiary,
    errorColor: Palette.quaternary,
    toggleableActiveColor: Color(0),
    primaryIconTheme: IconThemeData(color: Colors.black),
    iconTheme: IconThemeData(color: Color(0xFF49454E)),
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
        color: Color(0xFF49454E),
        fontSize: 16.0,
      ),
      headlineMedium: kHeadlinePTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 14.0,
      ),
      headlineSmall: kHeadlinePTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 12.0,
      ),
      labelLarge: kLabelPTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 22.0,
      ),
      labelMedium: kLabelPTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 20.0,
      ),
      labelSmall: kLabelPTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 18.0,
      ),
      bodyLarge: kBodyPTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 16.0,
      ),
      bodyMedium: kBodyPTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 14.0,
      ),
      bodySmall: kBodyPTextStyle.copyWith(
        color: Color(0xFF49454E),
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
        color: Color(0xFF49454E),
        fontSize: 16.0,
      ),
      headlineMedium: kHeadlineTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 14.0,
      ),
      headlineSmall: kHeadlineTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 12.0,
      ),
      labelLarge: kLabelTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 22.0,
      ),
      labelMedium: kLabelTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 20.0,
      ),
      labelSmall: kLabelTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 18.0,
      ),
      bodyLarge: kBodyTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 16.0,
      ),
      bodyMedium: kBodyTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 14.0,
      ),
      bodySmall: kBodyTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 12.0,
      ),
    ),
    colorScheme: ColorScheme.light(),
  );
  static final themeLightPurple = ThemeData(
    primaryColor: Palette.primary,
    focusColor: Colors.transparent,
    hoverColor: Colors.transparent,
    shadowColor: Colors.black26,
    canvasColor: Color(0xFFD0BCFF),
    scaffoldBackgroundColor: Color(0xFFEADDFF),
    bottomAppBarColor: Color(0xFFD0BCFF),
    cardColor: Color(0xFFFCF4E9),
    dividerColor: Color(0),
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    selectedRowColor: Color(0),
    unselectedWidgetColor: Color(0),
    disabledColor: Color(0x60D0BCFF),
    secondaryHeaderColor: Palette.secondary,
    backgroundColor: Color(0xFFD0BCFF),
    dialogBackgroundColor: Color(0),
    indicatorColor: Color(0),
    hintColor: Palette.tertiary,
    errorColor: Palette.quaternary,
    toggleableActiveColor: Color(0),
    primaryIconTheme: IconThemeData(color: Colors.black),
    iconTheme: IconThemeData(color: Color(0xFF49454E)),
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
        color: Color(0xFF49454E),
        fontSize: 16.0,
      ),
      headlineMedium: kHeadlinePTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 14.0,
      ),
      headlineSmall: kHeadlinePTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 12.0,
      ),
      labelLarge: kLabelPTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 22.0,
      ),
      labelMedium: kLabelPTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 20.0,
      ),
      labelSmall: kLabelPTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 18.0,
      ),
      bodyLarge: kBodyPTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 16.0,
      ),
      bodyMedium: kBodyPTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 14.0,
      ),
      bodySmall: kBodyPTextStyle.copyWith(
        color: Color(0xFF49454E),
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
        color: Color(0xFF49454E),
        fontSize: 16.0,
      ),
      headlineMedium: kHeadlineTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 14.0,
      ),
      headlineSmall: kHeadlineTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 12.0,
      ),
      labelLarge: kLabelTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 22.0,
      ),
      labelMedium: kLabelTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 20.0,
      ),
      labelSmall: kLabelTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 18.0,
      ),
      bodyLarge: kBodyTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 16.0,
      ),
      bodyMedium: kBodyTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 14.0,
      ),
      bodySmall: kBodyTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 12.0,
      ),
    ),
    colorScheme: ColorScheme.light(),
  );
  static final themeDarkGrey = ThemeData(
    primaryColor: Palette.primary,
    focusColor: Colors.transparent,
    hoverColor: Colors.transparent,
    shadowColor: Colors.black26,
    canvasColor: Colors.black,
    scaffoldBackgroundColor: Color(0xFF101010),
    bottomAppBarColor: Colors.black,
    cardColor: Color(0x66FCF4E9),
    dividerColor: Color(0),
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    selectedRowColor: Color(0),
    unselectedWidgetColor: Color(0),
    disabledColor: Color(0x33FFFFFF),
    secondaryHeaderColor: Palette.secondary,
    backgroundColor: Colors.black,
    dialogBackgroundColor: Color(0),
    indicatorColor: Color(0),
    hintColor: Palette.tertiary,
    errorColor: Palette.quaternary,
    toggleableActiveColor: Color(0),
    primaryIconTheme: IconThemeData(color: Colors.white),
    iconTheme: IconThemeData(color: Color(0xFF91949A)),
    primaryTextTheme: TextTheme(
      displayLarge: kDisplayPTextStyle.copyWith(
        color: Colors.white,
        fontSize: 28.0,
      ),
      displayMedium: kDisplayPTextStyle.copyWith(
        color: Colors.white,
        fontSize: 24.0,
      ),
      displaySmall: kDisplayPTextStyle.copyWith(
        color: Colors.white,
        fontSize: 20.0,
      ),
      titleLarge: kTitlePTextStyle.copyWith(
        color: Colors.white,
        fontSize: 18.0,
      ),
      titleMedium: kTitlePTextStyle.copyWith(
        color: Colors.white,
        fontSize: 16.0,
      ),
      titleSmall: kTitlePTextStyle.copyWith(
        color: Colors.white,
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
        color: Colors.white,
        fontSize: 28.0,
      ),
      displayMedium: kDisplayTextStyle.copyWith(
        color: Colors.white,
        fontSize: 24.0,
      ),
      displaySmall: kDisplayTextStyle.copyWith(
        color: Colors.white,
        fontSize: 20.0,
      ),
      titleLarge: kTitleTextStyle.copyWith(
        color: Colors.white,
        fontSize: 18.0,
      ),
      titleMedium: kTitleTextStyle.copyWith(
        color: Colors.white,
        fontSize: 16.0,
      ),
      titleSmall: kTitleTextStyle.copyWith(
        color: Colors.white,
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
    colorScheme: ColorScheme.dark(),
  );
  static final themeLightBlue = ThemeData(
    primaryColor: Palette.primary,
    focusColor: Colors.transparent,
    hoverColor: Colors.transparent,
    shadowColor: Colors.black26,
    canvasColor: Color(0xFF93CDFA),
    scaffoldBackgroundColor: Color(0xFFC9E6FD),
    bottomAppBarColor: Color(0xFF93CDFA),
    cardColor: Color(0xFFFCF4E9),
    dividerColor: Color(0),
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    selectedRowColor: Color(0),
    unselectedWidgetColor: Color(0),
    disabledColor: Color(0x6093CDFA),
    secondaryHeaderColor: Palette.secondary,
    backgroundColor: Color(0xFF93CDFA),
    dialogBackgroundColor: Color(0),
    indicatorColor: Color(0),
    hintColor: Palette.tertiary,
    errorColor: Palette.quaternary,
    toggleableActiveColor: Color(0),
    primaryIconTheme: IconThemeData(color: Colors.black),
    iconTheme: IconThemeData(color: Color(0xFF49454E)),
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
        color: Color(0xFF49454E),
        fontSize: 16.0,
      ),
      headlineMedium: kHeadlinePTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 14.0,
      ),
      headlineSmall: kHeadlinePTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 12.0,
      ),
      labelLarge: kLabelPTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 22.0,
      ),
      labelMedium: kLabelPTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 20.0,
      ),
      labelSmall: kLabelPTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 18.0,
      ),
      bodyLarge: kBodyPTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 16.0,
      ),
      bodyMedium: kBodyPTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 14.0,
      ),
      bodySmall: kBodyPTextStyle.copyWith(
        color: Color(0xFF49454E),
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
        color: Color(0xFF49454E),
        fontSize: 16.0,
      ),
      headlineMedium: kHeadlineTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 14.0,
      ),
      headlineSmall: kHeadlineTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 12.0,
      ),
      labelLarge: kLabelTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 22.0,
      ),
      labelMedium: kLabelTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 20.0,
      ),
      labelSmall: kLabelTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 18.0,
      ),
      bodyLarge: kBodyTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 16.0,
      ),
      bodyMedium: kBodyTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 14.0,
      ),
      bodySmall: kBodyTextStyle.copyWith(
        color: Color(0xFF49454E),
        fontSize: 12.0,
      ),
    ),
    colorScheme: ColorScheme.light(),
  );
}
