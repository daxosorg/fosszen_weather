import 'package:flutter/material.dart';
import 'package:fosszen_weather/services/weather_api.dart';
import 'package:fosszen_weather/utils/location_helper.dart';
import 'package:geolocator/geolocator.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    WeatherApi weatherApi = WeatherApi();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            Position? userLocation = await LocationHelper.getCurrentLocation();
            if (userLocation != null) {
              Map<String, dynamic> weatherData = await weatherApi.getWeather(userLocation);
              debugPrint(weatherData.toString());
            } else {
              debugPrint('Location permission denied');
            }
          },
          child: const Text('Get Weather for Current Location'),
        ),
      ),
    );
  }
}
