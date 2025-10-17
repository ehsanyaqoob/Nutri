
import 'package:nutri/Screens/auth/auth-swipe-screen.dart';
import 'package:nutri/Screens/book-mark-screen.dart';
import 'package:nutri/Screens/navbar/home/home-screen.dart';
import 'package:nutri/Screens/navbar/menu/menu-screen.dart';
import 'package:nutri/Screens/navbar/profile/profile-screen.dart';
import 'package:nutri/Screens/navbar/progress/progress-screen.dart';
import 'package:nutri/Screens/navbar/rewards/rewards-screen.dart';
import 'package:nutri/Screens/navbar/scan/scan-screen.dart';
import 'package:nutri/Screens/notification-screen.dart';
import 'package:nutri/constants/export.dart';
import 'package:nutri/Screens/splash.dart';
import 'package:nutri/Screens/on-board.dart';

// Route configuration model
class RouteConfig {
  final String name;
  final Widget Function() page;
  final Transition? transition;
  final Duration? transitionDuration;
  final bool isOffAll;

  const RouteConfig({
    required this.name,
    required this.page,
    this.transition,
    this.transitionDuration,
    this.isOffAll = false,
  });
}

class AppLinks {
  static const splash = '/splash_screen';
  static const onboard = '/onboard';
  static const auth = '/auth';
  static const home = '/home';
  static const navbar = '/navbar';
  static const scan = '/scan';
  static const diary = '/diary';
  static const progress = '/progress';
  static const rewards = '/rewards';
  static const menu = '/menu';
  static const profile = '/profile';
  static const notify = '/notify';
  static const bookmark = '/bookmark';
  static const settings = '/settings';
  static const foodDetail = '/food_detail';
  static const mealPlan = '/meal_plan';
  
}

class AppRoutes {
  static final Map<String, RouteConfig> _routeConfigs = {
    AppLinks.splash: RouteConfig(
      name: AppLinks.splash,
      page: () => SplashScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 600),
      isOffAll: true,
    ),

    AppLinks.onboard: RouteConfig(
      name: AppLinks.onboard,
      page: () => OnBoardingView(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 500),
      isOffAll: false,
    ),
    AppLinks.auth: RouteConfig(
      name: AppLinks.auth,
      page: () => AuthScreen(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 500),
      isOffAll: false,
    ),

    AppLinks.home: RouteConfig(
      name: AppLinks.home,
      page: () => HomeScreen(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 600),
      isOffAll: true,
    ),AppLinks.navbar: RouteConfig(
      name: AppLinks.navbar,
      page: () => NutriNavBar(),
      transition: Transition.circularReveal,
      transitionDuration: const Duration(milliseconds: 600),
      isOffAll: true,
    ),

    AppLinks.notify: RouteConfig(
      name: AppLinks.notify,
      page: () => NotificationScreen(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 600),
      isOffAll: false,
    ),

    AppLinks.bookmark: RouteConfig(
      name: AppLinks.bookmark,
      page: () => BookMarkScreen(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 600),
      isOffAll: false,
    ),

    AppLinks.profile: RouteConfig(
      name: AppLinks.profile,
      page: () => ProfileScreen(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 600),
      isOffAll: false,
    ),
 AppLinks.scan: RouteConfig(
      name: AppLinks.scan,
      page: () => ScanScreen(),
      transition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 450),
    ),
     AppLinks.progress: RouteConfig(
      name: AppLinks.progress,
      page: () => ProgressScreen(),
      transition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 450),
    ),
     AppLinks.rewards: RouteConfig(
      name: AppLinks.rewards,
      page: () => RewardsScreen(),
      transition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 450),
    ),
     AppLinks.menu: RouteConfig(
      name: AppLinks.menu,
      page: () => MenuScreen(),
      transition: Transition.cupertino,
      transitionDuration: Duration(milliseconds: 450),
    ),
    // COMMENTED OUT - UNCOMMENT WHEN SCREENS ARE AVAILABLE
    /*
    AppLinks.login: RouteConfig(
      name: AppLinks.login,
      page: () => LoginScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 400),
      isOffAll: true,
    ),
  
    AppLinks.scan: RouteConfig(
      name: AppLinks.scan,
      page: () => ScanScreen(),
      transition: Transition.upToDown,
      transitionDuration: Duration(milliseconds: 450),
    ),
    AppLinks.diary: RouteConfig(
      name: AppLinks.diary,
      page: () => DiaryScreen(),
      transition: Transition.leftToRight,
      transitionDuration: Duration(milliseconds: 450),
    ),
    AppLinks.profile: RouteConfig(
      name: AppLinks.profile,
      page: () => ProfileScreen(),
      transition: Transition.downToUp,
      transitionDuration: Duration(milliseconds: 500),
    ),
    */
  };

  // Get all pages for GetMaterialApp
  static List<GetPage> get pages => _routeConfigs.values.map((config) {
    return GetPage(
      name: config.name,
      page: config.page,
      transition: config.transition ?? Transition.cupertino,
      transitionDuration:
          config.transitionDuration ?? const Duration(milliseconds: 300),
    );
  }).toList();

  // Get route configuration by name
  static RouteConfig? getRouteConfig(String routeName) {
    return _routeConfigs[routeName];
  }

  // Check if route exists
  static bool hasRoute(String routeName) {
    return _routeConfigs.containsKey(routeName);
  }

  // Get all route names
  static List<String> get routeNames => _routeConfigs.keys.toList();
}

