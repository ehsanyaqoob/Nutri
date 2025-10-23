import 'package:nutri/constants/export.dart';
import 'package:nutri/widget/common/scan/scan_bottom_sheet.dart';

class ScanFabWidget extends StatefulWidget {
  final NavController navController;
  const ScanFabWidget({super.key, required this.navController});

  @override
  State<ScanFabWidget> createState() => _ScanFabWidgetState();
}

class _ScanFabWidgetState extends State<ScanFabWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTap() {
    HapticFeedback.lightImpact();
    _animationController.forward();
    _showScanSheet();
  }

  void _showScanSheet() {
    widget.navController.setPreviousIndex();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: kDynamicOverlay(context).withOpacity(0.6),
      isDismissible: true,
      enableDrag: true,
      builder: (context) => const ScanBottomSheet(),
    ).then((_) {
      widget.navController.changeIndex(widget.navController.previousIndex.value);
      _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;
    final fabSize = isTablet ? 68.0 : 62.0;
    final iconSize = isTablet ? 26.0 : 24.0;
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: fabSize,
        height: fabSize,
        decoration: BoxDecoration(
          color: kDynamicPrimary(context),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: kDynamicShadow(context).withOpacity(0.3),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: RotationTransition(
          turns: Tween<double>(begin: 0, end: 0.125).animate(_animationController),
          child: SvgPicture.asset(
            Assets.addfilled,
            height: iconSize + 3,
            width: iconSize + 3,
            color: kWhite,
          ),
        ),
      ),
    );
  }
}
