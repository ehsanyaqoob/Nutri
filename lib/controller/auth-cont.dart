import 'package:nutri/Screens/navbar/homebarscreens/home-screen.dart';
import 'package:nutri/Screens/navbar/navbar-screen.dart';
import 'package:nutri/Screens/profile/finger-print-screen.dart';
import 'package:nutri/Screens/profile/fill-up-profile-details.dart';
import 'package:nutri/widget/toasts.dart';
import 'package:nutri/constants/export.dart';
import 'package:nutri/constants/export.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var isPinLoading = false.obs;
  var isForgotPasswordLoading = false.obs;
  var obscurePassword = true.obs;
  var rememberMe = false.obs;
  var agreeToTerms = false.obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  var pin = "".obs;
  var selectedContact = ''.obs;
  var maskedContact = ''.obs;
  var hasPinSetup = false.obs;
  var isOtpVerified = false.obs;

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  Future<void> login(String email, String password, bool remember) async {
    try {
      isLoading(true);
      await Future.delayed(const Duration(seconds: 2));

      if (email.isEmpty || !email.contains('@')) {
        AppToast.error('Please enter a valid email'.tr);
        return;
      }
      if (password.isEmpty || password.length < 6) {
        AppToast.error('Password must be at least 6 characters'.tr);
        return;
      }

      AppToast.success('Login successful!'.tr);

      if (remember) debugPrint("User chose to remember credentials");

      Get.offAll(
        () => FunicaNavBar(),
        transition: Transition.cupertino,
        duration: const Duration(milliseconds: 500),
      );
    } catch (e) {
      AppToast.error('Login failed: ${e.toString()}'.tr);
    } finally {
      isLoading(false);
    }
  }

  Future<void> signup(String name, String email, String password) async {
    try {
      isLoading(true);
      await Future.delayed(const Duration(seconds: 2));

      if (name.isEmpty) {
        AppToast.error('Please enter your name'.tr);
        return;
      }
      if (email.isEmpty || !email.contains('@')) {
        AppToast.error('Please enter a valid email'.tr);
        return;
      }
      if (password.isEmpty || password.length < 6) {
        AppToast.error('Password must be at least 6 characters'.tr);
        return;
      }
      if (!agreeToTerms.value) {
        AppToast.error('Please agree to terms and conditions'.tr);
        return;
      }

      AppToast.success('Signup successful! Welcome to Funica'.tr);

      Get.to(
        () => const FunicaNavBar(),
        transition: Transition.cupertino,
        duration: const Duration(milliseconds: 500),
      );
    } catch (e) {
      AppToast.error('Signup failed: ${e.toString()}'.tr);
    } finally {
      isLoading(false);
    }
  }

  Future<void> createPin() async {
    if (pin.value.length != 4) {
      AppToast.error("Please enter 4-digit PIN");
      return;
    }
    try {
      isPinLoading(true);
      await Future.delayed(const Duration(seconds: 2));

      AppToast.success("Your pin has been successfully created");
      hasPinSetup(true);

      // Get.to(
      //   () => const FingerPrintScreen(),
      //   transition: Transition.cupertino,
      //   duration: const Duration(milliseconds: 500),
      // );
    } catch (e) {
      AppToast.error("Failed to create PIN: ${e.toString()}");
    } finally {
      isPinLoading(false);
    }
  }

  void selectForgotPasswordContact(String contact, String masked) {
    selectedContact(contact);
    maskedContact(masked);
    isOtpVerified(false);
  }

  Future<void> sendForgotPasswordCode() async {
    try {
      isForgotPasswordLoading(true);
      await Future.delayed(const Duration(seconds: 2));

      AppToast.success("Verification code sent to $maskedContact");
    } catch (e) {
      AppToast.error("Failed to send code: ${e.toString()}");
    } finally {
      isForgotPasswordLoading(false);
    }
  }

  Future<bool> verifyForgotPasswordOtp() async {
    if (pin.value.length != 4) {
      AppToast.error("Please enter 4-digit OTP");
      return false;
    }

    try {
      isPinLoading(true);
      await Future.delayed(const Duration(seconds: 2));

      AppToast.success("OTP verified successfully");
      isOtpVerified(true);
      return true;
    } catch (e) {
      AppToast.error("OTP verification failed: ${e.toString()}");
      return false;
    } finally {
      isPinLoading(false);
    }
  }

  Future<void> setNewPassword(String newPass, String confirmPass) async {
    if (newPass.isEmpty || newPass.length < 6) {
      AppToast.error("Password must be at least 6 characters");
      return;
    }
    if (newPass != confirmPass) {
      AppToast.error("Passwords do not match");
      return;
    }

    try {
      isForgotPasswordLoading(true);
      await Future.delayed(const Duration(seconds: 2));

      //DialogHelper.showPasswordResetSuccessDialog();
      resetForgotPasswordFlow();
    } catch (e) {
      AppToast.error("Failed to set new password: ${e.toString()}");
    } finally {
      isForgotPasswordLoading(false);
    }
  }

  void resetForgotPasswordFlow() {
    pin("");
    newPasswordController.clear();
    confirmPasswordController.clear();
    isOtpVerified(false);
    selectedContact('');
    maskedContact('');
  }

  void togglePasswordVisibility() => obscurePassword(!obscurePassword.value);
  void toggleRememberMe(bool? value) => rememberMe(value ?? false);
  void toggleAgreeToTerms(bool? value) => agreeToTerms(value ?? false);
}
