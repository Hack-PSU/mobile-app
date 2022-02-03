import 'package:flutter/material.dart';

enum FontLevel {
  h1,
  h2,
  h3,
  h4,
  sub1,
  sub2,
  button,
  body1,
  body2,
  caption,
  overline
}

enum FontVariant { header, sub, p }

class DefaultText extends Text {
  DefaultText(
    String text, {
    FontLevel fontLevel,
    FontWeight weight,
    double fontSize,
    FontStyle fontStyle,
    int maxLines,
    TextAlign textAlign,
    double letterSpacing,
    Color color,
  }) : super(
          text,
          textAlign: textAlign ?? null,
          maxLines: maxLines ?? null,
          style: getTextStyle(fontLevel ?? FontLevel.body1).copyWith(
            fontStyle: fontStyle,
            fontSize: fontSize,
            fontWeight: weight,
            letterSpacing: letterSpacing,
            color: color,
          ),
        );

  static String getFontFamily(FontVariant variant) {
    switch (variant) {
      case FontVariant.header:
        return "CornerStone";
      case FontVariant.sub:
        return "SpaceGrotesk";
      case FontVariant.p:
        return "Roboto";
      default:
        return "Roboto";
    }
  }

  static double getHeight(double lineHeight, double fontSize) =>
      lineHeight / fontSize;

  static TextStyle getTextStyle(FontLevel level) {
    switch (level) {
      case FontLevel.h1:
        return TextStyle(
          fontFamily: getFontFamily(FontVariant.header),
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 34,
          height: getHeight(40, 34),
        );
      case FontLevel.h2:
        return TextStyle(
          fontFamily: getFontFamily(FontVariant.sub),
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
          fontSize: 34,
          height: getHeight(40, 34),
          letterSpacing: .25,
        );
      case FontLevel.h3:
        return TextStyle(
          fontFamily: getFontFamily(FontVariant.sub),
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          fontSize: 24,
          height: getHeight(32, 24),
        );
      case FontLevel.h4:
        return TextStyle(
          fontFamily: getFontFamily(FontVariant.sub),
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          fontSize: 20,
          height: getHeight(28, 20),
          letterSpacing: .15,
        );
      case FontLevel.sub1:
        return TextStyle(
          fontFamily: getFontFamily(FontVariant.sub),
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 16,
          height: getHeight(24, 16),
          letterSpacing: .15,
        );
      case FontLevel.sub2:
        return TextStyle(
          fontFamily: getFontFamily(FontVariant.p),
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          fontSize: 14,
          height: getHeight(20, 14),
          letterSpacing: .1,
        );
      case FontLevel.button:
        return TextStyle(
          fontFamily: getFontFamily(FontVariant.p),
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          fontSize: 14,
          height: getHeight(24, 14),
          letterSpacing: 1.2,
        );
      case FontLevel.body1:
        return TextStyle(
          fontFamily: getFontFamily(FontVariant.p),
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 16,
          height: getHeight(24, 16),
          letterSpacing: .44,
        );
      case FontLevel.body2:
        return TextStyle(
          fontFamily: getFontFamily(FontVariant.p),
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 14,
          height: getHeight(20, 14),
          letterSpacing: .25,
        );
      case FontLevel.caption:
        return TextStyle(
            fontFamily: getFontFamily(FontVariant.p),
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 12,
            height: getHeight(16, 12),
            letterSpacing: .5);
      case FontLevel.overline:
        return TextStyle(
          fontFamily: getFontFamily(FontVariant.p),
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          fontSize: 10,
          height: getHeight(16, 10),
          letterSpacing: 1.2,
        );
      default:
        return TextStyle(
          fontFamily: getFontFamily(FontVariant.p),
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 16,
          height: getHeight(24, 16),
          letterSpacing: .44,
        );
    }
  }
}
