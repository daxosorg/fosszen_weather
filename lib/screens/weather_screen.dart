import 'package:flutter/material.dart';
import 'package:fosszen_weather/screens/favourite_screen.dart';
import 'package:fosszen_weather/services/favorites.dart';
import 'package:fosszen_weather/services/weather_api.dart';
import 'package:fosszen_weather/utils/location_helper.dart';
import 'package:geolocator/geolocator.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Map<String, dynamic> weatherData = {};
  bool isLoading = false;
  FavoritesService favoritesService = FavoritesService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });

                Position? userLocation = await LocationHelper.getCurrentLocation();
                if (userLocation != null) {
                  try {
                    Map<String, dynamic> data = await WeatherApi.getWeather(userLocation);
                    setState(() {
                      weatherData = data;
                      isLoading = false;
                    });
                  } catch (e) {
                    debugPrint('Error fetching weather data: $e');
                    setState(() {
                      isLoading = false;
                    });
                  }
                } else {
                  debugPrint('Location permission denied');
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              child: const Text('Get 7-Day Forecast for Current Location'),
            ),
            const SizedBox(height: 20),
            if (isLoading)
              const CircularProgressIndicator()
            else if (weatherData.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: weatherData['daily'].length,
                  itemBuilder: (context, index) {
                    final dailyData = weatherData['daily'][index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Day ${index + 1}',
                              style: const TextStyle(fontSize: 18),
                            ),
                            const SizedBox(height: 8),
                            Text('Temperature: ${dailyData['temp']['day']} °C'),
                            Text('Weather: ${dailyData['weather'][0]['description']}'),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                Position? userLocation = await LocationHelper.getCurrentLocation();
                if (userLocation != null) {
                  String? cityName = await LocationHelper.getCityName(userLocation);
                  await favoritesService.addFavorite(cityName ?? "Empty City name");
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Location added to favorites')));
                }
              },
              child: const Text('Add to Favorites'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FavoritesScreen()),
                );
              },
              child: const Text('View Favorites'),
            ),
          ],
        ),
      ),
    );
  }
}
