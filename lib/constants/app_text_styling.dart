import 'package:flutter/material.dart';
import 'package:nutri/constants/export.dart';

class AppTextStyles {
  // Private constructor
  AppTextStyles._();

  //! Heading Styles - FontWeight.w700 (Bold)
  static TextStyle get heading1 => TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    fontFamily: AppFonts.Inter,
    color: kWhite,
  );

  static TextStyle get heading2 => TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    fontFamily: AppFonts.Inter,
    color: kWhite,
  );

  static TextStyle get heading3 => TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    fontFamily: AppFonts.Inter,
    color: kWhite,
  );

  static TextStyle get heading4 => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    fontFamily: AppFonts.Inter,
    color: kWhite,
  );

  static TextStyle get heading5 => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    fontFamily: AppFonts.Inter,
    color: kWhite,
  );

  static TextStyle get heading6 => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    fontFamily: AppFonts.Inter,
    color: kWhite,
  );

  static TextStyle get heading7 => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    fontFamily: AppFonts.Inter,
    color: kWhite,
  );

  //! Heading Styles - FontWeight.w400 (Regular)
  static TextStyle get heading1Regular => TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    fontFamily: AppFonts.Inter,
    color: kWhite,
  );

  static TextStyle get heading2Regular => TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w400,
    fontFamily: AppFonts.Inter,
    color: kWhite,
  );

  static TextStyle get heading3Regular => TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    fontFamily: AppFonts.Inter,
    color: kWhite,
  );

  static TextStyle get heading4Regular => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    fontFamily: AppFonts.Inter,
    color: kWhite,
  );

  static TextStyle get heading5Regular => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: AppFonts.Inter,
    color: kWhite,
  );

  static TextStyle get heading6Regular => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: AppFonts.Inter,
    color: kWhite,
  );

  static TextStyle get heading7Regular => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: AppFonts.Inter,
    color: kWhite,
  );

  //! Body Styles - FontWeight.w500 (Medium)
  static TextStyle get body1 => TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    fontFamily: AppFonts.Inter,
    color: kWhite,
  );

  static TextStyle get body2 => TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    fontFamily: AppFonts.Inter,
    color: kWhite,
  );

  static TextStyle get body3 => TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    fontFamily: AppFonts.Inter,
    color: kWhite,
  );

  static TextStyle get body4 => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    fontFamily: AppFonts.Inter,
    color: kWhite,
  );

  static TextStyle get body5 => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: AppFonts.Inter,
    color: kWhite,
  );

  static TextStyle get body6 => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    fontFamily: AppFonts.Inter,
    color: kWhite,
  );

  static TextStyle get body7 => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    fontFamily: AppFonts.Inter,
    color: kWhite,
  );

  //! Body Styles - FontWeight.w400 (Regular)
  static TextStyle get body1Regular => TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    fontFamily: AppFonts.Inter,
    color: kWhite,
  );

  static TextStyle get body2Regular => TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w400,
    fontFamily: AppFonts.Inter,
    color: kWhite,
  );

  static TextStyle get body3Regular => TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    fontFamily: AppFonts.Inter,
    color: kWhite,
  );

  static TextStyle get body4Regular => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    fontFamily: AppFonts.Inter,
    color: kWhite,
  );

  static TextStyle get body5Regular => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: AppFonts.Inter,
    color: kWhite,
  );

  static TextStyle get body6Regular => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: AppFonts.Inter,
    color: kWhite,
  );

  static TextStyle get body7Regular => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: AppFonts.Inter,
    color: kWhite,
  );

  //! Caption Styles - FontWeight.w400 (Regular)
  static TextStyle get caption1 => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    fontFamily: AppFonts.Inter,
    color: kWhite,
  );

  static TextStyle get caption2 => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: AppFonts.Inter,
    color: kWhite,
  );

  static TextStyle get caption3 => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: AppFonts.Inter,
    color: kWhite,
  );

  static TextStyle get caption4 => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: AppFonts.Inter,
    color: kWhite,
  );

  //! Utility methods for dynamic styling
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  static TextStyle withFontSize(TextStyle style, double fontSize) {
    return style.copyWith(fontSize: fontSize);
  }

  static TextStyle withFontWeight(TextStyle style, FontWeight fontWeight) {
    return style.copyWith(fontWeight: fontWeight);
  }

  static TextStyle withFontFamily(TextStyle style, String fontFamily) {
    return style.copyWith(fontFamily: fontFamily);
  }

  //! Pre-defined dynamic color variants
  static TextStyle get heading1Dark => heading1.copyWith(color: kBlack);
  static TextStyle get heading2Dark => heading2.copyWith(color: kBlack);
  static TextStyle get body5Dark => body5.copyWith(color: kBlack);
  static TextStyle get caption3Dark => caption3.copyWith(color: kBlack);
  
  // Add more color variants as needed...
}

// Extension methods for easier usage
extension TextStyleExtensions on TextStyle {
  TextStyle withColor(Color color) => copyWith(color: color);
  TextStyle withFontSize(double size) => copyWith(fontSize: size);
  TextStyle withFontWeight(FontWeight weight) => copyWith(fontWeight: weight);
  TextStyle withFontFamily(String family) => copyWith(fontFamily: family);
  TextStyle withHeight(double height) => copyWith(height: height);
  TextStyle withLetterSpacing(double spacing) => copyWith(letterSpacing: spacing);
}