class NavigationHelper {
  // Generic navigation method that uses route configurations
  static void navigateTo(
    String routeName, {
    Map<String, dynamic>? arguments,
    bool? isOffAll,
    Transition? customTransition,
    Duration? customDuration,
  }) {
    final config = AppRoutes.getRouteConfig(routeName);

    if (config == null) {
      print('Route $routeName not found!');
      return;
    }

    final transition =
        customTransition ?? config.transition ?? Transition.cupertino;
    final duration =
        customDuration ??
        config.transitionDuration ??
        const Duration(milliseconds: 300);
    final useOffAll = isOffAll ?? config.isOffAll;

    if (useOffAll) {
      Get.offAllNamed(routeName, arguments: arguments);
    } else {
      Get.toNamed(routeName, arguments: arguments);
    }
  }

  // Predefined navigation methods for convenience - ONLY WORKING ROUTES
  static void toSplash() => navigateTo(AppLinks.splash);
  static void toOnboarding() => navigateTo(AppLinks.onboard);
  static void tonotification() => navigateTo(AppLinks.notify);
  static void tobookmark() => navigateTo(AppLinks.bookmark);
  static void profile() => navigateTo(AppLinks.profile);

  // COMMENTED OUT - UNCOMMENT WHEN SCREENS ARE AVAILABLE
  /*
  static void toLogin() => navigateTo(AppLinks.login);
  static void toHome() => navigateTo(AppLinks.home);
  static void toSignup() => navigateTo(AppLinks.signup);
  static void toScan() => navigateTo(AppLinks.scan);
  static void toDiary() => navigateTo(AppLinks.diary);
  static void toProgress() => navigateTo(AppLinks.progress);
  static void toProfile() => navigateTo(AppLinks.profile);
  static void toSettings() => navigateTo(AppLinks.settings);
  static void toFoodDetail({Map<String, dynamic>? arguments}) =>
      navigateTo(AppLinks.foodDetail, arguments: arguments);
  static void toMealPlan() => navigateTo(AppLinks.mealPlan);
  */

  // Custom transition methods (override default configs)
  static void toOnboardingWithCircularReveal() {
    navigateTo(
      AppLinks.onboard,
      customTransition: Transition.circularReveal,
      customDuration: const Duration(milliseconds: 500),
    );
  }

  // Direct widget navigation for special cases
  static void navigateToWidget(
    Widget Function() page, {
    Transition transition = Transition.circularReveal,
    Duration duration = const Duration(milliseconds: 500),
    bool offAll = false,
  }) {
    if (offAll) {
      Get.offAll(page, transition: transition, duration: duration);
    } else {
      Get.to(page, transition: transition, duration: duration);
    }
  }

  // Utility methods
  static void back<T>([T? result]) => Get.back(result: result);

  static void backUntil(String routeName) =>
      Get.until((route) => route.settings.name == routeName);

  static void backToHome() {
    if (AppRoutes.hasRoute(AppLinks.home)) {
      backUntil(AppLinks.home);
    } else {
      backUntil(AppLinks.onboard);
    }
  }

  static void reloadCurrent() {
    final currentRoute = Get.currentRoute;
    if (currentRoute.isNotEmpty && AppRoutes.hasRoute(currentRoute)) {
      Get.offAllNamed(currentRoute);
    }
  }

  // Get current route info
  static String get currentRoute => Get.currentRoute;
  static bool get canPop => Get.key.currentState?.canPop() ?? false;

  // Clear all screens and go to specific route
  static void clearStackAndGoTo(String routeName) {
    if (AppRoutes.hasRoute(routeName)) {
      Get.offAllNamed(routeName);
    }
  }
}


// // Go back
// NavigationHelper.back();

// // Go back with result
// NavigationHelper.back('success');

// // Go back until specific screen
// NavigationHelper.backUntil(AppLinks.home);

// // Go back to home (fallback to onboarding)
// NavigationHelper.backToHome();

// // Reload current screen
// NavigationHelper.reloadCurrent();

// // Clear entire stack and go to specific screen
// NavigationHelper.clearStackAndGoTo(AppLinks.splash);

// // Quick navigation to common screens
// NavigationHelper.toSplash();           // → Splash Screen
// NavigationHelper.toOnboarding();       // → Onboarding
// NavigationHelper.tonotification();     // → Notifications  
// NavigationHelper.tobookmark();         // → Bookmarks
// NavigationHelper.profile();            // → Profile

// // Special transitions
// NavigationHelper.toOnboardingWithCircularReveal(); // Circular reveal animation
// // Navigate to any screen
// NavigationHelper.navigateTo(AppLinks.home);

// // Navigate with custom transition
// NavigationHelper.navigateTo(
//   AppLinks.auth,
//   customTransition: Transition.circularReveal,
//   customDuration: const Duration(milliseconds: 500),
// );

// // Navigate and clear stack
// NavigationHelper.navigateTo(
//   AppLinks.navbar,
//   isOffAll: true, // Clear all previous screens
// );