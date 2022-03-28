import 'package:flutter/material.dart';

class ThemeColors {
  static const UniversityBlue = Color(0xFF113654);
  static const StadiumOrange = Color(0xFFF3603D);
  static const HackyBlue = Color(0xFF6A85B9);
  static const Creamery = Color(0xFFF5F5F5);

  static Color addAlpha(Color color, double opacity) {
    return color.withOpacity(opacity);
  }

  static Color fromHex(String hex) {
    if (!hex.startsWith("#")) {
      throw Exception("Hex needs to start with #");
    }
    final color = 0xFF000000 + int.parse(hex.split("#")[1], radix: 16);
    return Color(color);
  }

  static Color withAlpha(String hex, double opacity) {
    return ThemeColors.fromHex(hex).withOpacity(opacity);
  }
}
