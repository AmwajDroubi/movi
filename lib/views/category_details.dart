//*_*

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movi/utils/app_constant.dart';
import 'package:movi/widget/details.dart';

class MoviesPage extends StatefulWidget {
  final String selectedLanguage;
  final int selectedGenre;

  MoviesPage({required this.selectedLanguage, required this.selectedGenre});

  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  final String apiKey = AppConstants.moviApiKey;
  final String apiUrl = 'https://api.themoviedb.org/3/discover/movie';

  List movies = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(
      '$apiUrl?api_key=$apiKey&language=${widget.selectedLanguage}&with_genres=${widget.selectedGenre}&page=1',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          movies = data['results'] ?? [];
        });
      } else {
        print('فشل في تحميل الأفلام: ${response.statusCode}');
        setState(() {
          movies = [];
        });
      }
    } catch (e) {
      print('حدث خطأ: $e');
      setState(() {
        movies = [];
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double sliderHeight = screenHeight * 0.30;

    double titleFontSize = screenWidth * 0.05; 
    double subtitleFontSize = screenWidth * 0.04; 

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الأفلام',
          style: TextStyle(
            fontSize: titleFontSize,
            fontFamily: "PlayfairDisplay",
            color: Colors.blue[700],
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Column(
            children: [
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : movies.isEmpty
                      ? Center(child: Text('لا توجد أفلام لعرضها'))
                      : Expanded(
                          child: ListView.builder(
                            itemCount: movies.length,
                            itemBuilder: (context, index) {
                              final movie = movies[index];
                              final posterPath = movie['poster_path'];

                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => MovieDetailsPage(
                                        movie: movie,
                                      ),
                                    ),
                                  );
                                },
                                child: Card(
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  child: ListTile(
                                    leading: posterPath != null
                                        ? Image.network(
                                            'https://image.tmdb.org/t/p/w500$posterPath',
                                            height:
                                                sliderHeight, // استخدام النسبة المئوية للارتفاع
                                            width: screenWidth *
                                                0.25, // عرض الصورة كنسبة مئوية من عرض الشاشة
                                            fit: BoxFit.cover,
                                          )
                                        : Icon(Icons.movie),
                                    title: Text(
                                      movie['title'] ?? 'بدون عنوان',
                                      style: TextStyle(fontSize: titleFontSize),
                                    ),
                                    subtitle: Text(
                                      movie['overview'] ?? 'لا يوجد وصف',
                                      style:
                                          TextStyle(fontSize: subtitleFontSize),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
