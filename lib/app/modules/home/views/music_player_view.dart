import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wave/app/modules/home/controllers/home_controller.dart';

class MusicPlayerView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MusicPlayerView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'MusicPlayerView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
