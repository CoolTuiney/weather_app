import 'package:geolocator/geolocator.dart';

import 'package:weather_app/logic/permission_handler.dart';

class LocationPosition {
  Future<Position?> getGeoLocationPosition() async {
    PermissionHandler permissionHandler = PermissionHandler();
    bool isGranted = await permissionHandler.checkPermission();
    if (isGranted) {
      return Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } else {
      return null;
    }
  }
}
