import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
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
              Neumorphic(
                style: NeumorphicStyle(
                  shape: NeumorphicShape.concave,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                  depth: 20,
                  lightSource: LightSource.topLeft,
                  shadowLightColor: Colors.white30,
                  shadowDarkColor: Colors.black54,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: Container(
                  padding: EdgeInsets.all(20),
                  height: Get.width * 0.4,
                  width: Get.width * 0.4,
                  child: Image(image: AssetImage('assets/appIcon.png')),
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
