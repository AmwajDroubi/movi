import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movi/block/home_cubit/home_movi_state.dart';
import 'package:movi/services/catch.dart';
import 'package:movi/utils/app_constant.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final catchServices = CatchServices();
  final Map<String, bool> _favoriteMovies = {};

  Future<void> fetchPopularMovies() async {
    emit(HomeListLoading());
    try {
      final response = await http.get(Uri.parse(
          '${AppConstants.baseUrl}/movie/popular?api_key=${AppConstants.moviApiKey}&language=ar&page=1'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final movies = data['results'];
        emit(HomeListLoaded(movies.take(6).toList()));
      } else {
        throw Exception('فشل تحميل الأفلام');
      }
    } catch (e) {
      emit(HomeListError(e.toString()));
    }
  }

  Future<void> fetchAllPopularMovies() async {
    emit(HomeListLoading());
    try {
      final response = await http.get(Uri.parse(
          '${AppConstants.baseUrl}/movie/popular?api_key=${AppConstants.moviApiKey}&language=ar&page=1'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final movies = data['results'];
        emit(HomeListLoaded(movies));
      } else {
        throw Exception('فشل تحميل الأفلام');
      }
    } catch (e) {
      emit(HomeListError(e.toString()));
    }
  }

  Future<void> topRatedMovies() async {
    emit(HomeListLoading());
    try {
      final response = await http.get(Uri.parse(
          '${AppConstants.baseUrl}/movie/top_rated?api_key=${AppConstants.moviApiKey}&language=ar&page=1'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final movies = data['results'];
        emit(HomeListLoaded(
            movies.take(6).toList())); // تحديث الحالة مع البيانات
      } else {
        throw Exception('فشل تحميل الأفلام');
      }
    } catch (e) {
      emit(HomeListError(e.toString())); // في حال حدوث خطأ
    }
  }

  Future<void> fetchAllTopRatedMovies() async {
    emit(HomeListLoading());
    try {
      final response = await http.get(Uri.parse(
          '${AppConstants.baseUrl}/movie/top_rated?api_key=${AppConstants.moviApiKey}&language=ar&page=1'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final movies = data['results'];
        emit(HomeListLoaded(movies));
      } else {
        throw Exception('فشل تحميل الأفلام');
      }
    } catch (e) {
      emit(HomeListError(e.toString()));
    }
  }

  Future<void> setFavorite(Map<String, dynamic> moviItem) async {
    emit(HomeFavoriteLoading(moviItem['title']));
    try {
      final prefs = await SharedPreferences.getInstance();
      final movieKey = 'favorite_${moviItem['title']}';

      final isFavorite = prefs.getBool(movieKey) ?? false;

      if (isFavorite) {
        await prefs.remove(movieKey);
        moviItem['isFavorite'] = false;
      } else {
        await prefs.setBool(movieKey, true);
        moviItem['isFavorite'] = true;
      }

      emit(HomeFavoriteLoaded(moviItem['title'], moviItem['isFavorite']));
    } catch (e) {
      emit(HomeFavoriteError(message: e.toString()));
    }
  }
}
