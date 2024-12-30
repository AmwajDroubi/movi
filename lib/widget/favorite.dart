import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Map<String, dynamic>> favoriteMovies = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteMovies();
  }

  // دالة لقراءة الأفلام المفضلة من SharedPreferences
  Future<void> _loadFavoriteMovies() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys(); // قراءة جميع المفاتيح المخزنة
    List<Map<String, dynamic>> favorites = [];

    for (var key in keys) {
      if (key.startsWith('favorite_')) {  // البحث عن المفاتيح التي تتعلق بالأفلام المفضلة
        bool isFavorite = prefs.getBool(key) ?? false;
        if (isFavorite) {
          String movieTitle = key.replaceFirst('favorite_', '');
          favorites.add({'title': movieTitle, 'isFavorite': isFavorite});
        }
      }
    }

    setState(() {
      favoriteMovies = favorites;  // تحديث الحالة بقائمة الأفلام المفضلة
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('المفضلة'),
        centerTitle: true,
      ),
      body: favoriteMovies.isEmpty
          ? Center(child: Text('لا توجد أفلام مفضلة'))
          : ListView.builder(
              itemCount: favoriteMovies.length,
              itemBuilder: (context, index) {
                var movie = favoriteMovies[index];
                return ListTile(
                  title: Text(movie['title']),
                );
              },
            ),
    );
  }
}
