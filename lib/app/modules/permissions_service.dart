import 'package:permission_handler/permission_handler.dart';

class PermissionsService {
  final PermissionHandler permissionHandler = PermissionHandler();

  Future<bool> _requestPermission(PermissionGroup permission) async {
    var result = await permissionHandler.requestPermissions([permission]);
    if (result[permission] == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  Future<bool> requestStoragePermission({Function onPermissionDenied}) async {
    var granted = await _requestPermission(PermissionGroup.storage);
    if (!granted) {
      onPermissionDenied();
    }
    return granted;
  }

  Future<bool> hasContactsPermission() async {
    return hasPermission(PermissionGroup.storage);
  }

  Future<bool> hasPermission(PermissionGroup permission) async {
    var permissionStatus =
        await permissionHandler.checkPermissionStatus(permission);
    return permissionStatus == PermissionStatus.granted;
  }
}
