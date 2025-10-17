import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nutri/constants/export.dart';
import 'package:nutri/controller/splash-cont.dart';
import 'package:nutri/extensions/media-query-extension.dart';
import 'package:nutri/widget/dot-loader.dart';
import 'package:nutri/widget/floating-icons.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final SplashController controller = Get.put(SplashController());
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
      ),
    );

    _animationController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateSystemUi();
    });
  }

  void _updateSystemUi() {
    final Brightness platformBrightness =
        WidgetsBinding.instance.window.platformBrightness;
    final bool isDark = platformBrightness == Brightness.dark;
    final Color bgColor = isDark ? kDarkBackground : kLightBackground;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: bgColor,
        systemNavigationBarIconBrightness: isDark
            ? Brightness.light
            : Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        final bool isDarkMode = themeController.isDarkMode;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: isDarkMode
                ? Brightness.light
                : Brightness.dark,
            systemNavigationBarColor: kDynamicScaffoldBackground(context),
            systemNavigationBarIconBrightness: isDarkMode
                ? Brightness.light
                : Brightness.dark,
          ),
          child: Scaffold(
            backgroundColor: kDynamicScaffoldBackground(context),
            body: SafeArea(
              bottom: false,
              child: Obx(() {
                return Stack(
                  children: [
                    /// 🌟 Floating Icons Background
                    Positioned.fill(
                      child: Stack(
                        children: [
                          FloatingIcon(
                            asset: Assets.salad,
                            size: 45,
                            duration: const Duration(seconds: 12),
                          ),
                          FloatingIcon(
                            asset: Assets.salad,
                            size: 38,
                            duration: const Duration(seconds: 15),
                          ),
                          FloatingIcon(
                            asset: Assets.bread,
                            size: 35,
                            duration: const Duration(seconds: 18),
                          ),
                          FloatingIcon(
                            asset: Assets.egg,
                            size: 32,
                            duration: const Duration(seconds: 14),
                          ),
                          FloatingIcon(
                            asset: Assets.pizza,
                            size: 40,
                            duration: const Duration(seconds: 16),
                          ),
                          FloatingIcon(
                            asset: Assets.coffee,
                            size: 30,
                            duration: const Duration(seconds: 13),
                          ),
                          FloatingIcon(
                            asset: Assets.egg,
                            size: 28,
                            duration: const Duration(seconds: 17),
                          ),
                          FloatingIcon(
                            asset: Assets.pizza,
                            size: 33,
                            duration: const Duration(seconds: 11),
                          ),
                        ],
                      ),
                    ),

                    /// 🌿 Center Logo Animation
                    Center(
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 90,
                                width: 90,
                                decoration: BoxDecoration(
                                  color: kPrimaryColor.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    Assets.fire,
                                    height: 40.0,
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ),
                              20.height,
                              MyText(
                                text: "Nutri",
                                color: kDynamicText(context),
                                size: 28,
                                weight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    /// ⏳ Progress loader (bottom)
                    if (controller.showProgress.value)
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: MediaQuery.of(context).padding.bottom + 50,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              MyText(
                                text: "Loading your health data...",
                                color: kDynamicSubtitleText(context),
                                size: 14,
                                weight: FontWeight.w400,
                              ),
                              16.height,
                              const NutriLoader(),
                            ],
                          ),
                        ),
                      ),

                    /// 🌗 Debug theme toggle
                    if (kDebugMode)
                      Positioned(
                        top: 20,
                        right: 20,
                        child: FloatingActionButton(
                          mini: true,
                          backgroundColor: kDynamicBackground(context),
                          onPressed: () => themeController.toggleTheme(),
                          child: Icon(
                            isDarkMode ? Icons.light_mode : Icons.dark_mode,
                            color: kDynamicIcon(context),
                          ),
                        ),
                      ),
                  ],
                );
              }),
            ),
          ),
        );
      },
    );
  }
}