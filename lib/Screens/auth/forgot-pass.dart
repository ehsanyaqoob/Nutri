import 'dart:async';
import 'package:nutri/constants/export.dart';
import 'package:nutri/controller/auth-cont.dart';
import 'package:nutri/generated/assets.dart';
import 'package:nutri/widget/custom_appbar.dart';
import 'package:nutri/widget/my_button_new.dart';
import 'package:nutri/widget/my_textfeild.dart';
import 'package:nutri/widget/toasts.dart';
import 'package:pinput/pinput.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final AuthController authController = Get.find<AuthController>();

  bool isCodeSentView = false;
  bool isNewPasswordView = false;
  bool isSuccessView = false;

  String selectedContact = '';
  String maskedContact = '';
  Timer? _resendTimer;
  int _resendSeconds = 120;

  final TextEditingController otpController = TextEditingController();

  @override
  void dispose() {
    _resendTimer?.cancel();
    otpController.dispose();
    super.dispose();
  }

  void startResendTimer() {
    _resendSeconds = 120;
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendSeconds > 0) {
        setState(() => _resendSeconds--);
      } else {
        timer.cancel();
      }
    });
  }

  void _onOptionSelected(String contact, String masked) {
    setState(() {
      selectedContact = contact;
      maskedContact = masked;
      isCodeSentView = true;
    });
    startResendTimer();
    authController.selectForgotPasswordContact(contact, masked);
    authController.sendForgotPasswordCode();
  }

  void _verifyOtp() async {
    if (otpController.text.length != 4) {
      AppToast.error("Please enter a 4-digit code");
      return;
    }
    authController.pin.value = otpController.text;
    bool verified = await authController.verifyForgotPasswordOtp();
    if (verified) {
      setState(() {
        isNewPasswordView = true;
        isCodeSentView = false;
      });
    }
  }

  void _setNewPassword() async {
    String newPass = authController.newPasswordController.text.trim();
    String confirmPass = authController.confirmPasswordController.text.trim();

    if (newPass.isEmpty || confirmPass.isEmpty) {
      AppToast.error("Please fill all fields");
      return;
    }

    if (newPass.length < 6) {
      AppToast.error("Password must be at least 6 characters");
      return;
    }

    if (newPass != confirmPass) {
      AppToast.error("Passwords do not match");
      return;
    }

    await authController.setNewPassword(newPass, confirmPass);
    setState(() {
      isNewPasswordView = false;
      isSuccessView = true;
    });
  }

  void _handleBackNavigation() {
    if (isSuccessView) {
      Get.back();
    } else if (isNewPasswordView) {
      setState(() {
        isNewPasswordView = false;
        isCodeSentView = true;
      });
    } else if (isCodeSentView) {
      setState(() => isCodeSentView = false);
    } else {
      Get.back();
    }
  }

  String _getAppBarTitle() {
    if (isNewPasswordView) return 'Set New Password'.tr;
    if (isCodeSentView) return 'Enter Code'.tr;
    if (isSuccessView) return 'Success'.tr;
    return 'Forgot Password'.tr;
  }

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
              title: _getAppBarTitle(),
              showLeading: true,
              onBackTap: _handleBackNavigation,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: AppSizes.DEFAULT,
                child: _buildCurrentView(context, isDarkMode),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCurrentView(BuildContext context, bool isDarkMode) {
    if (isSuccessView) return _buildSuccessView(context);
    if (isNewPasswordView) return _buildNewPasswordSection(context);
    if (isCodeSentView) return _buildOtpView(context);
    return _buildOptionView(context, isDarkMode);
  }

  Widget _buildOptionView(BuildContext context, bool isDarkMode) {
    return Column(
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
          text:
              'Select which contact details should we use to reset your password'
                  .tr,
          textAlign: TextAlign.center,
          size: 18.0,
          color: kDynamicText(context),
        ),
        const Gap(30),
        _buildOption(
          icon: Assets.emailfilled,
          title: 'via Email'.tr,
          subtitle: 'andley*****yourdomain@gmail.com',
          onTap: () =>
              _onOptionSelected('email', 'andley*****yourdomain@gmail.com'),
        ),
        const Gap(16),
        _buildOption(
          icon: Assets.smsfilled,
          title: 'via SMS'.tr,
          subtitle: '+11*****999999',
          onTap: () => _onOptionSelected('sms', '+11*****999999'),
        ),
      ],
    );
  }

  Widget _buildOtpView(BuildContext context) {
    return Column(
      children: [
        const Gap(40),
        MyText(
          text: 'Code has been sent to $maskedContact'.tr,
          textAlign: TextAlign.center,
          size: 16.0,
          color: kDynamicText(context),
        ),
        const Gap(40),
        Pinput(
          controller: otpController,
          length: 4,
          obscureText: true,
          obscuringCharacter: '•',
          mainAxisAlignment: MainAxisAlignment.center,
          defaultPinTheme: PinTheme(
            width: 70,
            height: 70,
            textStyle: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: kDynamicText(context),
              fontFamily: AppFonts.Figtree,
            ),
            decoration: BoxDecoration(
              color: kDynamicBackground(context),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: kDynamicBorder(context)),
            ),
          ),
          focusedPinTheme: PinTheme(
            width: 70,
            height: 70,
            textStyle: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: kDynamicText(context),
              fontFamily: AppFonts.Figtree,
            ),
            decoration: BoxDecoration(
              color: kDynamicScaffoldBackground(context),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: kSecondaryColor, width: 1.5),
            ),
          ),
        ),
        const Gap(40),
        Obx(() {
          return MyButton(
            buttonText: "Verify".tr,
            isLoading: authController.isPinLoading.value,
            onTap: _verifyOtp,
          );
        }),
        const Gap(20),
        _buildResendView(),
      ],
    );
  }

  Widget _buildNewPasswordSection(BuildContext context) {
    return Column(
      children: [
        const Gap(40),
        MyText(
          text: 'Set your new password'.tr,
          textAlign: TextAlign.center,
          size: 18.0,
          color: kDynamicText(context),
        ),
        const Gap(40),
        MyTextField(
          controller: authController.newPasswordController,
          marginBottom: 12,
          hint: "Must have at least 6 characters".tr,
          isObSecure: true,
          showPasswordToggle: true,
          prefix: SvgPicture.asset(
            Assets.lockfilled,
            height: 20,
            color: kDynamicIcon(context),
            alignment: Alignment.center,
          ),
        ),
        const Gap(16),
        MyTextField(
          controller: authController.confirmPasswordController,
          marginBottom: 12,
          hint: "Confirm Password".tr,
          isObSecure: true,
          showPasswordToggle: true,
          prefix: SvgPicture.asset(
            Assets.lockfilled,
            height: 20,
            color: kDynamicIcon(context),
            alignment: Alignment.center,
          ),
        ),
        const Gap(30),
        Obx(() {
          return MyButton(
            buttonText: "Continue",
            isLoading: authController.isForgotPasswordLoading.value,
            onTap: _setNewPassword,
          );
        }),
      ],
    );
  }

  Widget _buildSuccessView(BuildContext context) {
    return Column(
      children: [
        const Gap(60),
        Icon(Icons.check_circle, color: kPrimaryColor, size: 80),
        const Gap(30),
        MyText(
          text: "Password reset successfully!".tr,
          textAlign: TextAlign.center,
          size: 18,
          weight: FontWeight.w600,
          color: kDynamicText(context),
        ),
        const Gap(40),
        MyButton(buttonText: "Go to Login".tr, onTap: () => Get.back()),
      ],
    );
  }

  Widget _buildResendView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyText(text: "Didn't receive code?".tr, size: 14, color: kSubText),
        const Gap(6),
        _resendSeconds == 0
            ? GestureDetector(
                onTap: () {
                  startResendTimer();
                  authController.sendForgotPasswordCode();
                },
                child: MyText(
                  text: "Resend".tr,
                  size: 14,
                  weight: FontWeight.w700,
                  color: kPrimaryColor,
                ),
              )
            : MyText(
                text: "00:${_resendSeconds.toString().padLeft(2, '0')}",
                size: 14,
                weight: FontWeight.w700,
                color: kPrimaryColor,
              ),
      ],
    );
  }

  Widget _buildOption({
    required String icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Bounce(
      onTap: onTap,
      child: Container(
        height: 120,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: kDynamicCard(context),
          borderRadius: BorderRadius.circular(36.0),
          border: Border.all(color: kDynamicPrimary(context)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: kPrimaryColor.withOpacity(0.1),
              child: SvgPicture.asset(
                icon,
                color: kDynamicIcon(context),
                height: 30.0,
              ),
            ),
            const Gap(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText(
                  text: title,
                  size: 14.0,
                  weight: FontWeight.w600,
                  color: kSubText4,
                ),
                const Gap(6),
                MyText(
                  text: subtitle,
                  size: 10.0,
                  weight: FontWeight.bold,
                  color: kDynamicText(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
