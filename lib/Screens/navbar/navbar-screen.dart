import 'package:nutri/Screens/navbar/home/home-screen.dart';
import 'package:nutri/Screens/navbar/menu/menu-screen.dart';
import 'package:nutri/Screens/navbar/progress/progress-screen.dart';
import 'package:nutri/Screens/navbar/rewards/rewards-screen.dart';
import 'package:nutri/Screens/navbar/scan/scan-screen.dart';
import 'package:nutri/constants/export.dart';
import 'package:nutri/widget/toasts.dart';

class NutriNavBar extends StatefulWidget {
  const NutriNavBar({super.key});

  @override
  State<NutriNavBar> createState() => _NutriNavBarState();
}

class _NutriNavBarState extends State<NutriNavBar> {
  DateTime? _lastPressed;

  Future<bool> _onWillPop() async {
    DateTime now = DateTime.now();
    if (_lastPressed == null || now.difference(_lastPressed!) > const Duration(seconds: 2)) {
      _lastPressed = now;
      AppToast.info("Press back again to exit");
      return false; 
    }
    SystemNavigator.pop(); 
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        final bool isDarkMode = themeController.isDarkMode;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
            systemNavigationBarColor: kDynamicNavigationBarBackground(context),
            systemNavigationBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
          ),
          child: WillPopScope(
            onWillPop: _onWillPop,
            child: Scaffold(
              backgroundColor: kDynamicScaffoldBackground(context),

              // Main Content
              body: Obx(() {
                final navController = Get.find<NavController>();
                return IndexedStack(
                  index: navController.currentIndex.value,
                  children: const [
                    HomeScreen(),
                    ProgressScreen(),
                    ScanScreen(),
                    RewardsScreen(),
                    MenuScreen(),
                  ],
                );
              }),

              // Responsive Bottom Navigation
              bottomNavigationBar: Obx(() {
                final navController = Get.find<NavController>();
                return _buildResponsiveBottomNav(navController, context);
              }),
            ),
          ),
        );
      },
    );
  }

  Widget _buildResponsiveBottomNav(NavController navController, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    // Device type detection
    final bool isSmallPhone = screenWidth < 360;
    final bool isTablet = screenWidth >= 600;
    final bool isLargeTablet = screenWidth >= 900;
    
    // Responsive sizing
    final double iconSize = isSmallPhone ? 22.0 : (isTablet ? 26.0 : 24.0);
    final double fontSize = isSmallPhone ? 10.0 : (isTablet ? 12.0 : 11.0);
    final double navBarHeight = isSmallPhone ? 60.0 : (isTablet ? 75.0 : 65.0);
    final double iconPadding = isSmallPhone ? 4.0 : (isTablet ? 8.0 : 6.0);
    
    return SafeArea(
      top: false,
      bottom: true,
      child: Container(
        height: navBarHeight,
        decoration: BoxDecoration(
          color: kDynamicNavigationBarBackground(context),
          border: Border(
            top: BorderSide(
              color: kDynamicBorder(context),
              width: 0.5,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: kDynamicShadow(context),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            _buildNavItem(
              index: 0,
              navController: navController,
              activeIcon: Assets.homefilled,
              inactiveIcon: Assets.homeunfilled,
              label: "Home",
              iconSize: iconSize,
              fontSize: fontSize,
              padding: iconPadding,
              context: context,
            ),
            _buildNavItem(
              index: 1,
              navController: navController,
              activeIcon: Assets.progressfilled,
              inactiveIcon: Assets.progressunfilled,
              label: "Progress",
              iconSize: iconSize,
              fontSize: fontSize,
              padding: iconPadding,
              context: context,
            ),
            _buildNavItem(
              index: 2,
              navController: navController,
              activeIcon: Assets.scanfilled,
              inactiveIcon: Assets.scanunfilled,
              label: "Scan",
              iconSize: iconSize,
              fontSize: fontSize,
              padding: iconPadding,
              context: context,
            ),
            _buildNavItem(
              index: 3,
              navController: navController,
              activeIcon: Assets.rewardsfilled,
              inactiveIcon: Assets.rewardsunfilled,
              label: "Rewards",
              iconSize: iconSize,
              fontSize: fontSize,
              padding: iconPadding,
              context: context,
            ),
            _buildNavItem(
              index: 4,
              navController: navController,
              activeIcon: Assets.menufilled,
              inactiveIcon: Assets.menuunfilled,
              label: "Menu",
              iconSize: iconSize,
              fontSize: fontSize,
              padding: iconPadding,
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required NavController navController,
    required String activeIcon,
    required String inactiveIcon,
    required String label,
    required double iconSize,
    required double fontSize,
    required double padding,
    required BuildContext context,
  }) {
    final bool isSelected = navController.currentIndex.value == index;
    final String iconPath = isSelected ? activeIcon : inactiveIcon;
    final Color iconColor = isSelected
        ? kDynamicNavigationBarSelectedItem(context)
        : kDynamicNavigationBarItem(context);
    final Color textColor = isSelected
        ? kDynamicNavigationBarSelectedItem(context)
        : kDynamicNavigationBarItem(context);

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => navController.changeIndex(index),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon
              SvgPicture.asset(
                iconPath,
                height: iconSize,
                width: iconSize,
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              ),
              
              // Label
              const SizedBox(height: 2),
              MyText(
                text: label,
                size: fontSize,
                weight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: textColor,
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavController extends GetxController {
  final RxInt currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}