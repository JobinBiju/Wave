import 'package:get/get.dart';

import '../controllers/splash_screen_controller.dart';

class SpalshScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashScreenController>(
      () => SplashScreenController(),
    );
  }
}
