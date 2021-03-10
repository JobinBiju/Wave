import 'package:flutter/material.dart';

import 'package:get/get.dart';
//import 'package:wave/app/theme/color_theme.dart';
import 'package:wave/app/theme/text_theme.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GetBuilder<SplashScreenController>(builder: (_) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: Get.width * 0.4,
                width: Get.width * 0.4,
                child: Image(image: AssetImage('assets/appIcon.png')),
                decoration: BoxDecoration(
                  boxShadow: [kDefaultShadow],
                ),
              ),
              SizedBox(
                height: 100.0,
              ),
              // Text(
              //   'Wave',
              //   style: kHeadTextStyle.copyWith(
              //     color: primaryRed,
              //   ),
              // ),
            ],
          );
        }),
      ),
    );
  }
}
