import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wave/app/modules/permissions_service.dart';

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
