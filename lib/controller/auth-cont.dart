import 'package:nutri/config/api_endpoint/endpoints.dart';
import 'package:nutri/constants/export.dart';
import 'package:nutri/services/api_services/api_service.dart';

class AuthController extends GetxController {
  final RxBool isSignIn = true.obs;
  final RxBool visiblePassword = false.obs;
  final RxBool visibleConfirmPassword = false.obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoggedIn = false.obs;
  final RxBool isForgotPassword = false.obs;
  final RxBool isResetLinkSent = false.obs;
  final RxBool rememberMe = false.obs;
  final RxBool agreeToTerms = false.obs;
  final RxBool showOtpScreen = false.obs;
  final RxString otp = ''.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  final RxString userToken = ''.obs;
  final RxString userName = ''.obs;
  final RxString userEmail = ''.obs;
  final RxString userId = ''.obs;

  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    _checkExistingSession();
  }
// check user's existing session
  void _checkExistingSession() async {
    final token = await Storage.authToken;
    final email = await Storage.email;
    final name = await Storage.name;
    final remember = await Storage.rememberMe;

    if (token.isNotEmpty && email.isNotEmpty) {
      userToken.value = token;
      userEmail.value = email;
      userName.value = name;
      isLoggedIn.value = true;

      if (remember) {
        emailController.text = email;
        rememberMe.value = true;
      }
    }
  }
// toggles methods for auth
  void togglePasswordVisibility() => visiblePassword.toggle();
  void toggleConfirmPasswordVisibility() => visibleConfirmPassword.toggle();
  void toggleRememberMe(bool? value) => rememberMe(value ?? false);
  void toggleAgreeToTerms(bool? value) => agreeToTerms(value ?? false);
// toggle auth mode 
  void toggleAuthMode() {
    isSignIn.toggle();
    if (isSignIn.isFalse) {
      confirmPasswordController.clear();
      nameController.clear();
    }
    showOtpScreen.value = false;
    otpController.clear();
  }

  void showForgotPassword() {
    isForgotPassword(true);
    isSignIn(false);
    isResetLinkSent(false);
    showOtpScreen.value = false;
  }

  void backToSignIn() {
    isForgotPassword(false);
    isSignIn(true);
    isResetLinkSent(false);
    showOtpScreen.value = false;
  }

  void clearTextFields() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    nameController.clear();
    otpController.clear();
  }

  // ========== API METHODS ==========

  Future<void> sendPasswordResetEmail() async {
    try {
      final email = emailController.text.trim();

      if (!GetUtils.isEmail(email)) {
        AppToast.error('Please enter a valid email address');
        return;
      }

      isLoading(true);

      final response = await _apiService.post(
        EndPoints.forgotPassword,
        {'email': email},
        false,
        (data) => data,
      );

      if (response.success) {
        isResetLinkSent(true);
        AppToast.success('Password reset link sent to $email');
      } else {
        AppToast.error(response.message);
      }
    } catch (e) {
      AppToast.error('Failed to send reset link. Please try again.');
    } finally {
      isLoading(false);
    }
  }

  Future<void> signIn() async {
  try {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (!_validateSignInInputs(email, password)) return;

    isLoading(true);

    final response = await _apiService.post<Map<String, dynamic>>(
      EndPoints.login,
      {'email': email, 'password': password},
      false,
      (data) => data as Map<String, dynamic>,
    );

    if (response.success && response.data != null) {
      // Extract data directly from response.data
      final token =
          response.data!['token'] ?? response.data!['access_token'] ?? '';
      final name =
          response.data!['name'] ?? response.data!['user_name'] ?? '';
      final userId =
          response.data!['user_id'] ?? response.data!['id']?.toString() ?? '';

      await _saveUserSession(
        token: token,
        email: email,
        name: name,
        userId: userId,
      );

      isLoggedIn.value = true;
      clearTextFields();

      NavigationHelper.navigateTo(
        AppLinks.navbar,
        customTransition: Transition.circularReveal,
        customDuration: const Duration(milliseconds: 500),
      );
    } else {
     
      AppToast.error(response.message ?? 'Login failed');
    }
  } catch (e) {
    AppToast.error('Network error. Please check your connection.');
  } finally {
    isLoading(false);
  }
}

Future<void> signUp() async {
  try {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    final name = nameController.text.trim();

    if (!_validateSignUpInputs(email, password, confirmPassword, name))
      return;

    if (!agreeToTerms.value) {
      AppToast.error('Please agree to terms and conditions');
      return;
    }

    isLoading(true);

    final response = await _apiService.post<dynamic>(
      EndPoints.register,
      {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': confirmPassword,
      },
      false,
      (data) => data,
    );

    if (response.success) {
      showOtpScreen.value = true;
      AppToast.success(response.message ?? 'Registration successful'); 
    } else {
      AppToast.error(response.message ?? 'Registration failed');
    }
  } catch (e) {
    AppToast.error('Network error. Please try again.');
  } finally {
    isLoading(false);
  }
}

