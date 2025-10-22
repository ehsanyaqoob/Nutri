import 'package:nutri/constants/export.dart';
class MyText extends StatelessWidget {
  final String text;
  final String? fontFamily;
  final TextAlign? textAlign;
  final TextDecoration decoration;
  final FontWeight? weight;
  final TextOverflow? textOverflow;
  final Color? color;
  final FontStyle? fontStyle;
  final VoidCallback? onTap;
  final Color decorationColor;

  final int? maxLines;
  final double? size;
  final double? lineHeight;
  final double? paddingTop;
  final double? paddingLeft;
  final double? paddingRight;
  final double? paddingBottom;
  final double? letterSpacing;
  final bool respectSystemFontSize; 

  const MyText({
    super.key,
    required this.text,
    this.size,
    this.lineHeight,
    this.maxLines = 100,
    this.decoration = TextDecoration.none,
    this.color,
    this.letterSpacing,
    this.weight = FontWeight.w400,
    this.textAlign,
    this.textOverflow,
    this.fontFamily,
    this.decorationColor = Colors.transparent,
    this.paddingTop = 0,
    this.paddingRight = 0,
    this.paddingLeft = 0,
    this.paddingBottom = 0,
    this.onTap,
    this.fontStyle,
    this.respectSystemFontSize = true, // Default to true
  });

  @override
  Widget build(BuildContext context) {
    final String currentLangCode = Get.locale?.languageCode ?? 'en';
    final bool isArabic = currentLangCode == 'ar' || currentLangCode == 'sa';
    
    // Get system text scale factor with reasonable limits
    final double textScaleFactor = MediaQuery.textScaleFactorOf(context);
    final double effectiveTextScaleFactor = _getEffectiveTextScaleFactor(textScaleFactor);
    
    // Calculate final font size
    final double? finalFontSize = size != null 
        ? size! * effectiveTextScaleFactor
        : null;

    return Animate(
      effects: [FadeEffect(duration: Duration(milliseconds: 500))],
      child: Padding(
        padding: EdgeInsets.only(
          top: paddingTop!,
          left: paddingLeft!,
          right: paddingRight!,
          bottom: paddingBottom!,
        ),
        child: GestureDetector(
          onTap: onTap,
          child: Text(
            "$text".tr,
            style: TextStyle(
              fontSize: respectSystemFontSize ? finalFontSize : size,
              color: color ?? kWhite,
              fontWeight: weight,
              decoration: decoration,
              decorationColor: decorationColor,
              fontFamily: fontFamily ?? AppFonts.Figtree,
              height: lineHeight ?? 1.5,
              fontStyle: fontStyle,
              letterSpacing: 0,
            ),
            textAlign:
                textAlign ?? (isArabic ? TextAlign.right : TextAlign.left),
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            maxLines: maxLines,
            overflow: textOverflow ?? TextOverflow.ellipsis, // Always have a fallback
            textScaler: respectSystemFontSize 
                ? const TextScaler.linear(1.0) // We handle scaling manually in fontSize
                : null,
          ),
        ),
      ),
    );
  }

  // Method to apply reasonable limits to text scaling
  double _getEffectiveTextScaleFactor(double systemScaleFactor) {
    // Define reasonable min and max bounds
    const double minScale = 0.8;  // Don't go smaller than 80%
    const double maxScale = 1.5;  // Don't go larger than 150%
    
    return systemScaleFactor.clamp(minScale, maxScale);
  }
 }

 
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:nutri/constants/export.dart';

// /// One Text Class to Rule Them All - Fully Responsive & Feature Complete
// class MyText extends StatelessWidget {
//   final String text;
//   final String? fontFamily;
//   final TextAlign? textAlign;
//   final TextDecoration decoration;
//   final FontWeight? weight;
//   final TextOverflow? textOverflow;
//   final Color? color;
//   final FontStyle? fontStyle;
//   final VoidCallback? onTap;
//   final Color decorationColor;

