import 'package:nutri/constants/export.dart';
import 'package:nutri/controller/auth-cont.dart';
import 'package:nutri/Screens/auth/sign-in.dart';
import 'package:nutri/Screens/profile/fill-up-profile-details.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool agreeToTerms = false;
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
              title: 'Sign-Up'.tr,
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
                      const Gap(20),
                      Center(
                        child: Image.asset(
                          isDarkMode ? Assets.funicalight : Assets.funicadark,
                          height: 100,
                          width: 80,
                        ),
                      ),
                      const Gap(30),
                      MyText(
                        text: "Create Your Account".tr,
                        size: 28,
                        weight: FontWeight.bold,
                        color: kDynamicIcon(context),
                      ),
                      const Gap(30),

                      /// Full Name
                      MyTextField(
                        controller: authcontroller.nameController,
                        marginBottom: 12,
                        hint: "Full Name".tr,
                        prefix: SvgPicture.asset(
                          Assets.personfilled,
                          height: 20,
                          color: kDynamicIcon(context),
                          alignment: Alignment.center,
                        ),
                        focusedFillColor: kWhite,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name'.tr;
                          }
                          if (value.length < 2) {
                            return 'Name must be at least 2 characters'.tr;
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                      ),
                      const Gap(10),

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

                      // /// Password
                      // MyTextField(
                      //   marginBottom: 12,
                      //   hint: "Must have at least 6 characters".tr,
                      //   suffix: Get.locale?.languageCode == 'ar'
                      //       ? null
                      //       : Padding(
                      //           padding: const EdgeInsets.symmetric(
                      //             horizontal: 8,
                      //           ),
                      //           child: CommonImageView(
                      //             imagePath: Assets.imagesHide,
                      //             color: kDynamicIcon(context),
                      //             height: 20,
                      //           ),
                      //         ),
                      //   focusedFillColor: kWhite,
                      //   isObSecure: true,
                      //   showPasswordToggle: true,
                      //   prefix: SvgPicture.asset(
                      //     Assets.lockfilled,
                      //     height: 20,
                      //     color: kDynamicIcon(context),
                      //     alignment: Alignment.center,
                      //   ),
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Please enter your password'.tr;
                      //     }
                      //     if (value.length < 6) {
                      //       return 'Password must be at least 6 characters'.tr;
                      //     }
                      //     return null;
                      //   },
                      // ),
                      // const Gap(10),

                      /// Confirm Password
                      MyTextField(
                        controller: authcontroller.passwordController,

                        marginBottom: 12,
                        hint: "Confirm Password".tr,
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
                            return 'Please confirm your password'.tr;
                          }
                          return null;
                        },
                      ),

                      const Gap(30),

                      Center(
                        child: Obx(() {
                          return Center(
                            child: CustomCheckbox(
                              text: "I agree to the ".tr,
                              text2: "Terms & Conditions".tr,
                              activeColor: kDynamicIcon(context),
                              inactiveColor: kDynamicBackground(context),
                              textColor: kDynamicText(context),
                              value: authcontroller.agreeToTerms.value,
                              onChanged: (val) =>
                                  authcontroller.toggleAgreeToTerms(val),
                            ),
                          );
                        }),
                      ),

                      const Gap(30),

                      /// Sign Up Button
                      Obx(() {
                        return MyButton(
                          isLoading: authcontroller.isLoading.value,
                          buttonText: "Sign Up".tr,
                          onTap: () {
                            authcontroller.signup(
                              authcontroller.nameController.text.trim(),
                              authcontroller.emailController.text.trim(),
                              authcontroller.passwordController.text.trim(),
                            );
                          },
                          hasgrad: true,
                          hasshadow: true,
                        );
                      }),

                      const Gap(30),

                      /// Already have an account? Login
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyText(
                            text: "Already have an account?".tr,
                            size: 16.0,
                            color: kDynamicText(context),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              // Navigate to SignInScreen
                              Get.back();
                            },
                            child: MyText(
                              text: "Login".tr,
                              size: 16.0,
                              color: kDynamicText(context),
                              weight: FontWeight.bold,
                            ),
                          ),
                        ],
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

                      const Gap(20),
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
