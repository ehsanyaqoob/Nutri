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
              fontFamily: fontFamily ?? AppFonts.Inter,
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
