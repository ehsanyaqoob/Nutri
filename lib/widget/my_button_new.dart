import 'package:nutri/constants/export.dart';
import 'package:nutri/widget/common_image_view_widget.dart';
import 'package:nutri/widget/dot-loader.dart';
import 'package:nutri/widget/my_text_widget.dart';

class MyButtonWithIcon extends StatelessWidget {
  const MyButtonWithIcon({
    super.key,
    this.onTap,
    this.onTapWithParam,
    required this.text,
    required this.iconPath,
    this.param,
    this.height = 50,
    this.width,
    this.radius = 18.0,
    this.fontSize,
    this.fontColor,
    this.backgroundColor,
    this.outlineColor,
    this.hasShadow = false,
    this.hasGradient = false,
    this.isActive = true,
    this.mTop = 0,
    this.mBottom = 0,
    this.mHoriz = 0,
    this.fontWeight,
    this.isLoading = false,
    this.loaderColor,
    this.iconColor,
    this.iconSize = 18,
  });

  final String text;
  final String iconPath;

  final VoidCallback? onTap;
  final ValueChanged<String>? onTapWithParam;
  final String? param;

  final double? height, width;
  final double radius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? fontColor, backgroundColor, outlineColor, iconColor;
  final double iconSize;

  final bool hasShadow, hasGradient, isActive, isLoading;
  final double mTop, mBottom, mHoriz;
  final Color? loaderColor;

  @override
  Widget build(BuildContext context) {
    final bgColor = isActive
        ? backgroundColor ?? kDynamicButtonBackground(context)
        : kDynamicButtonDisabled(context);

    final txtColor = fontColor ?? kDynamicButtonText(context);
    final Color effectiveLoaderColor =
        loaderColor ?? _getLoaderColorForButton(bgColor, context);

    return Animate(
      effects: [
        FadeEffect(duration: const Duration(milliseconds: 500)),
        MoveEffect(curve: Curves.fastLinearToSlowEaseIn),
      ],
      child: Bounce(
        duration: Duration(milliseconds: isActive ? 100 : 0),
        onTap: isLoading
            ? () {}
            : () {
                if (onTap != null) {
                  onTap!();
                } else if (onTapWithParam != null && param != null) {
                  onTapWithParam!(param!);
                }
              },
        child: Container(
          margin: EdgeInsets.only(
            top: mTop,
            bottom: mBottom,
            left: mHoriz,
            right: mHoriz,
          ),
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: hasGradient ? null : bgColor,
            gradient: hasGradient ? kDynamicPrimaryGradient(context) : null,
            border: Border.all(color: outlineColor ?? kDynamicOutline(context)),
            borderRadius: BorderRadius.circular(radius),
            boxShadow: hasShadow
                ? [
                    BoxShadow(
                      color: kDynamicShadow(context),
                      offset: const Offset(0, 4),
                      blurRadius: 8,
                    ),
                  ]
                : [],
          ),
          child: Material(
            color: Colors.transparent,
            child: Center(
              child: isLoading
                  ? NutriLoader(color: effectiveLoaderColor)
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          iconPath,
                          height: iconSize,
                          color: iconColor ?? txtColor,
                        ),
                        const SizedBox(width: 8),
                        MyText(
                          text: text,
                          fontFamily: AppFonts.Inter,
                          size: fontSize ?? 16,
                          letterSpacing: 0.5,
                          color: txtColor,
                          weight: fontWeight ?? FontWeight.w800,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getLoaderColorForButton(Color? buttonBgColor, BuildContext context) {
    if (buttonBgColor == null) {
      return kDynamicText(context);
    }
    final brightness = ThemeData.estimateBrightnessForColor(buttonBgColor);
    return brightness == Brightness.dark ? kWhite : kBlack;
  }
}

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    this.onTap,
    this.onTapWithParam,
    required this.buttonText,
    this.height = 50,
    this.width,
    this.backgroundColor,
    this.fontColor,
    this.fontSize,
    this.outlineColor,
    this.radius = 30.0,
    this.choiceIcon,
    this.isleft = false,
    this.mhoriz = 0,
    this.hasicon = false,
    this.hasshadow = false,
    this.mBottom = 0,
    this.hasgrad = false,
    this.isactive = true,
    this.mTop = 0,
    this.fontWeight,
    this.isLoading = false,
    this.loaderColor,
    this.param,
  });

  final String buttonText;
  final VoidCallback? onTap;
  final ValueChanged<String>? onTapWithParam;
  final String? param;

  final double? height;
  final double? width;
  final double radius;
  final double? fontSize;
  final Color? outlineColor;
  final bool hasicon, isleft, hasshadow, hasgrad, isactive;
  final Color? backgroundColor, fontColor;
  final String? choiceIcon;
  final double mTop, mBottom, mhoriz;
  final FontWeight? fontWeight;
  final bool isLoading;
  final Color? loaderColor;

  @override
  Widget build(BuildContext context) {
    final bgColor = isactive
        ? backgroundColor ?? kDynamicButtonBackground(context)
        : kDynamicButtonDisabled(context);

    final txtColor = fontColor ?? kDynamicButtonText(context);

    // Determine the appropriate loader color based on button background
    final Color effectiveLoaderColor =
        loaderColor ?? _getLoaderColorForButton(bgColor, context);

    return Animate(
      effects: [
        FadeEffect(duration: const Duration(milliseconds: 500)),
        MoveEffect(curve: Curves.fastLinearToSlowEaseIn),
      ],
      child: Bounce(
        duration: Duration(milliseconds: isactive ? 100 : 0),
        onTap: isLoading
            ? () {}
            : () {
                if (onTap != null) {
                  onTap!();
                } else if (onTapWithParam != null && param != null) {
                  onTapWithParam!(param!);
                }
              },
        child: Container(
          margin: EdgeInsets.only(
            top: mTop,
            bottom: mBottom,
            left: mhoriz,
            right: mhoriz,
          ),
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: hasgrad ? null : bgColor,
            gradient: hasgrad ? kDynamicPrimaryGradient(context) : null,
            border: Border.all(color: outlineColor ?? kDynamicOutline(context)),
            borderRadius: BorderRadius.circular(radius),
            boxShadow: hasshadow
                ? [
                    BoxShadow(
                      color: kDynamicShadow(context),
                      offset: const Offset(0, 4),
                      blurRadius: 8,
                    ),
                  ]
                : [],
          ),
          child: Material(
            color: Colors.transparent,
            child: Center(
              child: isLoading
                  ? NutriLoader(
                      color: effectiveLoaderColor,
                    ) // Pass the loader color
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (hasicon)
                          Padding(
                            padding: isleft
                                ? const EdgeInsets.only(left: 10.0)
                                : const EdgeInsets.only(right: 6),
                            child: CommonImageView(
                              imagePath: choiceIcon,
                              height: 18,
                              color: txtColor,
                            ),
                          ),
                        MyText(
                          paddingLeft: hasicon ? 8 : 0,
                          text: buttonText,
                          fontFamily: AppFonts.Inter,
                          size: fontSize ?? 16,
                          letterSpacing: 0.5,
                          color: txtColor,
                          weight: fontWeight ?? FontWeight.w800,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to determine the best loader color for the button background
  Color _getLoaderColorForButton(Color? buttonBgColor, BuildContext context) {
    if (buttonBgColor == null) {
      return kDynamicText(context); // Fallback to text color
    }

    // Calculate the brightness of the button background
    final brightness = ThemeData.estimateBrightnessForColor(buttonBgColor);

    // Return contrasting color based on button background
    return brightness == Brightness.dark ? kWhite : kBlack;
  }
}
