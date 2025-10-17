import 'dart:math';
import 'package:nutri/constants/export.dart';

class NutriLoader extends StatefulWidget {
  static const int dotCount = 6;
  static const double size = 36;
  static const double dotSize = 8;

  final Color? color;

  const NutriLoader({super.key, this.color});

  @override
  State<NutriLoader> createState() => _NutriLoaderState();
}

class _NutriLoaderState extends State<NutriLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        final bool isDarkMode = themeController.isDarkMode;

        // 🌿 Health-friendly color (lime green)
        final Color loaderColor =
            widget.color ?? (isDarkMode ? kPrimaryColor : kPrimaryDark);

        return SizedBox(
          width: NutriLoader.size,
          height: NutriLoader.size,
          child: AnimatedBuilder(
            animation: CurvedAnimation(
              parent: _controller,
              curve: Curves.easeInOutSine,
            ),
            builder: (_, __) => CustomPaint(
              painter: _DotsPainter(
                progress: _controller.value,
                color: loaderColor,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _DotsPainter extends CustomPainter {
  final double progress;
  final Color color;

  _DotsPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2.4;

    for (int i = 0; i < NutriLoader.dotCount; i++) {
      final double angleStep = 2 * pi / NutriLoader.dotCount;
      final double angle = (progress * 2 * pi) + (i * angleStep);

      // Make pulse-like opacity transition
      final double fade = 0.5 + 0.5 * sin(progress * 2 * pi + i * 0.8);
      final Paint dotPaint = Paint()
        ..color = color.withOpacity(fade.clamp(0.3, 1.0));

      final Offset offset = Offset(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
      canvas.drawCircle(offset, NutriLoader.dotSize / 2, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _DotsPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}
