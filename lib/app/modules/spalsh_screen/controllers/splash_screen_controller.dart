import 'dart:async';

import 'package:get/get.dart';
import 'package:wave/app/modules/permissions_service.dart';

class SplashScreenController extends GetxController {
  askPermission() {
    PermissionsService().requestStoragePermission(
      onPermissionDenied: () {
        print('Permission has been denied');
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    Timer(
      Duration(milliseconds: 3000),
      () => Get.offNamed('/home'),
    );
  }

  @override
  void onReady() {
    super.onReady();
    askPermission();
  }

  @override
  void onClose() {}
}
