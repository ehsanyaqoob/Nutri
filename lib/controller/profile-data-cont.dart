import 'dart:io';
import 'package:nutri/constants/export.dart';
import 'package:nutri/widget/bottomsheets/helper-sheets.dart';
class ProfileController extends GetxController {
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;
  final RxBool _isSuccess = false.obs;
  final Rx<File?> _profileImage = Rx<File?>(null);
  final RxString _userName = ''.obs;
  final RxString _phone = ''.obs;
  final RxString _email = ''.obs;
  final RxBool _isDarkMode = false.obs;
  final RxString _language = 'English (US)'.obs;
  final RxBool _notificationsEnabled = true.obs;

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
  bool get hasProfileImage => _profileImage.value != null;

  @override
  void onInit() {
    super.onInit();
    _loadFromStorage();
  }

  // Image Picking Methods with Loader
  Future<void> pickFromCamera() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? picked = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 80,
      );
      
      if (picked != null) {
        await _saveProfileImage(File(picked.path));
        AppToast.success('Profile picture updated from camera');
      }
    } catch (e) {
      AppToast.error('Failed to capture image: ${e.toString()}');
    }
  }

  Future<void> pickFromGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? picked = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 80,
      );
      
      if (picked != null) {
        await _saveProfileImage(File(picked.path));
        AppToast.success('Profile picture updated from gallery');
      }
    } catch (e) {
      AppToast.error('Failed to pick image: ${e.toString()}');
    }
  }

  Future<void> _saveProfileImage(File imageFile) async {
    _isLoading.value = true;
    try {
      // Show processing loader
      BottomSheetHelper.showImageProcessingLoader(
        onComplete: () {
          _profileImage.value = imageFile;
          Storage.setProfileImagePath(imageFile.path);
          update();
          _isLoading.value = false;
        },
      );
    } catch (e) {
      _isLoading.value = false;
      AppToast.error('Failed to save profile image');
    }
  }

  Future<void> removeImage() async {
    BottomSheetHelper.showImageProcessingLoader(
      onComplete: () {
        _profileImage.value = null;
        Storage.removeProfileImage();
        update();
        AppToast.info('Profile picture removed');
      },
    );
  }

  // Load from storage
  void _loadFromStorage() async {
    _userName.value = await Storage.name;
    _email.value = await Storage.email;
    
    // Load profile image
    final imagePath = await Storage.getProfileImagePath();
    if (imagePath != null && File(imagePath).existsSync()) {
      _profileImage.value = File(imagePath);
    }
    
    update();
  }

  void updateUserName(String name) {
    BottomSheetHelper.showProfileUpdateLoader(
      onComplete: () {
        _userName.value = name;
        Storage.setName(name);
        update();
        AppToast.success('Profile updated successfully');
      },
    );
  }

  void updateEmail(String newEmail) {
    BottomSheetHelper.showProfileUpdateLoader(
      onComplete: () {
        _email.value = newEmail;
        Storage.setEmail(newEmail);
        update();
        AppToast.success('Email updated successfully');
      },
    );
  }

  void toggleDarkMode(bool value) {
    _isDarkMode.value = value;
    update();
  }

  void updateLanguage(String newLanguage) {
    _language.value = newLanguage;
    update();
    AppToast.info('Language changed to $newLanguage');
  }

  void toggleNotifications(bool value) {
    _notificationsEnabled.value = value;
    update();
    AppToast.info(value ? 'Notifications enabled' : 'Notifications disabled');
  }

  void logout() {
    BottomSheetHelper.showLogoutSheet(
      onLogout: _performLogout,
    );
  }

  void _performLogout() {
    // Show logout loader
    BottomSheetHelper.showLogoutLoader(
      onLogout: () {
        // Clear profile data
        _profileImage.value = null;
        
        // Clear storage and navigate to auth
        Storage.clearUserData();
        
        // Navigate to auth screen
        Get.offAllNamed(AppLinks.auth);
        
        AppToast.success('Logged out successfully');
      },
    );
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


// // Update Phone
// BottomSheetHelper.showPhoneUpdateSheet(
//   currentPhone: controller.phone,
//   currentCountryCode: controller.countryCode,
//   onUpdate: (newPhone, countryCode) {
//     controller.updatePhone(newPhone, countryCode);
//   },
// );

// // Update Gender
// BottomSheetHelper.showGenderUpdateSheet(
//   currentGender: controller.gender,
//   onUpdate: (newGender) {
//     controller.updateGender(newGender);
//   },
// );

// // Update Country
// BottomSheetHelper.showCountryUpdateSheet(
//   currentCountry: controller.country,
//   currentCountryCode: controller.countryCode,
//   onUpdate: (newCountry, countryCode) {
//     controller.updateCountry(newCountry, countryCode);
//   },
// );