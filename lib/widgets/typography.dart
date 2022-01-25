import 'package:flutter/material.dart';

enum FontLevel { H1, H2, p }

class Typography extends Text {
  Typography(
    String text, {
    FontLevel level,
    FontWeight weight,
    double size,
    FontStyle fontStyle,
    int maxLines,
    TextAlign textAlign,
  }) : super(
          text,
          textAlign: textAlign ?? null,
          maxLines: maxLines ?? null,
          style: TextStyle(
            fontWeight: weight ?? FontWeight.normal,
            fontStyle: fontStyle ?? FontStyle.normal,
            fontSize: size ?? 12.0,
            fontFamily: getFontFamily(level),
          ),
        );

  static getFontFamily(FontLevel level) {
    switch (level) {
      case FontLevel.H1:
        return "Cornerstone";
      case FontLevel.H2:
        return "SpaceGrotesk";
      case FontLevel.p:
        return "Roboto";
    }
  }
}
