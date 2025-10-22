import 'dart:math';
import 'package:nutri/constants/export.dart';

class NutriLoader extends StatefulWidget {
  static const int dotCount = 6;
  static const double defaultSize = 36;
  static const double defaultDotSize = 8;

  final Color? color;
  final double? size;
  final double? dotSize;
  final bool useContainer;
  final Color? containerColor;
  final double containerPadding;

  const NutriLoader({
    super.key, 
    this.color,
    this.size,
    this.dotSize,
    this.useContainer = false,
    this.containerColor,
    this.containerPadding = 8,
  });

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

        final double size = widget.size ?? NutriLoader.defaultSize;
        final double dotSize = widget.dotSize ?? NutriLoader.defaultDotSize;

        final loaderWidget = SizedBox(
          width: size,
          height: size,
          child: AnimatedBuilder(
            animation: CurvedAnimation(
              parent: _controller,
              curve: Curves.easeInOutSine,
            ),
            builder: (_, __) => CustomPaint(
              painter: _DotsPainter(
                progress: _controller.value,
                color: loaderColor,
                dotSize: dotSize,
                size: size,
              ),
            ),
          ),
        );

        // Return with container if requested
        if (widget.useContainer) {
          return Container(
            padding: EdgeInsets.all(widget.containerPadding),
            decoration: BoxDecoration(
             color: widget.containerColor ?? Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: loaderWidget,
          );
        }

        return loaderWidget;
      },
    );
  }
}

class _DotsPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double dotSize;
  final double size;

  _DotsPainter({
    required this.progress,
    required this.color,
    required this.dotSize,
    required this.size,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = this.size / 2.4;

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
      canvas.drawCircle(offset, dotSize / 2, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _DotsPainter oldDelegate) =>
      oldDelegate.progress != progress || 
      oldDelegate.color != color ||
      oldDelegate.dotSize != dotSize ||
      oldDelegate.size != size;
}