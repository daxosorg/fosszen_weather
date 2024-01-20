import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService {
  Future<List<String>> getFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('favorites') ?? [];
  }

  Future<void> addFavorite(String location) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites') ?? [];
    favorites.add(location);
    await prefs.setStringList('favorites', favorites);
  }
}
