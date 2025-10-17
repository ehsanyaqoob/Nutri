import 'package:nutri/constants/export.dart';
import 'package:nutri/controller/auth-cont.dart';
import 'package:nutri/Screens/auth/forgot-pass.dart';
import 'package:nutri/Screens/auth/sign-up.dart';
import 'package:nutri/widget/common_image_view_widget.dart';
import 'package:nutri/widget/custom_appbar.dart';
import 'package:nutri/widget/custom_checkbox_widget.dart';
import 'package:nutri/widget/my_button_new.dart';
import 'package:nutri/widget/my_textfeild.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool rememberMe = false;
  final AuthController authcontroller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        final bool isDarkMode = themeController.isDarkMode;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: isDarkMode
                ? Brightness.light
                : Brightness.dark,
            systemNavigationBarColor: kDynamicScaffoldBackground(context),
            systemNavigationBarIconBrightness: isDarkMode
                ? Brightness.light
                : Brightness.dark,
          ),
          child: Scaffold(
            backgroundColor: kDynamicScaffoldBackground(context),
            appBar: CustomAppBar(
              title: 'Sign-In'.tr,
              showLeading: true,
onBackTap: () {
  if (Get.previousRoute.isNotEmpty) {
    Get.back(); // go back to where it came from
  } else {
    // optional: handle case when there's no previous route
    // e.g. prevent app from closing or navigate to home/login
    // Get.offAll(() => const SignUpScreen());
  }
},
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      const Gap(40),
                      Center(
                        child: Image.asset(
                          isDarkMode ? Assets.funicalight : Assets.funicadark,
                          height: 100,
                          width: 80,
                        ),
                      ),
                      const Gap(30),
                      MyText(
                        text: "Login to Your Account".tr,
                        size: 28,
                        weight: FontWeight.bold,
                        color: kDynamicIcon(context),
                      ),
                      const Gap(30),

                      /// Email
                      MyTextField(
                        controller: authcontroller.emailController,
                        marginBottom: 12,
                        hint: "example@gmail.com".tr,
                        prefix: SvgPicture.asset(
                          Assets.emailfilled,
                          height: 20,
                          color: kDynamicIcon(context),
                          alignment: Alignment.center,
                        ),
                        focusedFillColor: kWhite,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email'.tr;
                          }
                          if (!value.contains('@') || !value.contains('.')) {
                            return 'Please enter a valid email'.tr;
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const Gap(10),

                      /// Password
                      MyTextField(
                        controller: authcontroller.passwordController,
                        marginBottom: 12,
                        hint: "Must have at least 6 characters".tr,
                        suffix: Get.locale?.languageCode == 'ar'
                            ? null
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: CommonImageView(
                                  imagePath: Assets.eye,
                                  color: kDynamicIcon(context),
                                  height: 20,
                                ),
                              ),
                        focusedFillColor: kWhite,
                        isObSecure: true,
                        showPasswordToggle: true,
                        prefix: SvgPicture.asset(
                          Assets.lockfilled,
                          height: 20,
                          color: kDynamicIcon(context),
                          alignment: Alignment.center,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password'.tr;
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters'.tr;
                          }
                          return null;
                        },
                      ),

                      const Gap(30),

                      // Centered Remember Me checkbox
                      Center(
                        child: CustomCheckbox(
                          text: "Remember me".tr,
                          activeColor: kDynamicIcon(context),
                          inactiveColor: kDynamicBackground(context),
                          textColor: kDynamicText(context),
                          value: rememberMe,
                          onChanged: (val) {
                            setState(() {
                              rememberMe = val;
                            });
                          },
                        ),
                      ),

                      const Gap(30),

                      /// Signin Button
                    /// Signin Button
Obx(() {
  return MyButton(
    isLoading: authcontroller.isLoading.value,
    buttonText: "Sign in".tr,
    onTap: () {
      authcontroller.login(
        authcontroller.emailController.text.trim(),
        authcontroller.passwordController.text.trim(),
        authcontroller.rememberMe.value,
      );
    },
    hasgrad: true,
    hasshadow: true,
  );
}),


                      const Gap(30),
                      Bounce(
                        onTap: (){
                          Get.to(ForgotPasswordScreen(), 
                          transition: Transition.cupertino,
                          duration:Duration(milliseconds: 500),
                          
                          );
                        },
                        child: MyText(
                          text: "Forgot your password?".tr,
                          size: 16.0,
                          weight: FontWeight.bold,
                          color: kDynamicIcon(context),
                        ),
                      ),
                      const Gap(30),

                      /// Divider with text
                      Row(
                        children: [
                          const Expanded(child: Divider(thickness: 1)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: MyText(
                              text: "or continue with".tr,
                              size: 16.0,
                              weight: FontWeight.bold,
                              color: kDynamicDivider(context),
                            ),
                          ),
                          const Expanded(child: Divider(thickness: 2)),
                        ],
                      ),

                      const Gap(30),

                      /// Social Buttons
                      const SocialButtons(),
                      const Gap(30),

                      /// Sign up prompt
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyText(
                            text: "Don't have an account?".tr,
                            size: 14,
                            color: kDynamicText(context).withOpacity(0.7),
                            weight: FontWeight.w400,
                          ),
                          const Gap(4),
                          Bounce(
                            onTap: () {
                              // Navigate to Sign-Up Screen
                              Get.to(
                                SignUpScreen(),
                                transition: Transition.cupertino,
                                duration: Duration(milliseconds: 500),
                              );
                            },
                            child: MyText(
                              text: "Sign up".tr,
                              size: 16,
                              color: kDynamicText(context),
                              weight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Social Buttons Widget
class SocialButtons extends StatelessWidget {
  const SocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SocialButton(
            icon: Assets.google,
            label: "Google",
            onTap: () => print("Google tapped"),
          ),
        ),
        Expanded(
          child: SocialButton(
            icon: Assets.apple,
            label: "Apple",
            onTap: () => print("Apple tapped"),
          ),
        ),
      ],
    );
  }
}

class SocialButton extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;

  const SocialButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.0),
      onTap: onTap,
      child: Container(
        height: 60,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: kDynamicBorder(context)),
        ),
        child: Center(child: SvgPicture.asset(icon, height: 40, width: 40)),
      ),
    );
  }
}
