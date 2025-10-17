import 'package:nutri/constants/export.dart';
import 'package:nutri/Screens/splash.dart';

class AppRoutes {
  static final List<GetPage> pages = [
    GetPage(name: AppLinks.splash_screen, page: () => SplashScreen()),
    // GetPage(name: AppLinks.initial_screen, page: () => InitialScreen()),

  ];
}

class AppLinks {
  static const splash_screen = '/splash_screen';
  static const initial_screen = '/initial_screen';
}
