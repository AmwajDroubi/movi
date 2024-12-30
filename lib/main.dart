import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movi/block/home_cubit/home_movi_cubit.dart';
import 'package:movi/views/introduction.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => HomeCubit()..fetchAllPopularMovies(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: IntroductionPage());
  }
}
