import 'dart:io';
import 'package:nutri/config/theme/theme-cont.dart';
import 'package:nutri/constants/export.dart';
import 'package:nutri/widget/toasts.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;
  final RxBool _isSuccess = false.obs;
  final Rx<File?> _profileImage = Rx<File?>(null);
  final RxString _userName = 'Andrew Ainsley'.obs;
  final RxString _phone = '+1 467 378 399'.obs;
  final RxString _email = 'andrew.ainsley@email.com'.obs;
  final RxBool _isDarkMode = false.obs;
  final RxString _language = 'English (US)'.obs;
  final RxBool _notificationsEnabled = true.obs;

  final GetStorage _storage = GetStorage();

  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  bool get isSuccess => _isSuccess.value;
  File? get profileImage => _profileImage.value;
  String get userName => _userName.value;
  String get phone => _phone.value;
  String get email => _email.value;
  bool get isDarkMode => _isDarkMode.value;
  String get language => _language.value;
  bool get notificationsEnabled => _notificationsEnabled.value;

  @override
  void onInit() {
    super.onInit();
    _loadFromStorage();
  }

  Future<void> pickFromGallery() async {
    try {
      final picked = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 80,
      );
      if (picked != null) {
        _profileImage.value = File(picked.path);
        await _storage.write('profileImage', picked.path);
        update();
        AppToast.success('Profile picture updated');
      }
    } catch (e) {
      AppToast.error('Failed to pick image');
    }
  }

  Future<void> pickFromCamera() async {
    try {
      final picked = await ImagePicker().pickImage(
        source: ImageSource.camera,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 80,
      );
      if (picked != null) {
        _profileImage.value = File(picked.path);
        await _storage.write('profileImage', picked.path);
        update();
        AppToast.success('Profile picture updated');
      }
    } catch (e) {
      AppToast.error('Failed to capture image');
    }
  }

  void removeImage() {
    _profileImage.value = null;
    _storage.remove('profileImage');
    update();
    AppToast.info('Profile picture removed');
  }

  void updateUserName(String name) {
    _userName.value = name;
    _storage.write('userName', name);
    update();
  }

  void updatePhone(String newPhone) {
    _phone.value = newPhone;
    _storage.write('phone', newPhone);
    update();
  }

  void updateEmail(String newEmail) {
    _email.value = newEmail;
    _storage.write('email', newEmail);
    update();
  }

  void toggleDarkMode(bool value) {
    _isDarkMode.value = value;
    _storage.write('isDarkMode', value);
    update();
  }

  void updateLanguage(String newLanguage) {
    _language.value = newLanguage;
    _storage.write('language', newLanguage);
    update();
    AppToast.info('Language changed to $newLanguage');
  }

  void toggleNotifications(bool value) {
    _notificationsEnabled.value = value;
    _storage.write('notificationsEnabled', value);
    update();
    AppToast.info(value ? 'Notifications enabled' : 'Notifications disabled');
  }

  void _loadFromStorage() {
    _userName.value = _storage.read('userName') ?? 'Andrew Ainsley';
    _phone.value = _storage.read('phone') ?? '+1 467 378 399';
    _email.value = _storage.read('email') ?? 'andrew.ainsley@email.com';
    _isDarkMode.value = _storage.read('isDarkMode') ?? false;
    _language.value = _storage.read('language') ?? 'English (US)';
    _notificationsEnabled.value = _storage.read('notificationsEnabled') ?? true;
    
    final imagePath = _storage.read('profileImage') ?? '';
    if (imagePath.isNotEmpty && File(imagePath).existsSync()) {
      _profileImage.value = File(imagePath);
    }
  }

  void logout() {
    Get.dialog(
      AlertDialog(
        backgroundColor: kDynamicCard(Get.context!),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: MyText(
          text: 'Logout',
          size: 20,
          weight: FontWeight.bold,
          color: kDynamicText(Get.context!),
        ),
        content: MyText(
          text: 'Are you sure you want to logout?',
          size: 16,
          color: kDynamicSubtitleText(Get.context!),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: MyText(
              text: 'Cancel',
              color: kDynamicSubtitleText(Get.context!),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              _performLogout();
            },
            child: MyText(
              text: 'Logout',
              color: kDynamicSystemRed(Get.context!),
              weight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _performLogout() {
    _storage.erase();
    AppToast.success('Logged out successfully');
  }

  void clearError() {
    _errorMessage.value = '';
    update();
  }

  @override
  void onClose() {
    _isLoading.close();
    _errorMessage.close();
    _isSuccess.close();
    _userName.close();
    _phone.close();
    _email.close();
    _profileImage.close();
    super.onClose();
  }
}