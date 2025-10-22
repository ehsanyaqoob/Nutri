import 'package:nutri/constants/back-stack.dart';
import 'package:nutri/constants/export.dart';

class NutriNavBar extends StatefulWidget {
  const NutriNavBar({super.key});

  @override
  State<NutriNavBar> createState() => _NutriNavBarState();
}

class _NutriNavBarState extends State<NutriNavBar> {
  @override
  void initState() {
    super.initState();
    Get.put(NavController(), permanent: true);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        final isDarkMode = themeController.isDarkMode;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
            systemNavigationBarColor: kDynamicScaffoldBackground(context),
            systemNavigationBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
          ),
          child: WillPopScope(
            onWillPop: BackPressHandler.handleBackPress,
            child: Scaffold(
    // // Remove scaffold background to make content truly float
    //           backgroundColor: Colors.transparent,              
              body: Obx(() {
                final navController = Get.find<NavController>();
                return IndexedStack(
                  index: navController.currentIndex.value,
                  children: const [
                    HomeScreen(),
                    ProgressScreen(),
                    MealScreen(),
                    MenuScreen(),
                    ScanScreen(),
                  ],
                );
              }),
              bottomNavigationBar: Obx(() {
                final navController = Get.find<NavController>();
                return _buildModernBottomNav(navController, context);
              }),
            ),
          ),
        );
      },
    );
  }

  Widget _buildModernBottomNav(NavController navController, BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isTablet = width >= 600;

    final navHeight = isTablet ? 90.0 : 80.0;
    final iconSize = isTablet ? 26.0 : 24.0;
    final fabSize = isTablet ? 68.0 : 62.0;
    final horizontalPadding = isTablet ? 30.0 : 16.0;

    return Container(

      height: navHeight,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: kDynamicNavigationBarBackground(context),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: kDynamicBorder(context),
                  width: 2.8,
                ),
                boxShadow: [
                  BoxShadow(
                    color: kDynamicShadow(context).withOpacity(0.1), 
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Home
                  _navItem(
                    0,
                    navController,
                    Assets.homefilled,
                    Assets.homeunfilled,
                    iconSize,
                    context,
                  ),
                  // Progress
                  _navItem(
                    1,
                    navController,
                    Assets.firefilled,
                    Assets.fireunfilled,
                    iconSize,
                    context,
                  ),
                  // Meal
                  _navItem(
                    2,
                    navController,
                    Assets.mealfilled,
                    Assets.mealunfilled,
                    iconSize,
                    context,
                  ),
                  // Menu
                  _navItem(
                    3,
                    navController,
                    Assets.menufilled,
                    Assets.menuunfilled,
                    iconSize,
                    context,
                  ),
                ],
              ),
            ),
          ),
    
    Gap(12),
          // Floating Action Button (Scan) - Separate on right
          GestureDetector(
            onTap: () {
              HapticFeedback.lightImpact();
              navController.changeIndex(4);
            },
            child: Container(
              width: fabSize,
              height: fabSize,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF9F4D), Color(0xFFFF8C1A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
               
              ),
              child: Center(
                child: SvgPicture.asset(
                  Assets.addfilled,
                  height: iconSize + 6,
                  width: iconSize + 6,
                  color: kDynamicIcon(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }




  Widget _navItem(
    int index,
    NavController navController,
    String activeIcon,
    String inactiveIcon,
    double iconSize,
    BuildContext context,
  ) {
    final isSelected = navController.currentIndex.value == index;
    final iconPath = isSelected ? activeIcon : inactiveIcon;
    final color = isSelected
        ? kDynamicNavigationBarSelectedItem(context)
        : kDynamicNavigationBarItem(context);

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          HapticFeedback.lightImpact();
          navController.changeIndex(index);
        },
        child: Container(
          // Make container background transparent
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Center(
            child: SvgPicture.asset(
              iconPath,
              height: iconSize,
              width: iconSize,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
          ),
        ),
      ),
    );
  }
}

class NavController extends GetxController {
  final RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    currentIndex.value = 0;
  }

  void changeIndex(int index) {
    if (currentIndex.value != index) {
      currentIndex.value = index;
    }
  }

  void resetToHome() {
    currentIndex.value = 0;
  }
}