//   final int? maxLines;
//   final double? size;
//   final double? lineHeight;
//   final double? paddingTop;
//   final double? paddingLeft;
//   final double? paddingRight;
//   final double? paddingBottom;
//   final double? letterSpacing;
//   final bool respectSystemFontSize;

//   // Responsive Configuration
//   final bool useResponsiveSize;
//   final TextScale textScale;
//   final ScreenType? forceScreenType;

//   // Predefined Style Integration
//   final TextStyle? textStyle;

//   const MyText({
//     super.key,
//     required this.text,
//     this.size,
//     this.lineHeight,
//     this.maxLines = 100,
//     this.decoration = TextDecoration.none,
//     this.color,
//     this.letterSpacing,
//     this.weight = FontWeight.w400,
//     this.textAlign,
//     this.textOverflow,
//     this.fontFamily,
//     this.decorationColor = Colors.transparent,
//     this.paddingTop = 0,
//     this.paddingRight = 0,
//     this.paddingLeft = 0,
//     this.paddingBottom = 0,
//     this.onTap,
//     this.fontStyle,
//     this.respectSystemFontSize = true,
//     // Responsive defaults - works out of the box
//     this.useResponsiveSize = true,
//     this.textScale = TextScale.medium,
//     this.forceScreenType,
//     this.textStyle,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final String currentLangCode = Get.locale?.languageCode ?? 'en';
//     final bool isArabic = currentLangCode == 'ar' || currentLangCode == 'sa';
    
//     // Automatic responsive calculation
//     final screenType = forceScreenType ?? _getScreenType(context);
//     final double baseFontSize = _getBaseFontSize(context, screenType);
//     final double textScaleFactor = _getEffectiveTextScaleFactor(
//       MediaQuery.textScaleFactorOf(context)
//     );
    
//     final double finalFontSize = baseFontSize * textScaleFactor;
//     final TextStyle finalStyle = _buildTextStyle(context, finalFontSize, screenType);

//     return Animate(
//       effects: [FadeEffect(duration: const Duration(milliseconds: 500))],
//       child: Padding(
//         padding: EdgeInsets.only(
//           top: paddingTop!,
//           left: paddingLeft!,
//           right: paddingRight!,
//           bottom: paddingBottom!,
//         ),
//         child: GestureDetector(
//           onTap: onTap,
//           child: Text(
//             text.tr,
//             style: finalStyle,
//             textAlign: textAlign ?? (isArabic ? TextAlign.right : TextAlign.left),
//             textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
//             maxLines: maxLines,
//             overflow: textOverflow ?? TextOverflow.ellipsis,
//             textScaler: const TextScaler.linear(1.0),
//           ),
//         ),
//       ),
//     );
//   }

//   // ========== CORE RESPONSIVE ENGINE ==========
  
//   ScreenType _getScreenType(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     if (width < 600) return ScreenType.mobile;
//     if (width < 1200) return ScreenType.tablet;
//     return ScreenType.desktop;
//   }

//   double _getBaseFontSize(BuildContext context, ScreenType screenType) {
//     // Priority 1: Predefined textStyle
//     if (textStyle != null && textStyle!.fontSize != null) {
//       return _applyScreenMultiplier(textStyle!.fontSize!, screenType);
//     }

//     // Priority 2: Custom size
//     if (size != null) {
//       return _applyScreenMultiplier(size!, screenType);
//     }

//     // Priority 3: Default scale system
//     return _getDefaultFontSize(textScale, screenType);
//   }

//   double _applyScreenMultiplier(double baseSize, ScreenType screenType) {
//     if (!useResponsiveSize) return baseSize;

//     const multipliers = {
//       ScreenType.mobile: 1.0,
//       ScreenType.tablet: 1.15,   // 15% larger on tablet
//       ScreenType.desktop: 1.3,   // 30% larger on desktop
//     };

//     return baseSize * multipliers[screenType]!;
//   }

