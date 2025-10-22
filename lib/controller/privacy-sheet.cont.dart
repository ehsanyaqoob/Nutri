// // Create this new file: privacy_sheet_controller.dart
// import 'package:get/get.dart';

// class PrivacySheetController extends GetxController {
//   // Permission states
//   final cameraPermission = true.obs;
//   final photoPermission = true.obs;
//   final notificationPermission = true.obs;
//   final agreeToTerms = false.obs;

//   void toggleCameraPermission(bool value) {
//     cameraPermission.value = value;
//   }

//   void togglePhotoPermission(bool value) {
//     photoPermission.value = value;
//   }

//   void toggleNotificationPermission(bool value) {
//     notificationPermission.value = value;
//   }

//   void toggleAgreeToTerms(bool value) {
//     agreeToTerms.value = value;
//   }

//   @override
//   void onClose() {
//     Get.delete<PrivacySheetController>();
//     super.onClose();
//   }
// }