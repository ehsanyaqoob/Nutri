import 'dart:ui';

import 'package:nutri/constants/export.dart';

void main() async {

  
  WidgetsFlutterBinding.ensureInitialized();
  final ThemeController themeController = ThemeController();    
  Get.put(AuthController());
  Get.put(ProfileController());
  Get.put(NavController());
  Get.put(ProductController());
  Get.put(FavouritesController(), permanent: true);
  await GetStorage.init();
  await themeController.initialize();
  // Put dependencies in GetX
  Get.put<ThemeController>(themeController);
  // For development testing - uncomment to force a specific theme
  //await themeController.switchTheme(ThemeMode.dark);
  //await themeController.switchTheme(ThemeMode.light);
  await themeController.switchTheme(ThemeMode.system);

  FlutterError.onError = (details) {
    debugPrint('🚨 Flutter Error: ${details.exception}');
    debugPrint('📝 Stack trace: ${details.stack}');
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint('🚨 Platform Error: $error');
    debugPrint('📝 Stack trace: $stack');
    return true;
  };
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return GetMaterialApp(
          title: 'nutri',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeController.themeMode,
          debugShowCheckedModeBanner: false,
          debugShowMaterialGrid: false,
          initialRoute: AppLinks.splash,
          getPages: AppRoutes.pages,
          // Global error handling and keyboard dismissal
          builder: (context, child) {
            return GestureDetector(
              onTap: () {
                // Hide keyboard when tapping outside
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: child,
            );
          },
        );
      },
    );
  }
}


// Flow summary:
// User scans food → 
//AI analyzes → 
//Nutrients extracted → 
//AI predicts meal type (Breakfast/Lunch/Dinner) →
// User confirms →
// Added to Daily Diary → 
//User can view insights,
// trends, and progress over time.