Future<void> verifyOtp() async {
  try {
    final otp = otpController.text.trim();
    final email = emailController.text.trim();

    if (otp.isEmpty || otp.length != 6) {
      AppToast.error('Please enter a valid 6-digit OTP');
      return;
    }

    isLoading(true);

    final response = await _apiService.post<Map<String, dynamic>>(
      EndPoints.verifyOtp,
      {'email': email, 'otp': otp},
      false,
      (data) => data as Map<String, dynamic>,
    );

    if (response.success && response.data != null) {
      // If API works, use real data
      final token =
          response.data!['token'] ?? response.data!['access_token'] ?? '';
      final name =
          response.data!['name'] ?? response.data!['user_name'] ?? '';
      final userId =
          response.data!['user_id'] ??
          response.data!['id']?.toString() ??
          '';

      await _saveUserSession(
        token: token.isNotEmpty
            ? token
            : 'dummy_token_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        name: name.isNotEmpty ? name : email.split('@').first,
        userId: userId.isNotEmpty
            ? userId
            : 'user_${DateTime.now().millisecondsSinceEpoch}',
      );

      isLoggedIn.value = true;
      showOtpScreen.value = false;
      clearTextFields();
      AppToast.success(response.message ?? 'Email verified successfully!'); 
      NavigationHelper.navigateTo(
        AppLinks.navbar,
        customTransition: Transition.fadeIn,
        customDuration: const Duration(milliseconds: 500),
      );
    } else {
      AppToast.error(response.message ?? 'Invalid OTP. Please try again.');
    }
  } catch (e) {
    AppToast.error('Network error. Please try again.');
  } finally {
    isLoading(false);
  }
}
  Future<void> resendOtp() async {
    try {
      final email = emailController.text.trim();

      if (!GetUtils.isEmail(email)) {
        AppToast.error('Please enter a valid email address');
        return;
      }

      isLoading(true);

      final response = await _apiService.post<dynamic>(
        EndPoints.resendOtp,
        {'email': email},
        false,
        (data) => data,
      );

      if (response.success) {
        AppToast.success(response.message); 
      } else {
        AppToast.error(response.message);
      }
    } catch (e) {
      AppToast.error('Failed to resend OTP. Please try again.');
    } finally {
      isLoading(false);
    }
  }
Future<void> logout() async {
  try {
    isLoading(true);
    await _apiService.post<dynamic>(
      EndPoints.logout,
      {},
      true,
      (data) => data,
    );

    userToken.value = '';
    userEmail.value = '';
    userName.value = '';
    userId.value = '';
    isLoggedIn.value = false;
    rememberMe.value = false;

    await Storage.clearUserData();
    clearTextFields();

    AppToast.success('Logged out successfully');

    if (Get.isRegistered<NavController>()) {
      Get.find<NavController>().resetToHome();
    }

    // Then navigate
    NavigationHelper.navigateTo(
      AppLinks.auth,
      customTransition: Transition.circularReveal,
      customDuration: const Duration(milliseconds: 500),
    );
  } catch (e) {
    await Storage.clearUserData();
    
    if (Get.isRegistered<NavController>()) {
      Get.find<NavController>().resetToHome();
    }
    
    AppToast.success('Logged out successfully');
  } finally {
    isLoading(false);
  }
}
  Future<void> _saveUserSession({
    required String token,
    required String email,
    required String name,
    required String userId,
  }) async {
    userToken.value = token;
    userEmail.value = email;
    userName.value = name;
    this.userId.value = userId;

    await Storage.saveUserSession(
      token: token,
      email: email,
      name: name,
      userId: userId,
      rememberMe: rememberMe.value,
    );
  }

  Future<bool> checkAuthentication() async {
    try {
      if (await Storage.hasValidSession) {
        userToken.value = await Storage.authToken;
        userEmail.value = await Storage.email;
        userName.value = await Storage.name;
        userId.value = await Storage.userId ?? '';
        isLoggedIn.value = true;
        return true;
      }
      return false;
    } catch (e) {
      print('Authentication check error: $e');
      return false;
    }
  }

  // ========== VALIDATION METHODS ==========

  bool _validateSignInInputs(String email, String password) {
    if (email.isEmpty || !GetUtils.isEmail(email)) {
      AppToast.error('Please enter a valid email address');
      return false;
    }

    if (password.isEmpty) {
      AppToast.error('Please enter your password');
      return false;
    }

    if (password.length < 6) {
      AppToast.error('Password must be at least 6 characters');
      return false;
    }

    return true;
  }

  bool _validateSignUpInputs(
    String email,
    String password,
    String confirmPassword,
    String name,
  ) {
    if (name.isEmpty) {
      AppToast.error('Please enter your name');
      return false;
    }

    if (name.length < 2) {
      AppToast.error('Name must be at least 2 characters');
      return false;
    }

    if (!_validateSignInInputs(email, password)) return false;

    if (password != confirmPassword) {
      AppToast.error('Passwords do not match');
      return false;
    }

    if (password.length < 8) {
      AppToast.error('Password must be at least 8 characters');
      return false;
    }

    if (!password.contains(RegExp(r'[A-Z]'))) {
      AppToast.error('Password must contain at least one uppercase letter');
      return false;
    }

    if (!password.contains(RegExp(r'[0-9]'))) {
      AppToast.error('Password must contain at least one number');
      return false;
    }

    return true;
  }

  // REMOVED: fillDemoCredentials() method

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    otpController.dispose();
    super.onClose();
  }
}
