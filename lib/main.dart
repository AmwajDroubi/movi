// import 'package:flutter/material.dart';
// import 'package:movi/views/home_movi.dart';
// import 'package:movi/views/home_slider.dart';
// import 'package:movi/views/test.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: HomeBasic(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movi/block/home_cubit/home_movi_cubit.dart';
import 'package:movi/block/sldider_cubit/movi_slider_cubit.dart';
import 'package:movi/model/top_headline_model.dart';
import 'package:movi/views/first.dart';
import 'package:movi/views/introduction.dart';
import 'package:movi/views/popular_movies.dart.dart';
import 'package:movi/views/home_movi.dart';
import 'package:movi/views/test.dart';
import 'package:movi/views/test2.dart';
import 'package:movi/widget/all_popular.dart';
import 'package:movi/widget/details.dart';

// void main() {
//   runApp(
//     MultiBlocProvider(
//       providers: [
//         BlocProvider(
//             create: (context) =>
//                 MovieCubit()..fetchUpcomingMovies()), // MovieCubit
//         BlocProvider(create: (context) => HomeCubit()), // SearchCubit
//       ],
//       child:
//        MyApp(),
//    ),
//   );
// }

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
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: IntroductionPage());
  }
}
