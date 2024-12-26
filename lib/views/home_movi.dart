import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movi/block/home_cubit/home_movi_cubit.dart';
import 'package:movi/block/sldider_cubit/movi_slider_cubit.dart';
import 'package:movi/views/giner.dart';
import 'package:movi/views/language.dart';
import 'package:movi/views/popular_movies.dart.dart';
import 'package:movi/views/soon_movies.dart';
import 'package:movi/views/toprated_movies.dart';
import 'package:movi/widget/search.dart';

class HomeBasic extends StatelessWidget {
  const HomeBasic({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);

    return Scaffold(
        drawer: Drawer(
          child: SafeArea(
              child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text("jkhj"),
            ],
          )),
        ),
        backgroundColor: Colors.grey[100],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: AppBar(
            backgroundColor: Colors.grey[200],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            title: Row(
              children: [
                Text(" Pop Movies"),
                Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SearchPage()));
                  },
                  icon: Icon(Icons.search),
                ),
              ],
            ),
            centerTitle: true,
            titleTextStyle: TextStyle(
                fontSize: 45,
                color: Colors.blue,
                fontFamily: "Trirong",
                fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
              child: Column(children: [
            const SizedBox(height: 10),
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MovieGenreScreen()));
                    },
                    child: Text(
                      "اضغط هنا",
                      style: TextStyle(color: Colors.blue, fontSize: 18),
                    ),
                  ),
                  Text(
                    "اذا كنت ترغب في اختيار نوع فلمك المفضل",
                    style: TextStyle(fontSize: 18, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MovieLanguageScreen()));
                    },
                    child: Text(
                      "اضغط هنا",
                      style: TextStyle(color: Colors.blue, fontSize: 18),
                    ),
                  ),
                  Text(
                    "اذا كنت ترغب في اختيار لغة فلمك المفضل",
                    style: TextStyle(fontSize: 18, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 290,
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
              height: 340,
              width: 1000,
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
              height: 340,
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