//   double _getDefaultFontSize(TextScale scale, ScreenType screenType) {
//     const defaultSizes = {
//       TextScale.xsmall: {ScreenType.mobile: 10.0, ScreenType.tablet: 11.0, ScreenType.desktop: 12.0},
//       TextScale.small:  {ScreenType.mobile: 12.0, ScreenType.tablet: 13.0, ScreenType.desktop: 14.0},
//       TextScale.medium: {ScreenType.mobile: 14.0, ScreenType.tablet: 16.0, ScreenType.desktop: 18.0},
//       TextScale.large:  {ScreenType.mobile: 16.0, ScreenType.tablet: 18.0, ScreenType.desktop: 20.0},
//       TextScale.xlarge: {ScreenType.mobile: 18.0, ScreenType.tablet: 20.0, ScreenType.desktop: 22.0},
//       TextScale.xxlarge:{ScreenType.mobile: 20.0, ScreenType.tablet: 22.0, ScreenType.desktop: 24.0},
//     };

//     return defaultSizes[scale]![screenType]!;
//   }

//   double _getEffectiveTextScaleFactor(double systemScaleFactor) {
//     if (!respectSystemFontSize) return 1.0;
//     return systemScaleFactor.clamp(0.8, 1.5);
//   }

//   // ========== INTELLIGENT STYLE BUILDER ==========

//   TextStyle _buildTextStyle(BuildContext context, double fontSize, ScreenType screenType) {
//     TextStyle baseStyle = textStyle ?? const TextStyle();

//     final double responsiveLineHeight = _getResponsiveLineHeight(
//       lineHeight ?? baseStyle.height ?? 1.5,
//       screenType,
//     );

//     final double responsiveLetterSpacing = _getResponsiveLetterSpacing(
//       letterSpacing ?? baseStyle.letterSpacing ?? 0,
//       screenType,
//     );

//     return baseStyle.copyWith(
//       fontSize: fontSize,
//       color: color ?? baseStyle.color ?? kDynamicText(context),
//       fontWeight: weight ?? baseStyle.fontWeight ?? FontWeight.w400,
//       fontFamily: fontFamily ?? baseStyle.fontFamily ?? AppFonts.Inter,
//       height: responsiveLineHeight,
//       letterSpacing: responsiveLetterSpacing,
//       decoration: decoration,
//       decorationColor: decorationColor,
//       fontStyle: fontStyle ?? baseStyle.fontStyle,
//     );
//   }

//   double _getResponsiveLineHeight(double baseHeight, ScreenType screenType) {
//     if (!useResponsiveSize) return baseHeight;

//     const multipliers = {
//       ScreenType.mobile: baseHeight,
//       ScreenType.tablet: baseHeight * 1.1,
//       ScreenType.desktop: baseHeight * 1.2,
//     };

//     return multipliers[screenType]!;
//   }

//   double _getResponsiveLetterSpacing(double baseSpacing, ScreenType screenType) {
//     if (!useResponsiveSize) return baseSpacing;

//     const multipliers = {
//       ScreenType.mobile: baseSpacing,
//       ScreenType.tablet: baseSpacing * 1.2,
//       ScreenType.desktop: baseSpacing * 1.4,
//     };

//     return multipliers[screenType]!;
//   }
// }

// // ========== ENUM DEFINITIONS ==========

// enum ScreenType { mobile, tablet, desktop }

// enum TextScale { xsmall, small, medium, large, xlarge, xxlarge }

// // ========== PRESET FACTORY METHODS ==========

// extension MyTextPresets on MyText {
//   // === HEADINGS ===
//   static MyText h1(String text, {Color? color, bool responsive = true}) => MyText(
//     text: text, textStyle: AppTextStyles.heading1, useResponsiveSize: responsive, color: color,
//   );

//   static MyText h2(String text, {Color? color, bool responsive = true}) => MyText(
//     text: text, textStyle: AppTextStyles.heading2, useResponsiveSize: responsive, color: color,
//   );

