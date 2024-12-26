import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movi/utils/app_constant.dart';

class MovieLanguageScreen extends StatefulWidget {
  @override
  _MovieLanguageScreenState createState() => _MovieLanguageScreenState();
}

class _MovieLanguageScreenState extends State<MovieLanguageScreen> {
  final String apiKey = AppConstants.moviApiKey;
  final String apiUrl = 'https://api.themoviedb.org/3/discover/movie';
  List movies = [];
  String selectedLanguage = 'ar'; // افتراضي: الأفلام العربية
  Map<String, String> languages = {
    'ar': "العربية",
    'en': "الإنجليزية",
    'fr': "الفرنسية",
  };

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    final url = Uri.parse(
        '$apiUrl?api_key=$apiKey&language=ar&with_original_language=$selectedLanguage&page=1');
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
                            DropdownButton<String>(
            value: selectedLanguage,
            items: languages.keys.map((langCode) {
              return DropdownMenuItem<String>(
                value: langCode,
                child: Text(languages[langCode]!),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedLanguage = value!;
              });
              fetchMovies(); // تحديث الأفلام عند اختيار لغة جديدة
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
