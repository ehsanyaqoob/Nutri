import 'dart:async';
import 'package:nutri/Screens/on-board.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  RxBool isTime = false.obs;
  RxBool showProgress = false.obs;
  RxDouble progressValue = 0.0.obs;
  @override
  void onInit() {
    super.onInit();
    startSplashSequence();
  }
  void startSplashSequence() {
    Future.delayed(const Duration(seconds: 2), () {
      isTime.value = true;
      showProgress.value = true;
      startProgressAnimation();
    });
  }
  void startProgressAnimation() {
    const totalDuration = Duration(seconds: 2);
    const interval = Duration(milliseconds: 16); 
    var elapsed = Duration.zero;
    Timer.periodic(interval, (timer) {
      elapsed += interval;

      if (elapsed >= totalDuration) {
        timer.cancel();
        progressValue.value = 1.0;
    navigateToNextScreen();
      } else {
        progressValue.value =
            elapsed.inMilliseconds / totalDuration.inMilliseconds;
      }
    });
  }

  void navigateToNextScreen() {
    Get.to(
      OnBoardingView(),
      transition: Transition.circularReveal,
      duration: const Duration(milliseconds: 500),
    );
  }
}
