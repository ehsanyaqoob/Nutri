import 'package:nutri/constants/export.dart';
import 'package:nutri/extensions/media-query-extension.dart';
import 'package:nutri/services/on-boarding-mg.dart';
import 'package:nutri/widget/toasts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class GenericOnBoardingView extends StatefulWidget {
  final List<OnBoardingModel> pages;
  final VoidCallback? onGetStarted;

  const GenericOnBoardingView({
    super.key,
    required this.pages,
    this.onGetStarted,
  });

  @override
  State<GenericOnBoardingView> createState() => _GenericOnBoardingViewState();
}

class _GenericOnBoardingViewState extends State<GenericOnBoardingView> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  DateTime? _lastPressed;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateSystemUi());
  }

  void _updateSystemUi() {
    final Brightness platformBrightness =
        WidgetsBinding.instance.window.platformBrightness;
    final bool isDark = platformBrightness == Brightness.dark;
    final Color bgColor = isDark ? kDarkBackground : kLightBackground;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: bgColor,
        systemNavigationBarIconBrightness: isDark
            ? Brightness.light
            : Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  Future<bool> _onWillPop() async {
    if (_currentPage > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      return false;
    }
    final now = DateTime.now();
    if (_lastPressed == null ||
        now.difference(_lastPressed!) > const Duration(seconds: 2)) {
      _lastPressed = now;
      AppToast.info("Press back again to exit");
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: GetBuilder<ThemeController>(
        builder: (themeController) {
          final isDark = themeController.isDarkMode;

          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: isDark
                  ? Brightness.light
                  : Brightness.dark,
              systemNavigationBarColor: kDynamicScaffoldBackground(context),
              systemNavigationBarIconBrightness: isDark
                  ? Brightness.light
                  : Brightness.dark,
            ),
            child: Scaffold(
              backgroundColor: kDynamicScaffoldBackground(context),
              body: Stack(
                alignment: Alignment.center,
                children: [
                  PageView.builder(
                    controller: _controller,
                    itemCount: widget.pages.length,
                    onPageChanged: (i) => setState(() => _currentPage = i),
                    itemBuilder: (context, index) {
                      final page = widget.pages[index];
                      return Padding(
                        padding: AppSizes.DEFAULT,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            60.height,
                            MyText(
                              text: page.title,
                              color: kDynamicText(context),
                              size: 40,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 500,
                    right: -20,
                    child: Row(
                      children: [Image.asset(Assets.spinachsingle, height: 100.0)],
                    ),
                  ),Positioned(
                    top: 270,
                    right: 50,
                    child: Row(
                      children: [Image.asset(Assets.spinach, height: 100.0)],
                    ),
                  ),
                  Positioned(
                    bottom: -90,
                    left: -100,
                    child: Image.asset(Assets.veges, height: 450,),
                  ),
                  // --- BUBBLES POINTING TO VEGES IMAGE ---
Positioned(
  bottom: 280,
  left: 80,
  child: _calorieBubble(context, "150 cal"),
),
Positioned(
  bottom: 200,
  left: 160,
  child: _calorieBubble(context, "120 cal"),
),
Positioned(
  bottom: 120,
  left: 230,
  child: _calorieBubble(context, "100 cal"),
),

                  Positioned(
                    top: 40,
                    left: 20,
                    right: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: kDynamicPrimary(
                                  context,
                                ).withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  Assets.fire,
                                  height: 22.0,
                                  color: kDynamicPrimary(context),
                                ),
                              ),
                            ),
                            10.0.width,
                            MyText(
                              text: 'Nutri',
                              color: kDynamicText(context),
                              size: 26.0,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                        SmoothPageIndicator(
                          controller: _controller,
                          count: widget.pages.length,
                          effect: ExpandingDotsEffect(
                            activeDotColor: kDynamicIcon(context),
                            dotColor: kDynamicIcon(context).withOpacity(0.3),
                            dotHeight: 6,
                            dotWidth: 18,
                            spacing: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (_currentPage == widget.pages.length - 1)
                    Positioned(
                      bottom: 60,
                      left: 40,
                      right: 40,
                      child: MyButtonWithIcon(
                        text: 'Get Started',
                        iconPath: Assets.up,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget _calorieBubble(BuildContext context, String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
    decoration: BoxDecoration(
      color: kDynamicPrimary(context).withOpacity(0.1),
      borderRadius: BorderRadius.circular(50),
      border: Border.all(
        color: kDynamicPrimary(context).withOpacity(0.3),
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: kDynamicPrimary(context).withOpacity(0.15),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.local_fire_department, size: 18, color: Colors.orange),
        const SizedBox(width: 6),
        MyText(
          text: text,
          color: kDynamicText(context),
          size: 14,
          weight: FontWeight.w600,
        ),
      ],
    ),
  );
}
