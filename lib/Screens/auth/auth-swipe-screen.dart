import 'dart:ui';
import 'package:nutri/extensions/media-query-extension.dart';
import 'package:nutri/widget/floating-icons.dart';
import 'package:nutri/constants/export.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kDynamicScaffoldBackground(context),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Stack(
              children: [
                FloatingIcon(
                  asset: Assets.fruiteapple,
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
          // AnimatedContainer(
          //   duration: const Duration(milliseconds: 800),
          //   decoration: BoxDecoration(
          //     // gradient: LinearGradient(
          //     //   colors: [
          //     //     kDynamicPrimary(context).withOpacity(0.1),
          //     //     kDynamicScaffoldBackground(context),
          //     //   ],
          //     //   begin: Alignment.topLeft,
          //     //   end: Alignment.bottomRight,
          //     // ),
          //   ),
          // ),
          SingleChildScrollView(
            child: Padding(
              padding: AppSizes.DEFAULT,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  60.height,
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Obx(
                      () => AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                              return SlideTransition(
                                position: Tween<Offset>(
                                  begin: Offset(
                                    authController.isSignIn.isTrue
                                        ? 1.0
                                        : authController.isForgotPassword.isTrue
                                        ? -1.0
                                        : 0.0,
                                    0.0,
                                  ),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                              );
                            },
                        child: authController.isForgotPassword.value
                            ? _buildForgotPasswordView()
                            : authController.isSignIn.value
                            ? _buildSignInView()
                            : _buildSignUpView(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForgotPasswordView() {
    return Obx(
      () => authController.isResetLinkSent.value
          ? _buildResetLinkSentView()
          : _buildForgotPasswordFormView(),
    );
  }

  Widget _buildForgotPasswordFormView() {
    return Column(
      key: const ValueKey('forgot_password_form_view'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(30.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                kDynamicPrimary(context),
                kDynamicPrimary(context).withOpacity(0.5),
              ],
            ),
          ),
          child: SvgPicture.asset(
            Assets.emailfilled,
            height: 72.0,
            color: kDynamicIcon(context),
          ),
        ).animate().scale(duration: 500.ms).fadeIn(),
        MyText(
          text: 'Reset Password',
          size: 22.0,
          weight: FontWeight.bold,
          color: kDynamicText(context),
        ).animate().fadeIn(duration: 400.ms),
        MyText(
          text: 'Enter your email to receive a reset link',
          size: 14.0,
          color: kDynamicText(context),
        ).animate().fadeIn(duration: 500.ms, delay: 100.ms),
        Gap(20),
        MyTextField(
          controller: authController.emailController,
          hint: "Enter your email",
          label: 'Email',
          keyboardType: TextInputType.emailAddress,
          prefix: SvgPicture.asset(
            Assets.emailfilled,
            height: 22.0,
            color: kDynamicIcon(context),
          ),
        ).animate().fadeIn(duration: 500.ms, delay: 200.ms),
        Gap(10),
        Obx(
          () => MyButton(
            buttonText: "Send Reset Link",
            isLoading: authController.isLoading.value,
            onTap: () => authController.sendPasswordResetEmail(),
          ),
        ).animate().fadeIn(duration: 500.ms, delay: 300.ms),
        Gap(10),
        GestureDetector(
          onTap: () => authController.backToSignIn(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                Assets.emailfilled,
                height: 16,
                color: kDynamicIcon(context),
              ),
              Gap(10),
              MyText(
                text: "Back to Sign In",
                size: 12,
                weight: FontWeight.w600,
                color: kDynamicIcon(context),
              ),
            ],
          ),
        ).animate().fadeIn(duration: 500.ms, delay: 400.ms),
      ],
    );
  }

  Widget _buildResetLinkSentView() {
    return Column(
      key: const ValueKey('reset_link_sent_view'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                kDynamicPrimary(context),
                kDynamicPrimary(context).withOpacity(0.5),
              ],
            ),
          ),
          child: Icon(
            Icons.check_circle_rounded,
            size: 72.0,
            color: kDynamicIcon(context),
          ),
        ).animate().scale(duration: 500.ms).fadeIn(),
        MyText(
          text: 'Email Sent!',
          size: 22.0,
          weight: FontWeight.bold,
          color: kDynamicText(context),
        ).animate().fadeIn(duration: 400.ms),
        Column(
          children: [
            MyText(
              text: 'We sent a password reset link to',
              size: 14.0,
              color: kDynamicText(context),
            ),
            Gap(10),
            MyText(
              text: authController.emailController.text.trim(),
              size: 13,
              weight: FontWeight.bold,
              color: kDynamicText(context),
            ),
          ],
        ).animate().fadeIn(duration: 500.ms, delay: 100.ms),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: kDynamicContainer(context),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: kDynamicIcon(context),
                size: 16,
              ),
              Gap(8),
              MyText(
                text: 'Check your spam folder if you don\'t see the email',
                size: 11,
                textAlign: TextAlign.center,
                color: kDynamicText(context),
              ),
            ],
          ),
        ).animate().fadeIn(duration: 500.ms, delay: 200.ms),
        Gap(20),
        MyButton(
          buttonText: "Back to Sign In",
          onTap: () => authController.backToSignIn(),
        ).animate().fadeIn(duration: 500.ms, delay: 300.ms),
      ],
    );
  }

  Widget _buildSignUpView() {
    return Column(
      key: const ValueKey('signup_view'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(30.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                kDynamicPrimary(context),
                kDynamicPrimary(context).withOpacity(0.5),
              ],
            ),
          ),
          child: SvgPicture.asset(
            Assets.personfilled,
            height: 72,
            color: kDynamicIcon(context),
          ),
        ).animate().scale(duration: 500.ms).fadeIn(),
        8.height,
        MyText(
          text: 'Create Account',
          size: 22,
          weight: FontWeight.bold,
          color: kDynamicText(context),
        ).animate().fadeIn(duration: 400.ms),
        8.height,
        MyText(
          text:
              'Join our community and start your journey towards better health. Create your account to access personalized nutrition tracking and AI-powered insights.',
          size: 14,
          color: kDynamicText(context).withOpacity(0.8),
          textAlign: TextAlign.center,
        ).animate().fadeIn(duration: 500.ms, delay: 100.ms),
        Gap(10),
        MyTextField(
          controller: authController.nameController,
          hint: "Enter your name",
          label: 'Name',
          keyboardType: TextInputType.name,
          prefix: SvgPicture.asset(
            Assets.personfilled,
            height: 20,
            color: kDynamicIcon(context),
          ),
        ).animate().fadeIn(duration: 500.ms, delay: 200.ms),
        Gap(10),
        MyTextField(
          controller: authController.emailController,
          hint: "Enter your email",
          label: 'Email',
          keyboardType: TextInputType.emailAddress,
          prefix: SvgPicture.asset(
            Assets.emailfilled,
            height: 20,
            color: kDynamicIcon(context),
          ),
        ).animate().fadeIn(duration: 500.ms, delay: 300.ms),
        Gap(10),
        Obx(
          () => MyTextField(
            controller: authController.passwordController,
            hint: "Enter your password",
            label: 'Password',
            isObSecure: !authController.visiblePassword.value,
            prefix: SvgPicture.asset(
              Assets.lockfilled,
              height: 20,
              color: kDynamicIcon(context),
            ),
            suffix: IconButton(
              icon: Icon(
                authController.visiblePassword.value
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                color: kDynamicIcon(context),
              ),
              onPressed: () => authController.togglePasswordVisibility(),
            ),
          ),
        ).animate().fadeIn(duration: 500.ms, delay: 400.ms),
        Gap(10),
        Obx(
          () => MyTextField(
            controller: authController.confirmPasswordController,
            hint: "Confirm your password",
            label: 'Confirm Password',
            isObSecure: !authController.visibleConfirmPassword.value,
            prefix: SvgPicture.asset(
              Assets.lockfilled,
              height: 20,
              color: kDynamicIcon(context),
            ),
            suffix: IconButton(
              icon: Icon(
                authController.visibleConfirmPassword.value
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                color: kDynamicIcon(context),
              ),
              onPressed: () => authController.toggleConfirmPasswordVisibility(),
            ),
          ),
        ).animate().fadeIn(duration: 500.ms, delay: 500.ms),
        Gap(10),
        Obx(
          () => CustomCheckbox(
            text: "I agree to the ".tr,
            text2: "Terms & Conditions".tr,
            activeColor: kDynamicPrimary(context),
            inactiveColor: kDynamicBorder(context),
            textColor: kDynamicText(context),
            value: authController.agreeToTerms.value,
            onChanged: (val) => authController.toggleAgreeToTerms(val),
          ),
        ).animate().fadeIn(duration: 500.ms, delay: 550.ms),
        Gap(10),
        Obx(
          () => MyButton(
            buttonText: "Sign Up",
            isLoading: authController.isLoading.value,
            onTap: () => authController.signUp(),
          ),
        ).animate().fadeIn(duration: 500.ms, delay: 600.ms),
        Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText(
              text: "Already have an account?",
              size: 14.0,
              color: kDynamicText(context).withOpacity(0.7),
            ),
            Gap(8),
            Bounce(
              onTap: () => authController.toggleAuthMode(),
              child: MyText(
                text: "Sign In",
                size: 14.0,
                weight: FontWeight.w600,
                color: kDynamicPrimary(context),
              ),
            ),
          ],
        ).animate().fadeIn(duration: 500.ms, delay: 700.ms),
      ],
    );
  }

  Widget _buildSignInView() {
    return Column(
      key: const ValueKey('signin_view'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(30.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                kDynamicPrimary(context),
                kDynamicPrimary(context).withOpacity(0.5),
              ],
            ),
          ),
          child: SvgPicture.asset(
            Assets.emailfilled,
            height: 72,
            color: kDynamicIcon(context),
          ),
        ).animate().scale(duration: 500.ms).fadeIn(),
        8.height,
        MyText(
          text: 'Welcome to Nutri',
          size: 22,
          weight: FontWeight.bold,
          color: kDynamicText(context),
        ).animate().fadeIn(duration: 400.ms),
        8.height,
        MyText(
          text:
              'Welcome back! Sign in to continue your nutrition journey. Track your meals, monitor progress, and get personalized health recommendations.',
          size: 14,
          color: kDynamicText(context).withOpacity(0.8),
          textAlign: TextAlign.center,
        ).animate().fadeIn(duration: 500.ms, delay: 100.ms),
        Gap(10),
        MyTextField(
          controller: authController.emailController,
          hint: "Enter your email",
          label: 'Email',
          keyboardType: TextInputType.emailAddress,
          prefix: SvgPicture.asset(
            Assets.emailfilled,
            height: 20,
            color: kDynamicIcon(context),
          ),
        ).animate().fadeIn(duration: 500.ms, delay: 200.ms),
        Gap(10),
        Obx(
          () => MyTextField(
            controller: authController.passwordController,
            hint: "Enter your password",
            label: 'Password',
            isObSecure: !authController.visiblePassword.value,
            prefix: SvgPicture.asset(
              Assets.lockfilled,
              height: 20,
              color: kDynamicIcon(context),
            ),
            suffix: IconButton(
              icon: Icon(
                authController.visiblePassword.value
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                color: kDynamicIcon(context),
              ),
              onPressed: () => authController.togglePasswordVisibility(),
            ),
          ),
        ).animate().fadeIn(duration: 500.ms, delay: 300.ms),
        Gap(10),
        Center(
          child: Obx(
            () => CustomCheckbox(
              text: "Remember me".tr,
              activeColor: kDynamicPrimary(context),
              inactiveColor: kDynamicBorder(context),
              textColor: kDynamicText(context),
              value: authController.rememberMe.value,
              onChanged: (val) => authController.toggleRememberMe(val),
            ),
          ).animate().fadeIn(duration: 400.ms, delay: 350.ms),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Bounce(
            onTap: () => authController.showForgotPassword(),
            child: MyText(
              text: "Forgot Password?",
              size: 14.0,
              weight: FontWeight.bold,
              color: kDynamicPrimary(context),
            ),
          ),
        ).animate().fadeIn(duration: 400.ms, delay: 350.ms),
        Gap(16),
        Obx(
          () => MyButton(
            buttonText: "Sign In",
            isLoading: authController.isLoading.value,
            onTap: () => authController.signIn(),
          ),
        ).animate().fadeIn(duration: 500.ms, delay: 400.ms),
        Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText(
              text: "Don't have an account?",
              size: 14.0,
              color: kDynamicText(context).withOpacity(0.7),
            ),
            Gap(8),
            Bounce(
              onTap: () => authController.toggleAuthMode(),
              child: MyText(
                text: "Sign Up",
                size: 14.0,
                weight: FontWeight.w600,
                color: kDynamicPrimary(context),
              ),
            ),
          ],
        ).animate().fadeIn(duration: 500.ms, delay: 500.ms),
      ],
    );
  }
}
