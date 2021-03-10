import 'package:get/get.dart';

import '../controllers/music_player_controller.dart';

class MusicPlayerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MusicPlayerController>(
      () => MusicPlayerController(),
    );
  }
}
