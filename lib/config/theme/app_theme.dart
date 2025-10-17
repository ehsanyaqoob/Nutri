import 'package:nutri/constants/export.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: kBlack,
  splashColor: kPrimaryDark.withOpacity(0.10),
  highlightColor: kPrimaryDark.withOpacity(0.10),
  colorScheme: const ColorScheme.dark().copyWith(
    primary: kPrimaryDark,
    secondary: kGreyColor.withOpacity(0.1),
  ),
  useMaterial3: false,
  textSelectionTheme: const TextSelectionThemeData(cursorColor: kWhite),
  appBarTheme: const AppBarTheme(
    backgroundColor: kBlack,
    foregroundColor: kWhite,
    elevation: 0,
  ),
);

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: kWhite,
  appBarTheme: const AppBarTheme(
    elevation: 0, 
    backgroundColor: kPrimaryColor,
    foregroundColor: kBlack,
  ),
  splashColor: kPrimaryColor.withOpacity(0.10),
  highlightColor: kPrimaryColor.withOpacity(0.10),
  colorScheme: const ColorScheme.light().copyWith(
    primary: kPrimaryColor,
    secondary: kGreyColor.withOpacity(0.1),
  ),
  useMaterial3: false,
  textSelectionTheme: const TextSelectionThemeData(cursorColor: kBlack),
);