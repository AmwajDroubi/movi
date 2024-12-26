import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movi/utils/app_constant.dart';
import 'package:http/http.dart' as http;


import 'vedio_state.dart';

class TrailerCubit extends Cubit<TrailerState> {
  final String apiKey = AppConstants.moviApiKey;

  TrailerCubit() : super(TrailerInitial());

  /// جلب مفتاح الفيديو الدعائي
  Future<void> fetchTrailer(int movieId) async {
    emit(TrailerLoading());
    try {
      final url = Uri.parse(
          'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=$apiKey');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;

        // البحث عن أول فيديو دعائي (Trailer) على YouTube
        final trailer = results.firstWhere(
          (video) => video['site'] == 'YouTube' && video['type'] == 'Trailer',
          orElse: () => null,
        );

        if (trailer != null) {
          emit(TrailerLoaded(trailer['key']));
        } else {
          emit(TrailerError('Trailer not available'));
        }
      } else {
        emit(TrailerError('Failed to fetch trailer, status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(TrailerError('Failed to fetch trailer: $e'));
    }
  }
}