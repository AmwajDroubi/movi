//*_*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movi/block/home_cubit/home_movi_cubit.dart';
import 'package:movi/block/sldider_cubit/movi_slider_cubit.dart';
import 'package:movi/views/popular_movies.dart.dart';
import 'package:movi/views/soon_movies.dart';
import 'package:movi/views/toprated_movies.dart';

class HomeBasic extends StatelessWidget {
  const HomeBasic({super.key});
  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
          child: Column(children: [
        SizedBox(height: screenHeight * .01),
        SizedBox(
          height: screenHeight * .33,
          width: double.infinity,
          child: BlocProvider(
            create: (context) {
              final cubit = MovieCubit();
              cubit.fetchUpcomingMovies();
              return cubit;
            },
            child: MovieSliderScreen(),
          ),
        ),
        SizedBox(
          child: BlocProvider(
            create: (context) {
              final cubit = HomeCubit();
              cubit.fetchPopularMovies();
              return cubit;
            },
            child: PopularMovie(),
          ),
        ),
        SizedBox(
          child: BlocProvider(
            create: (context) {
              final cubit = HomeCubit();
              cubit.topRatedMovies();
              return cubit;
            },
            child: TopRatedMovies(),
          ),
        )
      ])),
    ));
  }
}
