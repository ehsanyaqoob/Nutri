import 'package:get_storage/get_storage.dart';
import 'package:nutri/constants/export.dart';

class Storage {
  static final GetStorage _box = GetStorage();

  static const String _tokenKey = 'user_token';
  static const String _emailKey = 'user_email';
  static const String _nameKey = 'user_name';
  static const String _userIdKey = 'user_id';
  static const String _rememberMeKey = 'remember_me';
  static const String _loginStatusKey = 'login_status';
  static const String _onboardingSeenKey = 'onboarding_seen';
  static const String _firstTimeUserKey = 'first_time_user';
  static const String _appVersionKey = 'app_version';
  static const String _themeModeKey = 'theme_mode';
  static const String _languageKey = 'language';

  static const String _profileImageKey = 'profile_image_path';
 // Add these phone, country, and gender methods:
  static const String _phoneKey = 'user_phone';
  static const String _countryKey = 'user_country';
  static const String _countryCodeKey = 'user_country_code';
  static const String _genderKey = 'user_gender';

  // Phone methods
  static Future<void> setPhone(String phone) async {
    await _box.write(_phoneKey, phone);
  }

  static Future<String?> getPhone() async {
    return _box.read(_phoneKey);
  }

  // Country methods
  static Future<void> setCountry(String country) async {
    await _box.write(_countryKey, country);
  }

  static Future<String?> getCountry() async {
    return _box.read(_countryKey);
  }

  static Future<void> setCountryCode(String countryCode) async {
    await _box.write(_countryCodeKey, countryCode);
  }

  static Future<String?> getCountryCode() async {
    return _box.read(_countryCodeKey);
  }

  // Gender methods
  static Future<void> setGender(String gender) async {
    await _box.write(_genderKey, gender);
  }

  static Future<String?> getGender() async {
    return _box.read(_genderKey);
  }
  static Future<void> setProfileImagePath(String imagePath) async {
    await _box.write(_profileImageKey, imagePath);
  }

  static Future<String?> getProfileImagePath() async {
    return _box.read(_profileImageKey);
  }

  static Future<void> removeProfileImage() async {
    await _box.remove(_profileImageKey);
  }

  static Future<bool> get hasProfileImage async {
    final path = await getProfileImagePath();
    return path != null && path.isNotEmpty;
  }

  static Future<void> setToken(String token) async {
    await _box.write(_tokenKey, token);
  }

  static Future<String> get authToken async {
    return _box.read(_tokenKey) ?? '';
  }

  static Future<void> setEmail(String email) async {
    await _box.write(_emailKey, email);
  }

  static Future<String> get email async {
    return _box.read(_emailKey) ?? '';
  }


  static Future<void> setName(String name) async {
    await _box.write(_nameKey, name);
  }

  static Future<String> get name async {
    return _box.read(_nameKey) ?? '';
  }


  static Future<void> setUserId(String userId) async {
    await _box.write(_userIdKey, userId);
  }

  static Future<String?> get userId async {
    return _box.read(_userIdKey);
  }


  static Future<void> setRememberMe(bool remember) async {
    await _box.write(_rememberMeKey, remember);
  }

  static Future<bool> get rememberMe async {
    return _box.read(_rememberMeKey) ?? false;
  }


  static Future<void> setLoginStatus(bool isLoggedIn) async {
    await _box.write(_loginStatusKey, isLoggedIn);
  }

  static Future<bool> get isLoggedIn async {
    return _box.read(_loginStatusKey) ?? false;
  }


  static Future<void> setOnboardingSeen(bool seen) async {
    await _box.write(_onboardingSeenKey, seen);
  }

  static Future<bool> get onboardingSeen async {
    return _box.read(_onboardingSeenKey) ?? false;
  }


  static Future<void> setFirstTimeUser(bool firstTime) async {
    await _box.write(_firstTimeUserKey, firstTime);
  }

  static Future<bool> get firstTimeUser async {
    return _box.read(_firstTimeUserKey) ?? true;
  }


  static Future<bool> get shouldShowOnboarding async {
    return !(await onboardingSeen);
  }


  static Future<void> setAppVersion(String version) async {
    await _box.write(_appVersionKey, version);
  }

  static Future<String> get appVersion async {
    return _box.read(_appVersionKey) ?? '1.0.0';
  }


  static Future<void> setThemeMode(String theme) async {
    await _box.write(_themeModeKey, theme);
  }

  static Future<String> get themeMode async {
    return _box.read(_themeModeKey) ?? 'system';
  }
  static Future<void> setLanguage(String language) async {
    await _box.write(_languageKey, language);
  }

  static Future<String> get language async {
    return _box.read(_languageKey) ?? 'en';
  }


  static Future<void> saveUserSession({
    required String token,
    required String email,
    required String name,
    required String userId,
    bool rememberMe = false,
  }) async {
    await setToken(token);
    await setEmail(email);
    await setName(name);
    await setUserId(userId);
    await setRememberMe(rememberMe);
    await setLoginStatus(true);
  }

  static Future<void> completeOnboarding() async {
    await setOnboardingSeen(true);
    await setFirstTimeUser(false);
  }

  // Update clearUserData to optionally keep profile data
  static Future<void> clearUserData({bool keepProfile = false}) async {
    final bool shouldRemember = await rememberMe;
    
    await _box.remove(_tokenKey);
    await _box.remove(_emailKey);
    await _box.remove(_nameKey);
    await _box.remove(_userIdKey);
    await _box.remove(_loginStatusKey);
    
    if (!keepProfile) {
      await removeProfileImage();
      await _box.remove(_phoneKey);
      await _box.remove(_countryKey);
      await _box.remove(_countryCodeKey);
      await _box.remove(_genderKey);
    }
    
    if (!shouldRemember) {
      await _box.remove(_rememberMeKey);
    }
  }

  static Future<bool> get hasValidSession async {
    final String token = await authToken;
    final bool loggedIn = await isLoggedIn;
    return token.isNotEmpty && loggedIn;
  }

  static Future<Map<String, dynamic>> get sessionSummary async {
    return {
      'hasToken': (await authToken).isNotEmpty,
      'isLoggedIn': await isLoggedIn,
      'email': await email,
      'name': await name,
      'userId': await userId,
      'rememberMe': await rememberMe,
      'onboardingSeen': await onboardingSeen,
      'firstTimeUser': await firstTimeUser,
      'themeMode': await themeMode,
      'language': await language,
    };
  }

  // static Future<void> init() async {
  //   await GetStorage.init();
  // }
}
