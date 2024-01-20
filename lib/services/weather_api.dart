import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherApi {
  static Future<Map<String, dynamic>> getWeather(Position position) async {
    try {
      String apiUrl =
          'https://api.openweathermap.org/data/2.5/onecall?lat=${position.latitude}&lon=${position.longitude}&exclude=current,minutely,hourly&appid=2e9714911e1deb0a2ee62104c0b5928b';
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        Map<String, dynamic> weatherData = json.decode(response.body);
        return weatherData;
      } else {
        throw Exception('Failed to get WOEID');
      }
    } catch (e) {
      debugPrint('Error getting weather data: $e');
      throw Exception('Failed to get weather data');
    }
  }
}
