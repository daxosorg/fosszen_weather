import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationHelper {
  static Future<String?> getCityName(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        return placemarks[0].locality ?? placemarks[0].subAdministrativeArea;
      }
    } catch (e) {
      print('Error getting city name: $e');
    }
    return null;
  }

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
