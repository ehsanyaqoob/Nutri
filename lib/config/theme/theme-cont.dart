import 'package:nutri/constants/export.dart';

class ThemeController extends GetxController {
  final Rx<ThemeMode> _themeMode = ThemeMode.light.obs;
  final RxBool _isDarkMode = false.obs;

  ThemeMode get themeMode => _themeMode.value;
  bool get isDarkMode => _isDarkMode.value;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.window.onPlatformBrightnessChanged =
        _handleSystemThemeChange;
  }

  @override
  void onClose() {
    WidgetsBinding.instance.window.onPlatformBrightnessChanged = null;
    super.onClose();
  }

  void _handleSystemThemeChange() {
    if (_themeMode.value == ThemeMode.system) {
      _checkSystemTheme();
      update();
    }
  }

  Future<void> initialize() async {
    await _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? theme = prefs.getString('theme');

      if (theme == null) {
        await switchTheme(ThemeMode.light);
      } else {
        switch (theme) {
          case 'light':
            await switchTheme(ThemeMode.light);
            break;
          case 'dark':
            await switchTheme(ThemeMode.dark);
            break;
          case 'system':
            await switchTheme(ThemeMode.system);
            break;
          default:
            await switchTheme(ThemeMode.light);
        }
      }
    } catch (e) {
      await switchTheme(ThemeMode.light);
    }
  }

  void _checkSystemTheme() {
    final Brightness platformBrightness =
        WidgetsBinding.instance.window.platformBrightness;
    _isDarkMode.value = platformBrightness == Brightness.dark;
  }

  Future<void> switchTheme(ThemeMode mode) async {
    _themeMode.value = mode;

    if (mode == ThemeMode.light) {
      _isDarkMode.value = false;
    } else if (mode == ThemeMode.dark) {
      _isDarkMode.value = true;
    } else {
      _checkSystemTheme();
    }

    final prefs = await SharedPreferences.getInstance();
    switch (mode) {
      case ThemeMode.light:
        await prefs.setString('theme', 'light');
        break;
      case ThemeMode.dark:
        await prefs.setString('theme', 'dark');
        break;
      case ThemeMode.system:
        await prefs.setString('theme', 'system');
        break;
    }
    update();
  }

  void toggleTheme() {
    if (_themeMode.value == ThemeMode.light) {
      switchTheme(ThemeMode.dark);
    } else {
      switchTheme(ThemeMode.light);
    }
  }

  // Helper method for development testing
  Future<void> testSwitchTheme() async {
    if (_themeMode.value == ThemeMode.light) {
      await switchTheme(ThemeMode.dark);
    } else {
      await switchTheme(ThemeMode.light);
    }
  }
}
