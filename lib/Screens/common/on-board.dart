import 'package:animate_do/animate_do.dart';
import 'package:nutri/constants/back-stack.dart';
import 'package:nutri/constants/export.dart';
import 'package:nutri/controller/on-boarding-cont.dart';
import 'package:nutri/widget/bottomsheets/helper-sheets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _controller = PageController();
  final OnboardingController _onboardingController = Get.put(
    OnboardingController(),
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateSystemUi());

    // Listen to page changes
    _controller.addListener(_onPageChanged);
  }

  void _onPageChanged() {
    final page = _controller.page?.round() ?? 0;
    _onboardingController.updatePage(page);
  }

  void _updateSystemUi() {
    final brightness = WidgetsBinding.instance.window.platformBrightness;
    final isDark = brightness == Brightness.dark;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: kDynamicScaffoldBackground(
          navigator!.context,
        ),
        systemNavigationBarIconBrightness: isDark
            ? Brightness.light
            : Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  // Add these methods to your onboarding_view.dart
  void _navigateToNext() {
    if (!_onboardingController.isLastPage) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _showPrivacySheet();
    }
  }

  void _showPrivacySheet() {
    BottomSheetHelper.showPrivacySheet(
      onAccept: () {
        // User accepted terms and permissions - complete onboarding
        _onboardingController.completeOnboarding();
      },
      onLearnMore: () {
        // Navigate to detailed privacy policy
        // Get.to(() => PrivacyPolicyScreen());
        // For now, just show a toast
        AppToast.info('Privacy policy screen coming soon!');
      },
    );
  }

  void _skipOnboarding() {
    // When user skips, show privacy sheet immediately
    _showPrivacySheet();
  }

  @override
  void dispose() {
    _controller.removeListener(_onPageChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: BackPressHandler.handleBackPress,
      child: GetBuilder<ThemeController>(
        builder: (themeController) {
          return Scaffold(
            backgroundColor: kDynamicScaffoldBackground(context),
            extendBodyBehindAppBar: true,
            body: Stack(
              children: [
                // Floating Icons Background
                Positioned.fill(
                  child: Stack(
                    children: [
                      FloatingIcon(
                        asset: Assets.fruits,
                        size: 60,
                        duration: const Duration(seconds: 12),
                      ),
                      FloatingIcon(
                        asset: Assets.salad,
                        size: 60,
                        duration: const Duration(seconds: 15),
                      ),
                      FloatingIcon(
                        asset: Assets.bread,
                        size: 60,
                        duration: const Duration(seconds: 18),
                      ),
                      FloatingIcon(
                        asset: Assets.egg,
                        size: 60,
                        duration: const Duration(seconds: 14),
                      ),
                      FloatingIcon(
                        asset: Assets.pizza,
                        size: 60,
                        duration: const Duration(seconds: 16),
                      ),
                      FloatingIcon(
                        asset: Assets.coffee,
                        size: 60,
                        duration: const Duration(seconds: 13),
                      ),
                      FloatingIcon(
                        asset: Assets.grapes,
                        size: 60,
                        duration: const Duration(seconds: 17),
                      ),
                      FloatingIcon(
                        asset: Assets.rice,
                        size: 60,
                        duration: const Duration(seconds: 11),
                      ),
                      FloatingIcon(
                        asset: Assets.honey,
                        size: 60,
                        duration: const Duration(seconds: 11),
                      ),
                    ],
                  ),
                ),

                // Animated Gradient Background
                Obx(
                  () => AnimatedContainer(
                    duration: const Duration(milliseconds: 800),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          kDynamicPrimary(context).withOpacity(
                            0.1 +
                                (_onboardingController.currentPage.value *
                                    0.03),
                          ),
                          kDynamicScaffoldBackground(context),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),

                // Page View Content
                PageView.builder(
                  controller: _controller,
                  physics: const BouncingScrollPhysics(),
                  itemCount: _onboardingController.onboardingData.length,
                  itemBuilder: (context, index) {
                    final data = _onboardingController.onboardingData[index];
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
                        key: ValueKey<int>(index),
                        padding: EdgeInsets.only(
                          top: context.height * 0.15,
                          bottom: context.height * 0.25,
                          left: 24,
                          right: 24,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Title with Icon
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
                                    size: 14.0,
                                    weight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ),
                            24.height,

                            // Feature Lines
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

                // Skip Button (Top Right)
                Positioned(
                  top: MediaQuery.of(context).padding.top + 16,
                  right: 16,
                  child: Obx(
                    () => AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity:
                          _onboardingController.currentPage.value <
                              _onboardingController.onboardingData.length - 1
                          ? 1.0
                          : 0.0,
                      child: TextButton(
                        onPressed: _skipOnboarding,
                        child: MyText(
                          text: 'Skip',
                          size: 20.0,
                          color: kDynamicPrimary(context),
                          weight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                // Bottom Controls
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Obx(
                    () => AnimatedContainer(
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
                            kDynamicPrimary(context).withOpacity(
                              0.1 +
                                  (_onboardingController.currentPage.value *
                                      0.03),
                            ),
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
                          // Page Indicator
                          SmoothPageIndicator(
                            controller: _controller,
                            count: _onboardingController.onboardingData.length,
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

                          // Continue/Get Started Button
                          Obx(
                            () => MyButtonWithIcon(
                              text: _onboardingController.isLastPage
                                  ? 'Get Started'
                                  : 'Continue',
                              iconPath: Assets.fire,
                              onTap: _navigateToNext,
                              isLoading: _onboardingController.isLoading.value,
                            ),
                          ),
                        ],
                      ),
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
