import 'package:nutri/constants/export.dart';
class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductController(), fenix: true);
  }
}

class NavBarBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavController(), fenix: true);
    Get.lazyPut(() => ProductController(), fenix: true);
  }
}