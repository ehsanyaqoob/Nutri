import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nutri/Screens/auth/auth-swipe-screen.dart';
import 'package:nutri/widget/bottomsheets/helper-sheets.dart';

class OnboardingController extends GetxController {
  final RxInt currentPage = 0.obs;
  final RxBool isLoading = false.obs;
  final RxBool hasCompletedOnboarding = false.obs;

  final List<Map<String, dynamic>> onboardingData = [
  {
    'title': 'AI-Powered Food Scanning',
    'icon': 'scan',
    'lines': [
      'Point camera at any food item',
      'Get instant nutrition facts instantly',
      'No manual logging required ever',
      'Ninety five percent accurate recognition',
      'Scan packaged foods and ingredients',
      'Identify calories and macros quickly',
    ],
  },
  {
    'title': 'Smart Nutrition Tracking System',
    'icon': 'chart',
    'lines': [
      'Track your daily calorie intake',
      'Monitor all your macro nutrients',
      'Set personalized health goals easily',
      'Get detailed weekly progress reports',
      'Analyze your eating patterns daily',
      'Watch your health improve steadily',
    ],
  },
  {
    'title': 'Personalized Health Insights',
    'icon': 'insights',
    'lines': [
      'Receive AI powered meal recommendations',
      'Get personalized nutrition plan suggestions',
      'Track your health progress analytics',
      'Analyze your dietary trend patterns',
      'Receive weekly health improvement tips',
      'Get custom fitness goal advice',
    ],
  },
  {
    'title': 'Ready To Begin Journey',
    'icon': 'ready',
    'lines': [
      'Join thousands of happy users',
      'Start your health journey today',
      'Transform your eating habits completely',
      'Achieve all your fitness goals',
      'Track your progress every day',
      'Become your healthiest self ever',
    ],
  },
];
  // ───────────────────────────────
  // PAGE MANAGEMENT
  // ───────────────────────────────
  void updatePage(int page) => currentPage.value = page;

  bool get isLastPage => currentPage.value == onboardingData.length - 1;

  // ───────────────────────────────
  // PERMISSIONS HANDLER
  // ───────────────────────────────
  Future<void> _requestPermissions() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      Future<void> handlePermission(
        Permission permission,
        String key,
        RxBool? controllerValue,
      ) async {
        final saved = prefs.getBool(key);
        if (saved == true) return; // Already granted

        final status = await permission.status;

        // Skip permanently denied
        if (status.isPermanentlyDenied) {
          await prefs.setBool(key, false);
          return;
        }

        // Request permission
        final result = await permission.request();
        final granted = result.isGranted;

        // Save result
        await prefs.setBool(key, granted);

        // Update controller if attached
        if (controllerValue != null) {
          controllerValue.value = granted;
        }
      }

      // Fetch privacy controller if available
      PrivacySheetController? privacyController;
      if (Get.isRegistered<PrivacySheetController>()) {
        privacyController = Get.find<PrivacySheetController>();
      }

      // Handle each permission
      await handlePermission(
        Permission.camera,
        'camera_permission',
        privacyController?.cameraPermission,
      );

      await handlePermission(
        Permission.photos,
        'photo_permission',
        privacyController?.photoPermission,
      );

      await handlePermission(
        Permission.notification,
        'notification_permission',
        privacyController?.notificationPermission,
      );
    } catch (e) {
      print('Error requesting permissions: $e');
    }
  }

  // ───────────────────────────────
  // ONBOARDING COMPLETION
  // ───────────────────────────────
  Future<void> completeOnboarding() async {
    if (isLoading.value) return;
    isLoading.value = true;

    try {
      await _requestPermissions();
      await _markOnboardingCompleted();
      _navigateToAuth();
    } catch (e) {
      print('Error completing onboarding: $e');
      _navigateToAuth();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _markOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);
    hasCompletedOnboarding.value = true;
  }

  void _navigateToAuth() => Get.offAll(() => AuthScreen());

  Future<void> checkOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    hasCompletedOnboarding.value =
        prefs.getBool('onboarding_completed') ?? false;
  }

  // ───────────────────────────────
  // RESET (optional for settings)
  // ───────────────────────────────
  Future<void> resetPermissionStates() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('camera_permission');
    await prefs.remove('photo_permission');
    await prefs.remove('notification_permission');
  }
}
