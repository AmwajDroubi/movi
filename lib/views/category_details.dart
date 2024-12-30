import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movi/utils/app_constant.dart';
import 'package:movi/widget/details.dart'; // تأكد من صحة المسار

class MoviesPage extends StatefulWidget {
  final String selectedLanguage;
  final int selectedGenre;

  MoviesPage({required this.selectedLanguage, required this.selectedGenre});

  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  final String apiKey =
      AppConstants.moviApiKey; // تأكد من أنك تعرف قيمة API Key بشكل صحيح
  final String apiUrl = 'https://api.themoviedb.org/3/discover/movie';

  List movies = [];
  bool isLoading = false; // لعرض مؤشر التحميل أثناء جلب البيانات

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  // دالة لجلب الأفلام بناءً على اللغة والنوع المحدد
  Future<void> fetchMovies() async {
    setState(() {
      isLoading = true; // تفعيل مؤشر التحميل
    });

    final url = Uri.parse(
      '$apiUrl?api_key=$apiKey&language=${widget.selectedLanguage}&with_genres=${widget.selectedGenre}&page=1',
    );

    print('طلب جلب الأفلام من الرابط: $url'); // طباعة الرابط للتحقق منه
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // طباعة الاستجابة للتحقق من البيانات
        print('استجابة API: $data');

        setState(() {
          movies = data['results'] ??
              []; // إذا كانت البيانات فارغة، يتم تعيين قائمة فارغة
        });
      } else {
        print('فشل في تحميل الأفلام: ${response.statusCode}');
        setState(() {
          movies = []; // إذا فشل التحميل، اجعل القائمة فارغة
        });
      }
    } catch (e) {
      print('حدث خطأ: $e');
      setState(() {
        movies = []; // في حالة حدوث استثناء، اجعل القائمة فارغة
      });
    } finally {
      setState(() {
        isLoading = false; // إيقاف مؤشر التحميل بعد تحميل البيانات
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الأفلام',
          style: TextStyle(
              fontSize: 25,
              fontFamily: "PlayfairDisplay",
              color: Colors.blue[700]),
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
                  ? Center(
                      child: CircularProgressIndicator()) // عرض مؤشر التحميل
                  : movies.isEmpty
                      ? Center(
                          child: Text(
                              'لا توجد أفلام لعرضها')) // إذا كانت القائمة فارغة
                      : Expanded(
                          child: ListView.builder(
                            itemCount: movies.length,
                            itemBuilder: (context, index) {
                              final movie = movies[index];

                              // التأكد من وجود الصورة
                              final posterPath = movie['poster_path'];

                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => MovieDetailsPage(
                                            movie: movie,
                                          )));
                                },
                                child: Card(
                                  margin: EdgeInsets.symmetric(vertical: 8),
                                  child: ListTile(
                                    leading: posterPath != null
                                        ? Image.network(
                                            'https://image.tmdb.org/t/p/w500$posterPath',
                                            height: 120,
                                            width: 80,
                                            fit: BoxFit.cover,
                                          )
                                        : Icon(Icons.movie),
                                    title: Text(
                                      movie['title'] ?? 'بدون عنوان',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    subtitle: Text(
                                      movie['overview'] ?? 'لا يوجد وصف',
                                      style: TextStyle(fontSize: 14),
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
