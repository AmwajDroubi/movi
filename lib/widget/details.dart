//*_*

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movi/utils/app_constant.dart';

class MovieDetailsPage extends StatefulWidget {
  final dynamic movie;

  MovieDetailsPage({super.key, required this.movie});

  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  final Map<int, String> genres = {
    28: "الأكشن",
    10749: "الرومنسي",
    35: "الكوميديا",
    18: "الدراما",
    80: "الجريمة",
    27: "الرعب",
    878: "الخيال العلمي",
    10752: "الحروب",
  };

  List actors = [];

  @override
  void initState() {
    super.initState();
    fetchMovieDetails();
  }

  Future<void> fetchMovieDetails() async {
    final movieId = widget.movie['id'];
    final apiKey = AppConstants.moviApiKey;
    final url = Uri.parse(
        'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey&language=ar');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        actors = data['cast'];
      });

      actors.sort((a, b) {
        return (b['popularity'] ?? 0).compareTo(a['popularity'] ?? 0);
      });

      actors = actors.take(5).toList();
    } else {
      print('فشل في تحميل الممثلين: ${response.statusCode}');
    }
  }

  String getGenres(List<dynamic> genreIds) {
    List<String> genreNames = [];
    for (var genreId in genreIds) {
      if (genres.containsKey(genreId)) {
        genreNames.add(genres[genreId]!);
      }
    }
    return genreNames.isEmpty ? 'لا يوجد نوع' : genreNames.join(", ");
  }

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    List<dynamic> genreIds = movie['genre_ids'] ?? [];
    String movieGenres = getGenres(genreIds);

    return Scaffold(
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.network(
                    'https://image.tmdb.org/t/p/w500${movie['backdrop_path']}',
                    height: screenHeight * .39,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Positioned(
                    top: screenHeight * .015,
                    left: screenWidth * .015,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.blue,
                      iconSize: 30,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * .01),
              Text(
                movie['title'] ?? 'العنوان غير متوفر',
                style: TextStyle(
                    fontSize: screenWidth * .097,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Trirong",
                    color: Colors.grey),
              ),
              SizedBox(
                height: screenHeight * .01,
              ),
              Container(
                height: screenHeight * .075,
                width: screenWidth * .7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[600],
                ),
                child: Center(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Release :",
                          style: TextStyle(
                              fontSize: screenWidth * .06, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * .02,
                      ),
                      Text(
                        movie['release_date'] ?? 'التاريخ غير متوفر',
                        style: TextStyle(
                            fontSize: screenWidth * .05, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * .013,
              ),
              Container(
                height: screenHeight * .075,
                width: screenWidth * .7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[600],
                ),
                child: Center(
                  child: Text(
                    movieGenres ?? 'النوع غير متوفر',
                    style: TextStyle(
                        fontSize: screenWidth * .06, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * .013,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "  Overview",
                    style: TextStyle(
                        fontSize: screenWidth * .09, color: Colors.grey),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: screenHeight * .3,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          movie['overview'] ?? 'الوصف غير متوفر',
                          style: TextStyle(fontSize: screenWidth * .044),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * .001),
              Text(
                'أشهر الممثلين',
                style:
                    TextStyle(fontSize: screenWidth * .06, color: Colors.grey),
              ),
              SizedBox(height: screenHeight * .001),
              actors.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : Container(
                      height: screenHeight * .19,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: actors.length,
                        itemBuilder: (context, index) {
                          final actor = actors[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                actor['profile_path'] != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          'https://image.tmdb.org/t/p/w500${actor['profile_path']}',
                                          height: screenHeight * .1,
                                          width: screenWidth * .28,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Container(
                                        height: screenHeight * .1,
                                        width: screenWidth * .28,
                                        color: Colors.grey,
                                        child: const Icon(Icons.person),
                                      ),
                                SizedBox(height: screenHeight * .009),
                                Text(
                                  actor['name'] ?? 'غير معروف',
                                  style: TextStyle(
                                    fontSize: screenWidth * .039,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
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
