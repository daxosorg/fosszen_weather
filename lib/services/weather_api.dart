import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherApi {
  WeatherApi() : apiKey = dotenv.env['OPENWEATHERMAP_API_KEY'] ?? '';
  String apiKey;
  Future<Map<String, dynamic>> getWeather(Position position) async {
    try {
      String apiUrl = 'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey';
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
