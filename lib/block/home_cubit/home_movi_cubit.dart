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

  // Future<void> fetchHomeCarouselData() async {
  //   try {
  //     emit(HomeCarouselLoading()); // تحديث الحالة إلى Loading

  //     // جلب البيانات من API مباشرة هنا
  //     final response = await http.get(Uri.parse(AppConstants.moviApiKey));

  //     if (response.statusCode == 200) {
  //       // إذا كانت الاستجابة ناجحة، قم بتحليل البيانات
  //       final data = json.decode(response.body);
  //       final movies = data['results'];

  //       // تغيير الحالة إلى HomeCarouselLoaded عند تحميل البيانات بنجاح
  //       emit(HomeCarouselLoaded(movies));
  //     } else {
  //       // إذا فشل التحميل، نقوم بتغيير الحالة إلى HomeCarouselError
  //       emit(HomeCarouselError('Failed to load movies'));
  //     }
  //   } catch (e) {
  //     // في حال حدوث أي استثناء أثناء عملية التحميل
  //     emit(HomeCarouselError(e.toString()));
  //   }
  // }

  // Future<void> fetchMovieData() async {
  //   try {
  //     final response = await http.get(Uri.parse(
  //         'https://api.themoviedb.org/3/discover/movie?api_key=${AppConstants.moviApiKey}'));

  //     if (response.statusCode == 200) {
  //       // طباعة الاستجابة للتحقق من البيانات
  //       final data = json.decode(response.body);
  //       print('Response Data: $data'); // طباعة البيانات لفحص الاستجابة

  //       // تحقق من أن البيانات تحتوي على المفتاح 'results'
  //       final movies =
  //           data['results'] ?? []; // إذا كانت النتائج null استخدم قائمة فارغة
  //       if (movies.isEmpty) {
  //         emit(HomeListError("لا توجد أفلام في البيانات"));
  //       } else {
  //         emit(HomeListLoaded(movies)); // إرسال الأفلام
  //       }
  //     } else {
  //       throw Exception('فشل تحميل البيانات: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     emit(HomeListError(e.toString())); // في حال حدوث خطأ
  //   }
  // }



Future<void> setFavorite(Map<String, dynamic> moviItem) async {
  emit(HomeFavoriteLoading(moviItem['title']));
  try {
    final prefs = await SharedPreferences.getInstance(); // الحصول على SharedPreferences
    final movieKey = 'favorite_${moviItem['title']}';

    // إذا كانت المفضلة موجودة بالفعل
    final isFavorite = prefs.getBool(movieKey) ?? false;

    if (isFavorite) {
      await prefs.remove(movieKey);  // إزالة المفضلة
      moviItem['isFavorite'] = false;
    } else {
      await prefs.setBool(movieKey, true);  // إضافة المفضلة
      moviItem['isFavorite'] = true;
    }

    emit(HomeFavoriteLoaded(moviItem['title'], moviItem['isFavorite']));
  } catch (e) {
    emit(HomeFavoriteError(message: e.toString()));
  }
}




  // Future<void> addFavorite(Movie movie) async {
  //   _favoriteMovies[movie.title!] = true; // إضافة الفيلم إلى المفضلة
  //   emit(HomeFavoriteLoaded(movie.title!, true)); // تحديث الحالة
  // }

  // // دالة لإزالة الفيلم من المفضلة
  // Future<void> removeFavorite(Movie movie) async {
  //   _favoriteMovies[movie.title!] = false; // إزالة الفيلم من المفضلة
  //   emit(HomeFavoriteLoaded(movie.title!, false)); // تحديث الحالة
  // }

  // // دالة لاسترجاع حالة المفضلة
  // bool isFavorite(Movie movie) {
  //   return _favoriteMovies[movie.title!] ?? false;
  // }
}
