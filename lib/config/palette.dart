import 'package:flutter/material.dart';

class Palette {
  static const Color primary = Color(0xFF30AD4C);

  static const Color priceColor = Color(0xFFF7B731);
  static const Color tertiary = Color(0xFF0097E6);
  static const Color quaternary = Color(0xFFC23616);

  static const LinearGradient blackGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Colors.black45],
  );

  static const LinearGradient whiteGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Colors.white24],
  );
}

class LightPalette {
  static const Color scaffold = Color(0xFFF6F8FA);
  static const Color disableColor = Color(0xFFEBECF0);

  static const Color bottomNavBar = Colors.white;

  static const Color textColor = Colors.black;
  static const Color secondaryColor = Color(0xFF91949A);

  static const Color announcementColor = Color(0xFFFCF4E9);
}

class DarkPalette {
  static const Color scaffold = Color(0xFF101010);
  static const Color disableColor = Color(0x33FFFFFF);

  static const Color bottomNavBar = Colors.black;

  static const Color textColor = Colors.white;
  static const Color secondaryColor = Color(0xFF91949A);

  static const Color announcementColor = Color(0x66FCF4E9);
}
