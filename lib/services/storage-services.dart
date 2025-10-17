// Add these methods to your existing StorageService class
import 'package:nutri/constants/export.dart';

class StorageService {
  static const String _tokenKey = 'user_token';
  static const String _emailKey = 'user_email';
  static const String _nameKey = 'user_name';
  static const String _userIdKey = 'user_id';
  static const String _rememberMeKey = 'remember_me';
  static const String _loginStatusKey = 'login_status';
  static const String _onboardingSeenKey = 'onboarding_seen';
  static const String _firstTimeUserKey = 'first_time_user';

  // ========== AUTHENTICATION METHODS ==========
  
  // Token methods
  static Future<void> setToken(String token) async {
    await GetStorage().write(_tokenKey, token);
  }

  static Future<String> getToken() async {
    return GetStorage().read(_tokenKey) ?? '';
  }

  // Email methods
  static Future<void> setEmail(String email) async {
    await GetStorage().write(_emailKey, email);
  }

  static Future<String> getEmail() async {
    return GetStorage().read(_emailKey) ?? '';
  }

  // Name methods
  static Future<void> setName(String name) async {
    await GetStorage().write(_nameKey, name);
  }

  static Future<String> getName() async {
    return GetStorage().read(_nameKey) ?? '';
  }

  // User ID methods
  static Future<void> setUserId(String userId) async {
    await GetStorage().write(_userIdKey, userId);
  }

  static Future<String?> getUserId() async {
    return GetStorage().read(_userIdKey);
  }

  // Remember me methods
  static Future<void> setRememberMe(bool remember) async {
    await GetStorage().write(_rememberMeKey, remember);
  }

  static Future<bool> getRememberMe() async {
    return GetStorage().read(_rememberMeKey) ?? false;
  }

  // Login status methods
  static Future<void> setLoginStatus(bool isLoggedIn) async {
    await GetStorage().write(_loginStatusKey, isLoggedIn);
  }

  static Future<bool> getLoginStatus() async {
    return GetStorage().read(_loginStatusKey) ?? false;
  }

  // ========== ONBOARDING & FIRST TIME USER METHODS ==========
  
  // Onboarding seen status
  static Future<void> setOnboardingSeen(bool seen) async {
    await GetStorage().write(_onboardingSeenKey, seen);
  }

  static Future<bool> getOnboardingSeen() async {
    return GetStorage().read(_onboardingSeenKey) ?? false;
  }

  // First time user status
  static Future<void> setFirstTimeUser(bool firstTime) async {
    await GetStorage().write(_firstTimeUserKey, firstTime);
  }

  static Future<bool> getFirstTimeUser() async {
    return GetStorage().read(_firstTimeUserKey) ?? true; // Default to true (first time)
  }

  // Mark onboarding as completed
  static Future<void> completeOnboarding() async {
    await setOnboardingSeen(true);
    await setFirstTimeUser(false);
  }

  // Check if user should see onboarding
  static Future<bool> shouldShowOnboarding() async {
    final hasSeenOnboarding = await getOnboardingSeen();
    return !hasSeenOnboarding;
  }

  // ========== USER SESSION MANAGEMENT ==========
  
  // Clear all user data (logout)
  static Future<void> clearUserData() async {
    final rememberMe = await getRememberMe();
    await GetStorage().remove(_tokenKey);
    await GetStorage().remove(_emailKey);
    await GetStorage().remove(_nameKey);
    await GetStorage().remove(_userIdKey);
    await GetStorage().remove(_loginStatusKey);
    
    // Keep onboarding status and remember me preference
    if (!rememberMe) {
      await GetStorage().remove(_rememberMeKey);
    }
  }

  // Clear everything (full reset)
  static Future<void> clearAll() async {
    await GetStorage().erase();
  }

  // Get user session summary
  static Future<Map<String, dynamic>> getUserSession() async {
    return {
      'token': await getToken(),
      'email': await getEmail(),
      'name': await getName(),
      'userId': await getUserId(),
      'isLoggedIn': await getLoginStatus(),
      'rememberMe': await getRememberMe(),
      'onboardingSeen': await getOnboardingSeen(),
      'firstTimeUser': await getFirstTimeUser(),
    };
  }
}