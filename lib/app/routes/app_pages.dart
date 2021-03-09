import 'package:get/get.dart';

import 'package:wave/app/modules/home/bindings/home_binding.dart';
import 'package:wave/app/modules/home/views/home_view.dart';
import 'package:wave/app/modules/spalsh_screen/bindings/splash_screen_binding.dart';
import 'package:wave/app/modules/spalsh_screen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPALSH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPALSH_SCREEN,
      page: () => SplashScreenView(),
      binding: SpalshScreenBinding(),
    ),
  ];
}
