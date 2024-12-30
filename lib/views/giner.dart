import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movi/utils/app_constant.dart';

class MovieGenreScreen extends StatefulWidget {
  @override
  _MovieGenreScreenState createState() => _MovieGenreScreenState();
}

class _MovieGenreScreenState extends State<MovieGenreScreen> {
  final String apiKey = AppConstants.moviApiKey;
  final String apiUrl = 'https://api.themoviedb.org/3/discover/movie';
  List movies = [];
  int selectedGenre = 28; // افتراضي: الأكشن
  Map<int, String> genres = {
    28: "الأكشن",
    10749: "الرومنسي",
    35: "الكوميديا",
    18: "الدراما",
    80: "الجريمة",
    27: "الرعب",
    878: "الخيال العلمي",
    10752: "الحروب",
  };

  @override
  void initState() {
    super.initState();
    fetchMovies(); // تحميل الأفلام عند بدء الصفحة
  }

  // دالة لتحميل الأفلام بناءً على النوع المحدد
  Future<void> fetchMovies() async {
    final url = Uri.parse(
      '$apiUrl?api_key=$apiKey&language=ar&with_genres=$selectedGenre&page=1',
    ); // هنا تم إضافة معرّف النوع (selectedGenre)
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("افلام النوع ${genres[selectedGenre]}: ${data['results']}"); // لمراجعة البيانات
      setState(() {
        movies = data['results']; // تحديث قائمة الأفلام
      });
    } else {
      print('فشل في تحميل الأفلام: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // العودة للصفحة السابقة
                      },
                      icon: Icon(Icons.arrow_back)),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 60,
                      width: 330,
                      color: Colors.grey[200],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            DropdownButton<int>(
                              value: selectedGenre,
                              items: genres.keys.map((genreId) {
                                return DropdownMenuItem<int>(
                                  value: genreId,
                                  child: Text(genres[genreId]!),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedGenre = value!;
                                });
                                fetchMovies(); // تحميل الأفلام بناءً على النوع الجديد
                              },
                            ),
                            Spacer(),
                            Text(
                              "اختر نوع فلمك المفضل",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey[500]),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Expanded(
                child: movies.isEmpty
                    ? Center(
                        child: CircularProgressIndicator()) // تحميل الأفلام
                    : ListView.builder(
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          final movie = movies[index];
                          return Card(
                            child: ListTile(
                              leading: Image.network(
                                'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                                height: 120,
                              ),
                              title: Text(
                                movie['title'] ?? 'بدون عنوان',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          );
                        },
                      ),
              ),
              SizedBox(
                height: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}
