import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  Future<bool> requestLocationPermission() async {
    var status = await Permission.location.request();
    return status == PermissionStatus.granted;
  }
}
