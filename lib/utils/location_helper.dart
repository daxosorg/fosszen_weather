import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class LocationHelper {
  static Future<Position?> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
        return await Geolocator.getCurrentPosition();
      } else {
        return null; // Permission denied
      }
    } catch (e) {
      debugPrint('Error getting location: $e');
      return null;
    }
  }
}