//   static MyText h3(String text, {Color? color, bool responsive = true}) => MyText(
//     text: text, textStyle: AppTextStyles.heading3, useResponsiveSize: responsive, color: color,
//   );

//   static MyText h4(String text, {Color? color, bool responsive = true}) => MyText(
//     text: text, textStyle: AppTextStyles.heading4, useResponsiveSize: responsive, color: color,
//   );

//   // === BODY TEXT ===
//   static MyText bodyXLarge(String text, {Color? color, bool responsive = true}) => MyText(
//     text: text, textStyle: AppTextStyles.body1, useResponsiveSize: responsive, color: color,
//   );

//   static MyText bodyLarge(String text, {Color? color, bool responsive = true}) => MyText(
//     text: text, textStyle: AppTextStyles.body4, useResponsiveSize: responsive, color: color,
//   );

//   static MyText bodyMedium(String text, {Color? color, bool responsive = true}) => MyText(
//     text: text, textStyle: AppTextStyles.body5, useResponsiveSize: responsive, color: color,
//   );

//   static MyText bodySmall(String text, {Color? color, bool responsive = true}) => MyText(
//     text: text, textStyle: AppTextStyles.body6, useResponsiveSize: responsive, color: color,
//   );

//   static MyText bodyXSmall(String text, {Color? color, bool responsive = true}) => MyText(
//     text: text, textStyle: AppTextStyles.body7, useResponsiveSize: responsive, color: color,
//   );

//   // === CAPTIONS ===
//   static MyText captionLarge(String text, {Color? color, bool responsive = true}) => MyText(
//     text: text, textStyle: AppTextStyles.caption1, useResponsiveSize: responsive, color: color,
//   );

//   static MyText captionMedium(String text, {Color? color, bool responsive = true}) => MyText(
//     text: text, textStyle: AppTextStyles.caption2, useResponsiveSize: responsive, color: color,
//   );

//   static MyText captionSmall(String text, {Color? color, bool responsive = true}) => MyText(
//     text: text, textStyle: AppTextStyles.caption3, useResponsiveSize: responsive, color: color,
//   );

//   static MyText captionXSmall(String text, {Color? color, bool responsive = true}) => MyText(
//     text: text, textStyle: AppTextStyles.caption4, useResponsiveSize: responsive, color: color,
//   );

//   // === SPECIALIZED PRESETS ===
//   static MyText buttonLarge(String text, {Color? color, bool responsive = true}) => MyText(
//     text: text, textStyle: AppTextStyles.heading5, useResponsiveSize: responsive, color: color,
//   );

//   static MyText buttonMedium(String text, {Color? color, bool responsive = true}) => MyText(
//     text: text, textStyle: AppTextStyles.body5, useResponsiveSize: responsive, color: color,
//   );

//   static MyText buttonSmall(String text, {Color? color, bool responsive = true}) => MyText(
//     text: text, textStyle: AppTextStyles.body6, useResponsiveSize: responsive, color: color,
//   );

//   static MyText label(String text, {Color? color, bool responsive = true}) => MyText(
//     text: text, textStyle: AppTextStyles.body6, useResponsiveSize: responsive, color: color,
//   );

//   // === CUSTOM RESPONSIVE ===
//   static MyText customScale(
//     String text, {
//     TextScale scale = TextScale.medium,
//     Color? color,
//     FontWeight? weight,
//     bool responsive = true,
//   }) => MyText(
//     text: text,
//     textScale: scale,
//     useResponsiveSize: responsive,
//     color: color,
//     weight: weight,
//   );

//   static MyText customSize(
//     String text, {
//     double? mobile,
//     double? tablet,
//     double? desktop,
//     Color? color,
//     FontWeight? weight,
//   }) => MyText(
//     text: text,
//     useResponsiveSize: true,
//     size: mobile, // Base size for mobile
//     mobileSize: mobile,
//     tabletSize: tablet,
//     desktopSize: desktop,
//     color: color,
//     weight: weight,
//   );
// }