import 'package:flutter/material.dart';

enum TextLevel {
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
    TextLevel? textLevel,
    FontWeight? weight,
    double? fontSize,
    FontStyle? fontStyle,
    int? maxLines,
    TextAlign? textAlign,
    double? letterSpacing,
    Color? color,
    Key? key,
    double? height,
  }) : super(
          text,
          textAlign: textAlign,
          maxLines: maxLines,
          style: getTextStyle(textLevel ?? TextLevel.body1).copyWith(
            fontStyle: fontStyle,
            fontSize: fontSize,
            fontWeight: weight,
            letterSpacing: letterSpacing,
            color: color,
            overflow: TextOverflow.ellipsis,
            height: height,
          ),
          key: key,
        );

  static String getFontFamily(FontVariant variant) {
    switch (variant) {
      case FontVariant.header:
        return "CornerStone";
      case FontVariant.sub:
        return "SpaceGrotesk";
      case FontVariant.p:
        return "Roboto";
    }
    return "Roboto";
  }

  static double getHeight(double lineHeight, double fontSize) =>
      lineHeight / fontSize;

  static TextStyle getTextStyle(TextLevel level) {
    switch (level) {
      case TextLevel.h1:
        return TextStyle(
          fontFamily: getFontFamily(FontVariant.header),
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 34,
          height: getHeight(40, 34),
        );
      case TextLevel.h2:
        return TextStyle(
          fontFamily: getFontFamily(FontVariant.sub),
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
          fontSize: 34,
          height: getHeight(40, 34),
          letterSpacing: .25,
        );
      case TextLevel.h3:
        return TextStyle(
          fontFamily: getFontFamily(FontVariant.sub),
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          fontSize: 24,
          height: getHeight(32, 24),
        );
      case TextLevel.h4:
        return TextStyle(
          fontFamily: getFontFamily(FontVariant.sub),
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          fontSize: 20,
          height: getHeight(28, 20),
          letterSpacing: .15,
        );
      case TextLevel.sub1:
        return TextStyle(
          fontFamily: getFontFamily(FontVariant.sub),
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 16,
          height: getHeight(24, 16),
          letterSpacing: .15,
        );
      case TextLevel.sub2:
        return TextStyle(
          fontFamily: getFontFamily(FontVariant.p),
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          fontSize: 14,
          height: getHeight(20, 14),
          letterSpacing: .1,
        );
      case TextLevel.button:
        return TextStyle(
          fontFamily: getFontFamily(FontVariant.p),
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          fontSize: 14,
          height: getHeight(24, 14),
          letterSpacing: 1.2,
        );
      case TextLevel.body1:
        return TextStyle(
          fontFamily: getFontFamily(FontVariant.p),
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 16,
          height: getHeight(24, 16),
          letterSpacing: .44,
        );
      case TextLevel.body2:
        return TextStyle(
          fontFamily: getFontFamily(FontVariant.p),
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 14,
          height: getHeight(20, 14),
          letterSpacing: .25,
        );
      case TextLevel.caption:
        return TextStyle(
          fontFamily: getFontFamily(FontVariant.p),
          fontWeight: FontWeight.w400,
          fontStyle: FontStyle.normal,
          fontSize: 12,
          height: getHeight(16, 12),
          letterSpacing: .5,
        );
      case TextLevel.overline:
        return TextStyle(
          fontFamily: getFontFamily(FontVariant.p),
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          fontSize: 10,
          height: getHeight(16, 10),
          letterSpacing: 1.2,
        );
    }
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
