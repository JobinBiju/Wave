import 'dart:async';
import 'package:get/get.dart';
import 'package:wave/app/data/services/permissions_service.dart';

class SplashScreenController extends GetxController {
  Permissions perm = Permissions();
  @override
  void onInit() {
    super.onInit();
    perm.getPermission();
    Timer(
      Duration(milliseconds: 3000),
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
