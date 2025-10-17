import 'package:animate_do/animate_do.dart';
import 'package:nutri/Screens/navbar/homebarscreens/home-screen.dart';
import 'package:nutri/constants/export.dart';
import 'package:nutri/extensions/media-query-extension.dart';
import 'package:nutri/widget/floating-icons.dart';
import 'package:nutri/widget/toasts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  DateTime? _lastPressed;

  final List<Map<String, dynamic>> _onboardingData = [
    {
      'title': 'AI Nutrition Tracking',
      'lines': [
        'Track your calories using AI',
        'Snap a quick meal photo',
        'Get instant nutrition details',
        'No need for manual logging',
        'Receive personalized health insights',
        'Achieve your fitness goals easily',
      ],
    },
    {
      'title': 'Smart Food Recognition',
      'lines': [
        'Detect food items automatically',
        'Estimate portions with precision',
        'Access thousands of food items',
        'Understand your eating habits better',
        'Count calories the smart way',
        'AI improves with every scan',
      ],
    },
    {
      'title': 'Health & Wellness',
      'lines': [
        'Monitor your daily nutrition intake',
        'Set and reach personal targets',
        'Track progress every single day',
        'Get custom health recommendations',
        'Join a supportive health community',
        'Transform your lifestyle for good',
      ],
    },
    {
      'title': 'Get Started Today',
      'lines': [
        'Enjoy a simple setup process',
        'Use a clean friendly interface',
        'Keep your data fully secure',
        'Get help anytime you need',
        'Receive updates on new features',
        'Start your healthy journey today',
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateSystemUi());
  }

  void _updateSystemUi() {
    final brightness = WidgetsBinding.instance.window.platformBrightness;
    final isDark = brightness == Brightness.dark;
    final bgColor = isDark ? kDarkBackground : kLightBackground;

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

  void _navigateToNext() {
    if (_currentPage < _onboardingData.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    } else {
      Get.to(
        HomeScreen(),
        transition: Transition.circularReveal,
        duration: Duration(milliseconds: 500),
      );
      print('Navigate to main app');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: GetBuilder<ThemeController>(
        builder: (themeController) {
          final isDark = themeController.isDarkMode;

          return Scaffold(
            backgroundColor: kDynamicScaffoldBackground(context),
            extendBodyBehindAppBar: true,
            body: Stack(
              children: [
                /// Floating background icons - covering entire scaffold
                Positioned.fill(
                  child: Stack(
                    children: [
                      FloatingIcon(
                        asset: Assets.apple,
                        size: 45,
                        duration: const Duration(seconds: 12),
                      ),
                      FloatingIcon(
                        asset: Assets.salad,
                        size: 38,
                        duration: const Duration(seconds: 15),
                      ),
                      FloatingIcon(
                        asset: Assets.bread,
                        size: 35,
                        duration: const Duration(seconds: 18),
                      ),
                      FloatingIcon(
                        asset: Assets.egg,
                        size: 32,
                        duration: const Duration(seconds: 14),
                      ),
                      FloatingIcon(
                        asset: Assets.pizza,
                        size: 40,
                        duration: const Duration(seconds: 16),
                      ),
                      FloatingIcon(
                        asset: Assets.coffee,
                        size: 30,
                        duration: const Duration(seconds: 13),
                      ),
                      // Add more icons for better coverage
                      FloatingIcon(
                        asset: Assets.fire, // or any other food icon
                        size: 28,
                        duration: const Duration(seconds: 17),
                      ),
                      FloatingIcon(
                        asset: Assets.apple, // duplicate some for variety
                        size: 33,
                        duration: const Duration(seconds: 11),
                      ),
                    ],
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 800),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        kDynamicPrimary(
                          context,
                        ).withOpacity(0.1 + (_currentPage * 0.03)),
                        kDynamicScaffoldBackground(context),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                PageView.builder(
                  controller: _controller,
                  physics: const BouncingScrollPhysics(),
                  itemCount: _onboardingData.length,
                  onPageChanged: (i) => setState(() => _currentPage = i),
                  itemBuilder: (context, index) {
                    final data = _onboardingData[index];
                    final lines = List<String>.from(data['lines']);

                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 600),
                      transitionBuilder: (child, animation) => FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.1, 0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      ),
                      child: SingleChildScrollView(
                        key: ValueKey<int>(_currentPage),
                        padding: EdgeInsets.only(
                          top: context.height * 0.15,
                          bottom: context.height * 0.25,
                          left: 24,
                          right: 24,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElasticInDown(
                              delay: const Duration(milliseconds: 100),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 44,
                                    width: 44,
                                    decoration: BoxDecoration(
                                      color: kDynamicPrimary(
                                        context,
                                      ).withOpacity(0.15),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        Assets.fire,
                                        height: 30,
                                        color: kDynamicPrimary(context),
                                      ),
                                    ),
                                  ),
                                  12.width,
                                  MyText(
                                    text: data['title'],
                                    color: kDynamicText(context),
                                    size: 22.0,
                                    weight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ),
                            24.height,
                            Column(
                              children: List.generate(lines.length, (i) {
                                final text = lines[i];
                                final isLeftAligned = i.isEven;

                                return FadeInUp(
                                  delay: Duration(milliseconds: 200 + i * 100),
                                  duration: const Duration(milliseconds: 600),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 6.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: isLeftAligned
                                          ? MainAxisAlignment.start
                                          : MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          constraints: BoxConstraints(
                                            maxWidth: context.width * 0.75,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 18,
                                            vertical: 12,
                                          ),
                                          decoration: BoxDecoration(
                                            color: kDynamicPrimary(
                                              context,
                                            ).withOpacity(0.08),
                                            borderRadius: BorderRadius.circular(
                                              30.0,
                                            ),
                                            border: Border.all(
                                              color: kDynamicPrimary(
                                                context,
                                              ).withOpacity(0.2),
                                            ),
                                          ),
                                          child: MyText(
                                            text: text,
                                            color: kDynamicText(context),
                                            size: 15,
                                            weight: FontWeight.w500,
                                            textAlign: isLeftAligned
                                                ? TextAlign.left
                                                : TextAlign.right,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 800),
                    padding: EdgeInsets.only(
                      left: 30,
                      right: 30,
                      top: 16,
                      bottom: 36 + MediaQuery.of(context).padding.bottom,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          kDynamicPrimary(
                            context,
                          ).withOpacity(0.1 + (_currentPage * 0.03)),
                          kDynamicScaffoldBackground(context),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(60.0),
                        topRight: Radius.circular(60.0),
                      ),
                    ),
                    child: Column(
                      children: [
                        SmoothPageIndicator(
                          controller: _controller,
                          count: _onboardingData.length,
                          effect: ExpandingDotsEffect(
                            activeDotColor: kDynamicPrimary(context),
                            dotColor: kDynamicIcon(context).withOpacity(0.3),
                            dotHeight: 5.0,
                            dotWidth: 16.0,
                            spacing: 6.0,
                            expansionFactor: 3,
                          ),
                        ),
                        24.height,
                        MyButtonWithIcon(
                          text: _currentPage == _onboardingData.length - 1
                              ? 'Get Started'
                              : 'Continue',
                          iconPath: Assets.fire,
                          onTap: _navigateToNext,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
