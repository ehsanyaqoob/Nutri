import 'package:nutri/constants/export.dart';
import 'package:nutri/widget/toasts.dart';


class FunicaNavBar extends StatefulWidget {
  const FunicaNavBar({super.key});

  @override
  State<FunicaNavBar> createState() => _FunicaNavBarState();
}

class _FunicaNavBarState extends State<FunicaNavBar> {
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

              // --- Main content ---
              body: Obx(() {
                final navController = Get.find<NavController>();
                return IndexedStack(
                  index: navController.currentIndex.value,
                  children: const [
                    // HomeScreen(),
                    // CartScreen(),
                    // OrderScreen(),
                    // WalletScreen(),
                    // ProfileScreen(),
                  ],
                );
              }),

              // --- Responsive Bottom Nav ---
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
    final double iconSize = isSmallPhone ? 22.0 : (isTablet ? 28.0 : 24.0);
    final double fontSize = isSmallPhone ? 10.0 : (isTablet ? 14.0 : 12.0);
    final double navBarHeight = isSmallPhone ? 60.0 : (isTablet ? 80.0 : 70.0);
    final double iconPadding = isSmallPhone ? 6.0 : (isTablet ? 12.0 : 8.0);
    
    return SafeArea(
      top: false,
      bottom: true,
      child: Container(
        height: navBarHeight,
        decoration: BoxDecoration(
          color: kDynamicNavigationBarBackground(context),
          border: Border(
            top: BorderSide(
              color: kDynamicBorder(context) ?? Colors.transparent,
              width: 0.5,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
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
              activeIcon: Assets.cartfilled,
              inactiveIcon: Assets.cartunfilled,
              label: "Cart",
              iconSize: iconSize,
              fontSize: fontSize,
              padding: iconPadding,
              context: context,
            ),
            _buildNavItem(
              index: 2,
              navController: navController,
              activeIcon: Assets.orderfilled,
              inactiveIcon: Assets.orderunfilled,
              label: "Orders",
              iconSize: iconSize,
              fontSize: fontSize,
              padding: iconPadding,
              context: context,
            ),
            _buildNavItem(
              index: 3,
              navController: navController,
              activeIcon: Assets.walletfilled,
              inactiveIcon: Assets.walletunfilled,
              label: "Wallet",
              iconSize: iconSize,
              fontSize: fontSize,
              padding: iconPadding,
              context: context,
            ),
            _buildNavItem(
              index: 4,
              navController: navController,
              activeIcon: Assets.profilefilled,
              inactiveIcon: Assets.profileunfilled,
              label: "Profile",
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
              if (iconPath.endsWith('.svg'))
                SvgPicture.asset(
                  iconPath,
                  height: iconSize,
                  width: iconSize,
                  colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                )
              else
                Image.asset(
                  iconPath,
                  height: iconSize,
                  width: iconSize,
                  color: iconColor,
                ),
              
              // Label
              const Gap(4),
              Flexible(
                child: MyText(
                  text: label,
                  size: fontSize,
                  weight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: textColor,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavController extends GetxController {
  var currentIndex = 0.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}