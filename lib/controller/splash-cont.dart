import 'dart:async';
import 'package:nutri/constants/export.dart';
import 'package:nutri/Screens/common/on-board.dart'; // Add this import

class SplashController extends GetxController {
  RxBool isTime = false.obs;
  RxBool showProgress = false.obs;
  RxDouble progressValue = 0.0.obs;
  Timer? _progressTimer;

  @override
  void onInit() {
    super.onInit();
    startSplashSequence();
  }

  @override
  void onClose() {
    _progressTimer?.cancel();
    super.onClose();
  }

  void startSplashSequence() {
    Future.delayed(const Duration(seconds: 2), () {
      isTime.value = true;
      showProgress.value = true;
      startProgressAnimation();
    });
  }

  void startProgressAnimation() {
    const totalDuration = Duration(seconds: 2);
    const interval = Duration(milliseconds: 16);
    var elapsed = Duration.zero;

    _progressTimer = Timer.periodic(interval, (timer) {
      elapsed += interval;

      if (elapsed >= totalDuration) {
        timer.cancel();
        progressValue.value = 1.0;
        navigateToNextScreen();
      } else {
        progressValue.value =
            elapsed.inMilliseconds / totalDuration.inMilliseconds;
      }
    });
  }

  Future<bool> _shouldShowOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboarding_completed') != true;
  }

  void navigateToNextScreen() async {
    // Check if user has seen onboarding
    final shouldShowOnboarding = await _shouldShowOnboarding();

    if (shouldShowOnboarding) {
      // First time user - show onboarding
      Get.offAll(
        () => const OnboardingView(), // Change to match your actual class name
        transition: Transition.circularReveal,
        duration: const Duration(milliseconds: 500),
      );
    } else {
      // Returning user - check authentication
      final authController = Get.find<AuthController>();
      final isAuthenticated = await authController.checkAuthentication();

      if (isAuthenticated) {
        // User is logged in - go to navbar
        Get.offAll(
          () => const NutriNavBar(),
          transition: Transition.circularReveal,
          duration: const Duration(milliseconds: 500),
        );
      } else {
        // User not logged in - go to auth
        Get.offAll(
          () =>  AuthScreen(),
          transition: Transition.circularReveal,
          duration: const Duration(milliseconds: 500),
        );
      }
    }
  }

  // Method to be called when onboarding is completed
  static void onOnboardingCompleted() async {
    // Mark onboarding as seen
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);

    // Navigate to auth screen
    Get.offAll(
      () =>  AuthScreen(),
      transition: Transition.circularReveal,
      duration: const Duration(milliseconds: 500),
    );
  }
}