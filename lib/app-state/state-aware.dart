import '../constants/export.dart';

class StateAwareWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback? onResume;
  final VoidCallback? onPause;
  final VoidCallback? onInactive;

  const StateAwareWidget({
    super.key,
    required this.child,
    this.onResume,
    this.onPause,
    this.onInactive,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppLifecycleManager>(
      builder: (lifecycleManager) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _handleLifecycleState(lifecycleManager.currentState);
        });

        return child;
      },
    );
  }

  void _handleLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        onResume?.call();
        break;
      case AppLifecycleState.paused:
        onPause?.call();
        break;
      case AppLifecycleState.inactive:
        onInactive?.call();
        break;
      default:
        break;
    }
  }
}