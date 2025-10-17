import 'package:nutri/constants/export.dart';
import 'package:nutri/services/storage-services.dart';
import 'package:nutri/widget/toasts.dart';

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

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();

  final RxString userToken = ''.obs;
  final RxString userName = ''.obs;
  final RxString userEmail = ''.obs;
  final RxString userId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _checkExistingSession();
  }

  void _checkExistingSession() async {
    final token = await StorageService.getToken();
    final email = await StorageService.getEmail();
    final name = await StorageService.getName();
    final remember = await StorageService.getRememberMe();

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

  void togglePasswordVisibility() => visiblePassword.toggle();
  void toggleConfirmPasswordVisibility() => visibleConfirmPassword.toggle();
  void toggleRememberMe(bool? value) => rememberMe(value ?? false);
  void toggleAgreeToTerms(bool? value) => agreeToTerms(value ?? false);

  void toggleAuthMode() {
    isSignIn.toggle();
    if (isSignIn.isFalse) {
      confirmPasswordController.clear();
      nameController.clear();
    }
  }

  void showForgotPassword() {
    isForgotPassword(true);
    isSignIn(false);
    isResetLinkSent(false);
  }

  void backToSignIn() {
    isForgotPassword(false);
    isSignIn(true);
    isResetLinkSent(false);
  }

  void clearTextFields() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    nameController.clear();
  }

  Future<void> sendPasswordResetEmail() async {
    try {
      final email = emailController.text.trim();

      if (!GetUtils.isEmail(email)) {
        AppToast.error('Please enter a valid email address');
        return;
      }

      isLoading(true);
      await Future.delayed(const Duration(seconds: 2));

      isResetLinkSent(true);
      AppToast.success('Password reset link sent to $email');
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
      await Future.delayed(const Duration(seconds: 2));

      if (email == "demo@nutri.com" && password == "Password123") {
        await _saveUserSession(
          token: 'simulated_token_${DateTime.now().millisecondsSinceEpoch}',
          email: email,
          name: 'Demo User',
          userId: 'user_123',
        );

        isLoggedIn.value = true;
        clearTextFields();
        AppToast.success('Welcome back!');

        NavigationHelper.navigateTo(
          AppLinks.navbar,
          customTransition: Transition.circularReveal,
          customDuration: const Duration(milliseconds: 500),
        );
      } else {
        AppToast.error('Invalid email or password');
      }
    } catch (e) {
      AppToast.error('Login failed. Please try again.');
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
      await Future.delayed(const Duration(seconds: 2));

      await _saveUserSession(
        token: 'simulated_token_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        name: name,
        userId: 'user_${DateTime.now().millisecondsSinceEpoch}',
      );

      isLoggedIn.value = true;
      clearTextFields();
      AppToast.success('Account created successfully!');

      NavigationHelper.navigateTo(
        AppLinks.navbar,
        customTransition: Transition.fadeIn,
        customDuration: const Duration(milliseconds: 500),
      );
    } catch (e) {
      AppToast.error('Registration failed. Please try again.');
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

    await StorageService.setToken(token);
    await StorageService.setEmail(email);
    await StorageService.setName(name);
    await StorageService.setUserId(userId);
    await StorageService.setRememberMe(rememberMe.value);
    await StorageService.setLoginStatus(true);
  }

  Future<void> logout() async {
    try {
      isLoading(true);
      userToken.value = '';
      userEmail.value = '';
      userName.value = '';
      userId.value = '';
      isLoggedIn.value = false;
      rememberMe.value = false;

      await StorageService.clearUserData();
      clearTextFields();

      AppToast.success('Logged out successfully');


      NavigationHelper.navigateTo(
        AppLinks.auth,
        customTransition: Transition.circularReveal,
        customDuration: const Duration(milliseconds: 500),
      );
    } catch (e) {
      AppToast.error('Logout failed: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  Future<bool> checkAuthentication() async {
    try {
      final token = await StorageService.getToken();
      final isLoggedInStorage = await StorageService.getLoginStatus();

      if (token.isNotEmpty && isLoggedInStorage) {
        userToken.value = token;
        userEmail.value = await StorageService.getEmail();
        userName.value = await StorageService.getName();
        userId.value = await StorageService.getUserId() ?? '';
        isLoggedIn.value = true;
        return true;
      }
      return false;
    } catch (e) {
      print('Authentication check error: $e');
      return false;
    }
  }

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

  void fillDemoCredentials() {
    if (isSignIn.value) {
      emailController.text = "demo@nutri.com";
      passwordController.text = "Password123";
    } else {
      nameController.text = "Demo User";
      emailController.text = "demo@nutri.com";
      passwordController.text = "Password123";
      confirmPasswordController.text = "Password123";
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    super.onClose();
  }
}
