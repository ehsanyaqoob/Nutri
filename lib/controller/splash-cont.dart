import 'dart:async';
import 'package:get/get.dart';
import 'package:nutri/Screens/navbar/home/home-screen.dart';
import 'package:nutri/constants/export.dart';
import 'package:nutri/services/storage-services.dart';

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

  void navigateToNextScreen() async {
    // Check if user has seen onboarding
    final shouldShowOnboarding = await StorageService.shouldShowOnboarding();
    
    if (shouldShowOnboarding) {
      // First time user - show onboarding
      NavigationHelper.navigateTo(
        AppLinks.onboard,
        customTransition: Transition.circularReveal,
        customDuration: const Duration(milliseconds: 500),
        isOffAll: true, // Clear splash screen from stack
      );
    } else {
      // Returning user - check authentication
      final authController = Get.find<AuthController>();
      final isAuthenticated = await authController.checkAuthentication();
      
      if (isAuthenticated) {
        // User is logged in - go to navbar
        NavigationHelper.navigateTo(
          AppLinks.navbar,
          customTransition: Transition.circularReveal,
          customDuration: const Duration(milliseconds: 500),
          isOffAll: true, // Clear splash screen from stack
        );
      } else {
        // User not logged in - go to auth
        NavigationHelper.navigateTo(
          AppLinks.auth,
          customTransition: Transition.circularReveal,
          customDuration: const Duration(milliseconds: 500),
          isOffAll: true, // Clear splash screen from stack
        );
      }
    }
  }

  // Method to be called when onboarding is completed
  static void onOnboardingCompleted() async {
    // Mark onboarding as seen
    await StorageService.completeOnboarding();
    
    // Navigate to auth screen
    NavigationHelper.navigateTo(
      AppLinks.auth,
      customTransition: Transition.circularReveal,
      customDuration: const Duration(milliseconds: 500),
      isOffAll: true, // Clear onboarding from stack
    );
  }
}