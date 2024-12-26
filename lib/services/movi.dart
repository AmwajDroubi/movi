// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' as http;
// import 'package:movi/block/home_cubit/home_movi_cubit.dart';
// import 'package:movi/block/home_cubit/home_movi_state.dart';
// import 'package:movi/model/top_headline_model.dart';

// class MovieService {
//   final String apiKey = '293ec928701d75f792ea0c5bc24c4a5b';
//   final String baseUrl = 'https://api.themoviedb.org/3';

//   // استرجاع قائمة الأفلام الشعبية
//   Future<List<Movie>> fetchPopularMovies() async {
//     final response = await http.get(
//       Uri.parse('$baseUrl/movie/popular?api_key=$apiKey&language=ar&page=1'),
//     );

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       // تحويل البيانات إلى قائمة من كائنات Movie
//       List<Movie> movies = (data['results'] as List).map((movie) => Movie.fromJson(movie)).toList();
//       return movies;
//     } else {
//       throw Exception('فشل تحميل الأفلام');
//     }
//   }
// }