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
  };

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    final url = Uri.parse(
        '$apiUrl?api_key=$apiKey&language=ar&with_genres=$selectedGenre&page=1');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        movies = data['results'];
      });
    } else {
      print('Failed to load movies: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      // appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: Navigator.of(context).pop,
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
                                fetchMovies();
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
                    ? Center(child: CircularProgressIndicator())
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
