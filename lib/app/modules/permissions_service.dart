import 'dart:async';

import 'package:get/get.dart';
import 'package:permissions_plugin/permissions_plugin.dart';

class Permissions {
  Future<void> getPermission() async {
    Map<Permission, PermissionState> permission =
        await PermissionsPlugin.requestPermissions([
      Permission.ACCESS_FINE_LOCATION,
      Permission.READ_EXTERNAL_STORAGE,
      Permission.WRITE_EXTERNAL_STORAGE
    ]);
  }
}
