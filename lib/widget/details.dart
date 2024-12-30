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

  List actors = []; // قائمة لتخزين الممثلين

  @override
  void initState() {
    super.initState();
    fetchMovieDetails();
  }

  // دالة لتحميل تفاصيل الفيلم والممثلين
  Future<void> fetchMovieDetails() async {
    final movieId = widget.movie['id']; // الحصول على معرّف الفيلم
    final apiKey = AppConstants.moviApiKey;
    final url = Uri.parse(
        'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey&language=ar'); // استدعاء API للحصول على الممثلين

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        actors = data['cast']; // استلام قائمة الممثلين
      });

      // ترتيب الممثلين حسب الشعبية (popularity) بشكل تنازلي واختيار 5 أشهر ممثلين فقط
      actors.sort((a, b) {
        return (b['popularity'] ?? 0)
            .compareTo(a['popularity'] ?? 0); // ترتيب الممثلين حسب الشعبية
      });

      // تحديد أول 5 ممثلين فقط
      actors = actors.take(5).toList();
    } else {
      print('فشل في تحميل الممثلين: ${response.statusCode}');
    }
  }

  // دالة لتحويل genre_ids إلى أسماء الأنواع
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
    final size = MediaQuery.of(context).size;
    final movie = widget.movie;

    // استخراج genre_ids
    List<dynamic> genreIds = movie['genre_ids'] ?? [];
    String movieGenres =
        getGenres(genreIds); // تحويل genre_ids إلى أسماء الأنواع

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
                    height: 300,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Positioned(
                    top: 20,
                    left: 10,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.arrow_back),
                      color: Colors.blue,
                      iconSize: 30,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                movie['title'] ?? 'العنوان غير متوفر',
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Trirong",
                    color: Colors.grey),
              ),
              Container(
                height: 60,
                width: 300,
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
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        movie['release_date'] ?? 'التاريخ غير متوفر',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                height: 60,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[600],
                ),
                child: Center(
                  child: Text(
                    movieGenres ?? 'النوع غير متوفر',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "  Overview",
                    style: TextStyle(fontSize: 28, color: Colors.grey),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          movie['overview'] ?? 'الوصف غير متوفر',
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // إضافة قسم الممثلين
              SizedBox(height: 7),
              Text(
                'أشهر الممثلين',
                style: TextStyle(fontSize: 28, color: Colors.grey),
              ),
              SizedBox(height: 10),
              actors.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                      height: 150,
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
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Container(
                                        height: 150,
                                        width: 100,
                                        color: Colors.grey,
                                        child: Icon(Icons.person),
                                      ),
                                SizedBox(height: 8),
                                Text(
                                  actor['name'] ?? 'غير معروف',
                                  style: TextStyle(fontSize: 16),
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
