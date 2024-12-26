


import 'package:equatable/equatable.dart';
import 'package:movi/model/top_headline_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeListLoading extends HomeState {}

class HomeListLoaded extends HomeState {
  final List<dynamic> movies;

  HomeListLoaded(this.movies);
}

class HomeListError extends HomeState {
  final String message;

  HomeListError(this.message);
}

final class HomeCarouselLoading extends HomeState {}

final class HomeCarouselLoaded extends HomeState {
  final List<Movie> topMovies;

  HomeCarouselLoaded(this.topMovies);
}

final class HomeCarouselError extends HomeState {
  final String message;

  HomeCarouselError(this.message);
}


class HomeFavoriteLoaded extends HomeState {
  final String movieTitle;
  final bool isFavorite;

  HomeFavoriteLoaded(this.movieTitle, this.isFavorite);
}

class HomeFavoriteError extends HomeState {
  final String message;

  HomeFavoriteError({required this.message});
}

class HomeFavoriteLoading extends HomeState {
  final String movieTitle;

  HomeFavoriteLoading(this.movieTitle);
}
