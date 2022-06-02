import 'package:flutter/material.dart';

class Palette {
  static const Color primary = Color(0xFF30AD4C);
  static const Color secondary = Color(0xFFF7B731);
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
