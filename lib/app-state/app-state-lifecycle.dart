import '../constants/export.dart';
class AppLifecycleManager extends GetxController with WidgetsBindingObserver {
  final Rx<AppLifecycleState> _currentState = AppLifecycleState.resumed.obs;
  final RxBool _isInForeground = true.obs;
  final RxBool _isAppPaused = false.obs;
  final RxBool _isAppKilled = false.obs;

  AppLifecycleState get currentState => _currentState.value;
  bool get isInForeground => _isInForeground.value;
  bool get isAppPaused => _isAppPaused.value;
  bool get isAppKilled => _isAppKilled.value;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    _initializeAppState();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  void _initializeAppState() {
    _isInForeground.value = true;
    _isAppPaused.value = false;
    _isAppKilled.value = false;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _currentState.value = state;
    
    switch (state) {
      case AppLifecycleState.resumed:
        _onAppResumed();
        break;
      case AppLifecycleState.inactive:
        _onAppInactive();
        break;
      case AppLifecycleState.paused:
        _onAppPaused();
        break;
      case AppLifecycleState.detached:
        _onAppDetached();
        break;
      case AppLifecycleState.hidden:
        _onAppHidden();
        break;
    }
  }

  void _onAppResumed() {
    _isInForeground.value = true;
    _isAppPaused.value = false;
    _isAppKilled.value = false;
    debugPrint('🔄 App Resumed - Rebuilding UI, restoring state');
  }

  void _onAppInactive() {
    _isInForeground.value = false;
    debugPrint('⏸️ App Inactive - Saving temporary state');
  }

  void _onAppPaused() {
    _isInForeground.value = false;
    _isAppPaused.value = true;
    debugPrint('🚫 App Paused - Persisting important data');
  }

  void _onAppDetached() {
    _isAppKilled.value = true;
    debugPrint('💀 App Detached/Killed - Final cleanup');
  }

  void _onAppHidden() {
    _isInForeground.value = false;
    debugPrint('👻 App Hidden - Background operations');
  }

  void forceSaveState() {
    debugPrint('💾 Force saving app state');
  }
}