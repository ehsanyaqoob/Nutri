import 'package:get/get.dart';
import 'package:nutri/Screens/navbar/navbar_screens/navbar-screen.dart';

class BackPressHandler {
  static Future<bool> handleBackPress() async {
    final NavController navController = Get.find<NavController>();

    // Case 1: If not on home tab → go back to home
    if (navController.currentIndex.value != 0) {
      navController.changeIndex(0);
      return false; // prevent app exit
    }

    // Case 2: If already on home → allow app to close
    return true;
  }
}
