import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movi/utils/app_constant.dart';

/// تعريف الحالات
abstract class TrailerState {}

class TrailerInitial extends TrailerState {}

class TrailerLoading extends TrailerState {}

class TrailerLoaded extends TrailerState {
  final String videoKey;
  TrailerLoaded(this.videoKey);
}

class TrailerError extends TrailerState {
  final String errorMessage;
  TrailerError(this.errorMessage);
}