import 'dart:async';

import 'package:get/get.dart';

class SplashScreenController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    Timer(
      Duration(milliseconds: 4000),
          () => Get.offNamed('/home'),
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
