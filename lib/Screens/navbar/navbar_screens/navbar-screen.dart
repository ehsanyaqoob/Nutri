import 'package:nutri/constants/back-stack.dart';
import 'package:nutri/constants/export.dart';
import 'package:nutri/widget/common/scan/scan_fab_widget.dart';
import 'package:nutri/widget/common/scan/scan_screen/scan_screen.dart';

class NutriNavBar extends StatefulWidget {
  const NutriNavBar({super.key});

  @override
  State<NutriNavBar> createState() => _NutriNavBarState();
}

class _NutriNavBarState extends State<NutriNavBar> {
  late final NavController navController;

  final _navItems = const [
    NavItem(0, Assets.homefilled, Assets.homeunfilled),
    NavItem(1, Assets.firefilled, Assets.fireunfilled),
    NavItem(2, Assets.mealfilled, Assets.mealunfilled),
    NavItem(3, Assets.menufilled, Assets.menuunfilled),
  ];

  @override
  void initState() {
    super.initState();
    navController = Get.put(NavController(), permanent: true);
  }

  void _onNavItemTap(int index) {
    HapticFeedback.lightImpact();
    navController.changeIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: themeController.isDarkMode
                ? Brightness.light
                : Brightness.dark,
            systemNavigationBarColor: kDynamicScaffoldBackground(context),
            systemNavigationBarIconBrightness: themeController.isDarkMode
                ? Brightness.light
                : Brightness.dark,
          ),
          child: WillPopScope(
    onWillPop: BackPressHandler.handleBackPress,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  _buildContent(),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: _buildBottomNav(context),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent() {
    return Obx(() {
      return IndexedStack(
        index: navController.currentIndex.value.clamp(0, 4),
        children: const [
          HomeScreen(),
          ProgressScreen(),
          MealScreen(),
          MenuScreen(),
         // ScanScreen(),
        ],
      );
    });
  }

  Widget _buildBottomNav(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width >= 600;
    final hasNotch = MediaQuery.of(context).viewPadding.bottom > 0;
    return SafeArea(
      top: false,
      minimum: EdgeInsets.only(bottom: hasNotch ? 0 : 8),
      child: Container(
        height: isTablet ? 90 : 80,
        margin: const EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 30 : 16,
          vertical: 12,
        ),
        child: Row(
          children: [
            _buildNavContainer(context, isTablet),
            SizedBox(width: isTablet ? 16 : 12),
            ScanFabWidget(navController: navController),
          ],
        ),
      ),
    );
  }

  Widget _buildNavContainer(BuildContext context, bool isTablet) {
    return Expanded(
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: kDynamicNavigationBarBackground(context).withOpacity(0.95),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: kDynamicBorder(context).withOpacity(0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: kDynamicShadow(context).withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            _buildSliderIndicator(context, isTablet),
            Row(
              children: _navItems
                  .map((item) => _buildNavItem(item, isTablet ? 26 : 24))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliderIndicator(BuildContext context, bool isTablet) {
    return Obx(() {
      final currentIndex = navController.currentIndex.value;
      if (currentIndex >= 4) return const SizedBox.shrink();
      final containerWidth =
          MediaQuery.of(context).size.width -
          ((isTablet ? 30 : 16) * 2) -
          (isTablet ? 68 : 62) -
          (isTablet ? 16 : 12);
      final itemWidth = containerWidth / _navItems.length;
      final sliderWidth = itemWidth - 16;
      final sliderPosition =
          (currentIndex * itemWidth) + ((itemWidth - sliderWidth) / 2);
      return AnimatedPositioned(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        left: sliderPosition,
        top: 8,
        child: Container(
          width: sliderWidth,
          height: 40,
          decoration: BoxDecoration(
            color: kDynamicPrimary(context),
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      );
    });
  }

  Widget _buildNavItem(NavItem item, double iconSize) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _onNavItemTap(item.index),
        child: Obx(() {
          final isSelected = navController.currentIndex.value == item.index;
          return Container(
            height: 60,
            child: Center(
              child: AnimatedScale(
                duration: const Duration(milliseconds: 300),
                scale: isSelected ? 1.15 : 1.0,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: isSelected ? 0.0 : 1.0,
                      child: SvgPicture.asset(
                        item.inactiveIcon,
                        height: iconSize,
                        width: iconSize,
                        color: _getInactiveIconColor(item.index),
                      ),
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: isSelected ? 1.0 : 0.0,
                      child: SvgPicture.asset(
                        item.activeIcon,
                        height: iconSize,
                        width: iconSize,
                        color: _getActiveIconColor(item.index),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Color _getActiveIconColor(int index) {
    return kDynamicIconOnPrimary(context);
  }

  Color _getInactiveIconColor(int index) {
    return kDynamicNavigationBarItem(context);
  }
}

class NavItem {
  final int index;
  final String activeIcon;
  final String inactiveIcon;
  const NavItem(this.index, this.activeIcon, this.inactiveIcon);
}

class NavController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final RxInt previousIndex = 0.obs;
  final RxList<int> navigationHistory = <int>[0].obs; // Track navigation history

  @override
  void onInit() {
    super.onInit();
    _resetToHome();
  }

  void changeIndex(int index) {
    if (index >= 0 && index <= 4 && currentIndex.value != index) {
      previousIndex.value = currentIndex.value;
      currentIndex.value = index;
      
      // Add to navigation history (avoid duplicates in sequence)
      if (navigationHistory.isEmpty || navigationHistory.last != index) {
        navigationHistory.add(index);
        
        // Keep only last 10 items to prevent memory issues
        if (navigationHistory.length > 10) {
          navigationHistory.removeAt(0);
        }
      }
      update();
    }
  }

  void setPreviousIndex() {
    previousIndex.value = currentIndex.value;
  }

 void resetToHome() {
  changeIndex(0);
}


  void _resetToHome() {
    currentIndex.value = 0;
    previousIndex.value = 0;
    navigationHistory.clear();
    navigationHistory.add(0); // Start with home
    update();
  }

  // New method: Go back to previous tab in history
  bool goBack() {
    if (navigationHistory.length > 1) {
      // Remove current index
      navigationHistory.removeLast();
      
      // Get previous index
      final previousIndex = navigationHistory.last;
      currentIndex.value = previousIndex;
      update();
      
      return true; // Back navigation handled
    }
    return false; // No history, should close app
  }

  // Get navigation trail for debugging
  List<int> get navigationTrail => List.from(navigationHistory);
}
