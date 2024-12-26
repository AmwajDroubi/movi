// movi_slider_cubit.dart
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movi/block/sldider_cubit/movi_slider_state.dart';
import 'package:movi/utils/app_constant.dart'; 

class MovieCubit extends Cubit<MovieState> {
  MovieCubit() : super(MovieInitial()); 

  Future<void> fetchUpcomingMovies() async {
    emit(MovieLoading()); 

    final String apiKey = AppConstants.moviApiKey; 
    final String url =
        'https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey&language=ar-SA&page=1';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final movies = data['results'];
        emit(MovieLoaded(
            movies)); 
      } else {
        throw Exception('فشل تحميل الأفلام');
      }
    } catch (e) {
      emit(MovieError(e.toString())); 
    }
  }
}
