import 'package:nutri/constants/export.dart';

bool kIsDarkMode(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark;

Color kDynamicBackground(BuildContext context) =>
    kIsDarkMode(context) ? kDarkBackground : kLightBackground;

Color kDynamicScaffoldBackground(BuildContext context) =>
    kIsDarkMode(context) ? kDarkBackground : kbackground;

Color kDynamicPrimary(BuildContext context) =>
    kIsDarkMode(context) ? kPrimaryDark : kPrimaryColor;

Color kDynamicSecondary(BuildContext context) =>
    kIsDarkMode(context) ? kSecondaryDark : kSecondaryColor;

Color kDynamicText(BuildContext context) =>
    kIsDarkMode(context) ? kWhite : kBlack;

Color kDynamicIcon(BuildContext context) =>
    kIsDarkMode(context) ? kWhite : kBlack;

Color kDynamicCard(BuildContext context) =>
    kIsDarkMode(context) ? kCardDark : kWhite;

Color kDynamicTile(BuildContext context) =>
    kIsDarkMode(context) ? kTileDark : kTileLight;

Color kDynamicContainer(BuildContext context) =>
    kIsDarkMode(context) ? kCardDark : kWhite;

Color kDynamicSurface(BuildContext context) =>
    kIsDarkMode(context) ? kCardDark : kWhite;

Color kDynamicElevatedSurface(BuildContext context) =>
    kIsDarkMode(context) ? kTileDark : kGreyContainerGreyColor2;

Color kDynamicTitleText(BuildContext context) =>
    kIsDarkMode(context) ? kWhite : kBlack;

Color kDynamicBodyText(BuildContext context) =>
    kIsDarkMode(context) ? kTextGray : kTextDark;

Color kDynamicSubtitleText(BuildContext context) =>
    kIsDarkMode(context) ? kTextGray : kSubText;

Color kDynamicCaptionText(BuildContext context) =>
    kIsDarkMode(context) ? kGreyColor4 : kSubText2;

Color kDynamicHintText(BuildContext context) =>
    kIsDarkMode(context) ? kGreyColor4 : kGreyColor;

Color kDynamicBorder(BuildContext context) =>
    kIsDarkMode(context) ? kDividerDark : kDividerLight;

Color kDynamicDivider(BuildContext context) =>
    kIsDarkMode(context) ? kDividerDark : kDividerColor;

Color kDynamicOutline(BuildContext context) =>
    kIsDarkMode(context) ? kGreyColor4 : kGreyborder;
/// Radio Button Colors (respects light & dark mode)
Color kDynamicRadioActive(BuildContext context) =>
    kDynamicIcon(context);

Color kDynamicRadioFill(BuildContext context) =>
    kDynamicText(context);

Color kDynamicRadioOverlay(BuildContext context) =>
    kDynamicHighlightColor(context);

Color kDynamicRadioBorder(BuildContext context, bool isSelected) =>
     kDynamicBorder(context);

Color kDynamicRadioInner(BuildContext context) =>
   kDynamicBorder(context);



Color kDynamicSeparator(BuildContext context) =>
    kIsDarkMode(context) ? kDividerDark : kDividerColor;

Color kDynamicButtonBackground(BuildContext context) =>
    kIsDarkMode(context) ? kPrimaryDark : kPrimaryColor;

Color kDynamicButtonText(BuildContext context) =>
    kIsDarkMode(context) ? kWhite : kWhite;

Color kDynamicButtonDisabled(BuildContext context) =>
    kIsDarkMode(context) ? kGreyColor4 : kGreyColor3;

Color kDynamicLinkText(BuildContext context) =>
    kIsDarkMode(context) ? kBlue : kBlueAccent;

Color kDynamicSelectionColor(BuildContext context) => kIsDarkMode(context)
    ? kPrimaryDark.withOpacity(0.3)
    : kPrimaryColor.withOpacity(0.3);

Color kDynamicHighlightColor(BuildContext context) =>
    kIsDarkMode(context) ? kWhite.withOpacity(0.1) : kBlack.withOpacity(0.1);

Color kDynamicSplashColor(BuildContext context) =>
    kIsDarkMode(context) ? kWhite.withOpacity(0.2) : kBlack.withOpacity(0.2);

Color kDynamicSuccess(BuildContext context) =>
    kIsDarkMode(context) ? kgreenColor : kgreenColor;

Color kDynamicSuccessBackground(BuildContext context) =>
    kIsDarkMode(context) ? kgreenColorLight : kgreenColorLight;

Color kDynamicError(BuildContext context) =>
    kIsDarkMode(context) ? kredColor : kredColor;

Color kDynamicErrorBackground(BuildContext context) =>
    kIsDarkMode(context) ? kredColorLight : kredColorLight;

Color kDynamicWarning(BuildContext context) =>
    kIsDarkMode(context) ? kYellowColor : kYellowColor;

Color kDynamicWarningBackground(BuildContext context) =>
    kIsDarkMode(context) ? kYellowColorLight : kYellowColorLight;

Color kDynamicInfo(BuildContext context) =>
    kIsDarkMode(context) ? kBlue : kBlueAccent;

Color kDynamicInfoBackground(BuildContext context) =>
    kIsDarkMode(context) ? kbackgroundBlueContainer : kbackgroundBlueContainer;

Color kDynamicInputBackground(BuildContext context) =>
    kIsDarkMode(context) ? kCardDark : kWhite;

Color kDynamicInputBorder(BuildContext context) =>
    kIsDarkMode(context) ? kGreyColor4 : kGreyborder;

Color kDynamicInputText(BuildContext context) =>
    kIsDarkMode(context) ? kWhite : kBlack;

Color kDynamicInputHint(BuildContext context) =>
    kIsDarkMode(context) ? kGreyColor4 : kGreyColor;

Color kDynamicInputLabel(BuildContext context) =>
    kIsDarkMode(context) ? kTextGray : kSubText;

Color kDynamicInputError(BuildContext context) =>
    kIsDarkMode(context) ? kredColor : kredColor;

Color kDynamicAppBarBackground(BuildContext context) =>
    kIsDarkMode(context) ? kDarkBackground : kPrimaryColor;

Color kDynamicAppBarText(BuildContext context) =>
    kIsDarkMode(context) ? kWhite : kWhite;

Color kDynamicNavigationBarBackground(BuildContext context) =>
    kIsDarkMode(context) ? kDarkBackground : kWhite;

Color kDynamicNavigationBarItem(BuildContext context) =>
    kIsDarkMode(context) ? kGreyColor4 : kGreyColor;

Color kDynamicNavigationBarSelectedItem(BuildContext context) =>
    kIsDarkMode(context) ? kWhite : kBlack;
Color kDynamicTabBarBackground(BuildContext context) =>
    kIsDarkMode(context) ? kDarkBackground : kLightBackground;

Color kDynamicTabBarIndicator(BuildContext context) =>
    kIsDarkMode(context) ? kPrimaryDark : kPrimaryColor;

Color kDynamicTabBarUnselectedText(BuildContext context) =>
    kIsDarkMode(context) ? kTextGray : kTextDark;

Color kDynamicTabBarSelectedText(BuildContext context) =>
    kDynamicIconOnPrimary(context);

Color kDynamicTabBarBorder(BuildContext context) =>
    kIsDarkMode(context) ? kGreyColor4 : kGreyborder;

Color kDynamicTabBarUnselectedBackground(BuildContext context) =>
    kTransperentColor;

Color kDynamicTabBarSelectedBorder(BuildContext context) =>
    kDynamicPrimary(context);

Color kDynamicListTileBackground(BuildContext context) =>
    kIsDarkMode(context) ? kTileDark : kTileLight;

Color kDynamicListTileText(BuildContext context) =>
    kIsDarkMode(context) ? kWhite : kBlack;

Color kDynamicListTileSubtitle(BuildContext context) =>
    kIsDarkMode(context) ? kTextGray : kSubText;

Color kDynamicListDivider(BuildContext context) =>
    kIsDarkMode(context) ? kDividerDark : kDividerColor;

Color kDynamicGridItemBackground(BuildContext context) =>
    kIsDarkMode(context) ? kCardDark : kWhite;

Color kDynamicOverlay(BuildContext context) =>
    kIsDarkMode(context) ? kOverLay : klightblackColor;

Color kDynamicModalBackground(BuildContext context) =>
    kIsDarkMode(context) ? kCardDark : kWhite;

Color kDynamicDialogBackground(BuildContext context) =>
    kIsDarkMode(context) ? kCardDark : kWhite;

Color kDynamicBottomSheetBackground(BuildContext context) =>
    kIsDarkMode(context) ? kCardDark : kWhite;

Color kDynamicShadow(BuildContext context) => kIsDarkMode(context)
    ? kAccentBlack.withOpacity(0.4)
    : kBlack.withOpacity(0.1);

Color kDynamicElevationShadow(BuildContext context) => kIsDarkMode(context)
    ? kAccentBlack.withOpacity(0.6)
    : kBlack.withOpacity(0.2);

LinearGradient kDynamicPrimaryGradient(BuildContext context) => LinearGradient(
  colors: [
    kDynamicPrimary(context),
    kIsDarkMode(context) ? kAccentBlack : kPrimaryColor,
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

LinearGradient kDynamicBackgroundGradient(BuildContext context) =>
    LinearGradient(
      colors: [
        kDynamicBackground(context),
        kIsDarkMode(context) ? kAccentBlack : kLightBackground.withOpacity(0.9),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

LinearGradient kDynamicCardGradient(BuildContext context) => LinearGradient(
  colors: [
    kDynamicCard(context),
    kIsDarkMode(context) ? kCardDark.withOpacity(0.9) : kWhite.withOpacity(0.9),
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

Color kDynamicSystemRed(BuildContext context) => kRed;
Color kDynamicSystemBlue(BuildContext context) => kBlue;
Color kDynamicSystemGreen(BuildContext context) => kGreen;
Color kDynamicSystemOrange(BuildContext context) => kOrange;
Color kDynamicSystemPurple(BuildContext context) => kPurple;
Color kDynamicSystemYellow(BuildContext context) => kYellowColor;
Color kDynamicSystemPink(BuildContext context) => kPink;
Color kDynamicSystemCyan(BuildContext context) => kCyran;
Color kDynamicIconOnPrimary(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark
      ? Colors.black
      : Colors.white;
}

Color kDynamicColor(BuildContext context, Color lightColor, Color darkColor) =>
    kIsDarkMode(context) ? darkColor : lightColor;

Color kDynamicOpacity(
  BuildContext context,
  Color color, {
  double lightOpacity = 1.0,
  double darkOpacity = 1.0,
}) => color.withOpacity(kIsDarkMode(context) ? darkOpacity : lightOpacity);

Color kDynamicLoaderPrimary(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark
    ? kSecondaryColor
    : kPrimaryColor;

Color kDynamicLoaderBackground(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark
    ? kSecondaryDark
    : kSecondaryColor.withOpacity(0.2);

extension ThemeContextExtensions on BuildContext {
  bool get isDarkMode => kIsDarkMode(this);

  Color get background => kDynamicBackground(this);
  Color get primary => kDynamicPrimary(this);
  Color get text => kDynamicText(this);
  Color get card => kDynamicCard(this);
  Color get surface => kDynamicSurface(this);
  Color get error => kDynamicError(this);
  Color get success => kDynamicSuccess(this);
  Color get warning => kDynamicWarning(this);
}
// 🍊 Primary Brand Colors
const kPrimaryColor = Color(0xFFFF8C1A);   
const kPrimaryDark  = Color(0xFFE67A00);   

// 🩶 Secondary / Surface Colors
const kSecondaryColor = Color(0xFFD4D0C8); 
const kSecondaryDark  = Color(0xFF2C2C2E); 

// 🩶 Backgrounds
const kLightBackground = Color(0xFFFFFFFF); 
const kDarkBackground  = Color(0xFF1C1C1E);

const kCardDark = Color(0xFF2C2C2E);
const kTileLight = Color(0xFFF7F7F7);
const kTileDark = Color(0xFF3A3A3C);

/// Neutral / Text
const kBlack = Color(0xFF000000);
const kWhite = Color(0xFFFFFFFF);

const kTextDark = Color(0xFF3A3A3C);
const kTextGray = Color(0xFF8E8E93);

/// System Accent Colors (Funica inspired)
const kRed = Color(0xFFFF3B30);
const kBlue = Color(0xFF007AFF);
const kGreen = Color(0xFF34C759);
const kOrange = Color(0xFFFF9500);
const kPurple = Color(0xFF5856D6);

/// Accent Shades
const kAccentBlack = Color(0xFF0E0E0E);
const kAccentGray = Color(0xFF4E4E4E);
const kAccentGrayLight = Color(0xFF8E8E8E);
final kAccentColor4 = Color(0x800E0E0E);

/// Divider / Border
const kDividerLight = Color(0xFFE5E5EA);
const kDividerDark = Color(0xFF3A3A3C);

final kOverLay = Color(0x80000000);
final KSectionBg = Color(0xFF2F2F2F);

/// Backgrounds
const kbackground = Color(0xFFF9FAFB);
const kbackgroundSplash = Color(0xFF06021D);
const kbackgroundpinput = Color(0xFFE9E8E8);
const kbackgroundContainer = Color(0xFFE6E7EA);
const kbackgroundBlueContainer = Color(0xFFEAF5FF);
const kbackgroundBlue2Container = Color(0xFF0B59A7);

/// Text Variants
const kSubText = Color(0xFF848E99);
const kSubText2 = Color(0xFF53555B);
const kSubText3 = Color(0xFF8A938E);
const kSubText4 = Color(0xFF89938D);
const kBlackText = Color(0xFF000000);
const kTextWhite = Color(0xFFFFFFFF);
const kPurpleText = Color(0xFF49243E);

/// Extra Accent Colors
const kPurple2 = Color(0xFFA66FB5);
const kPurpleAccent = Color(0xFFAE0AC9);

const kredColor = Color(0xFFFF3B30);
const kredColorLight = Color(0x5BFECDCA);
const kOrangeColor = Color(0xFFFF7F0E);
const kYellowColor = Color(0xFFF5BD4F);
const kYellowColorLight = Color(0x7FFEF0C7);
const kgreenColor = Color(0xFF34C759);
const kgreenColorLight = Color(0x2634C759);
const kBlueAccent = Color(0xFF3285CD);
const kCyran = Color(0xFF6AE9E9);
const kPink = Color(0xFFBA2387);

/// Grey Scale
const kGreyColor = Color(0xff767676);
const kGreyColor2 = Color(0xffd8dadc);
const kGreyColor3 = Color(0xffBABBBE);
const kGreyColor4 = Color(0xff8D8D8D);
const kGreyColor5 = Color(0xffA1A1A1);
const kGreyColor6 = Color(0xFFEAEAEA);
const kGreylightColor = Color(0xffe3e3e3);
const klightGrey2 = Color(0x1F787878);
const kLinearProgressbgGreyColor = Color(0xFFE9E9E9);

/// Black Shades
const kBlacklightColor = Color(0xff222222);
const klightblackColor = Color(0x80000000);
const kBlackBg = Color(0xff222222);
const kBlack300 = Color(0xFF151515);
const kBlack200 = Color(0xFF333333);
const kBlack150 = Color(0xFF666666);
const kBlack100 = Color(0xFF9D9D9D);
const kBlack50 = Color(0xFFD5D5D5);
const kBlack25 = Color(0xFFF8F8F8);

/// Containers
const kGreyContainerColor = Color(0xFFEBEBEB);
const kGreyContainerGreyColor = Color(0xFFE0E0E0);
const kGreyContainerGreyColor2 = Color(0xFFF5F5F5);
const kGreyContainerGreenColor = Color(0x1908AD69);
const kContainerCyranColor = Color(0xFFE3FCFC);
const kContainerRedColor = Color(0xFFB70F0F);
const kContainerRedColor2 = Color(0xFFFEEEEE);
const kContainerYellowColor = Color(0xFFF5BD4F);
const kContainerYellowColor2 = Color(0xFFFCF6D4);

/// Field & Stroke
const kFeild = Color(0xFF1B1B1B);
const kStroke = Color(0xFF313131);

/// Borders & Dividers
const kDividerColor = Color(0xFFE7E7E7);
const kDividerColor2 = Color(0xFFA4A4A6);
const kBorderColor = Color(0xFFE6E6E6);
const kBorderColor2 = Color(0xFFF6F6F6);
const kBorderColor3 = Color(0xFFC2C2C2);
const kGreyDividerColor = Color(0x33000000);
const kGreyborder = Color(0xffBCBCBC);
const kGreyborder2 = Color(0xffD0D5DD);
const kGreyborder3 = Color(0xffB7B7B7);

/// Transparent
const kTransperentColor = Colors.transparent;
