import 'dart:async';
import 'package:nutri/constants/export.dart';

class AppToast {
  static OverlayEntry? _overlayEntry;
  static Timer? _timer;
  static const Duration _toastDuration = Duration(seconds: 3);
  static const double _toastElevation = 6.0;
  static const double _toastBorderRadius = 12.0;
  static const double _toastFontSize = 14.0;
  static const EdgeInsets _toastPadding = EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 12.0,
  );
  static const EdgeInsets _toastMargin = EdgeInsets.only(top: 36.0);

  static void success(String message) {
    _showCustomToast(
      message,
      backgroundColor: kBlack,
      icon: Icons.check_circle,
    );
  }

  static void error(String message) {
    _showCustomToast(message, backgroundColor: kBlack, icon: Icons.error);
  }

  static void warning(String message) {
    _showCustomToast(message, backgroundColor: kBlack, icon: Icons.warning);
  }

  static void info(String message) {
    _showCustomToast(message, backgroundColor: kBlack, icon: Icons.info);
  }

  static void _showCustomToast(
    String message, {
    required Color backgroundColor,
    required IconData icon,
  }) {
    _removeToast();
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 20,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: AnimatedOpacity(
            opacity: 1.0,
            duration: const Duration(milliseconds: 300),
            child: Center(
              child: Container(
                padding: _toastPadding,
                margin: _toastMargin,
                decoration: BoxDecoration(
                  color: backgroundColor.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(_toastBorderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, color: Colors.white, size: 20),
                   Gap(12),
                    Expanded(
                      child: MyText(
                        text: 
                        message,
                          color: Colors.white,
                          size: _toastFontSize,
                          weight: FontWeight.w500,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    Overlay.of(Get.overlayContext!).insert(_overlayEntry!);
    _timer = Timer(_toastDuration, _removeToast);
  }

  static void _removeToast() {
    _timer?.cancel();
    _timer = null;

    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }
}
