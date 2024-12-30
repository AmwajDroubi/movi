//*_*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movi/block/sldider_cubit/movi_slider_cubit.dart';
import 'package:movi/block/sldider_cubit/movi_slider_state.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MovieSliderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Soon Movies',
                      style: TextStyle(
                          fontSize: screenWidth * .07,
                          fontFamily: "PlayfairDisplay",
                          color: Colors.blue[700])),
                ),
                Spacer(),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "See all",
                      style: TextStyle(
                          color: Colors.grey[600], fontSize: screenWidth * .04),
                    ))
              ],
            ),
            BlocBuilder<MovieCubit, MovieState>(
              builder: (context, state) {
                if (state is MovieLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MovieError) {
                  return Center(child: Text(state.message));
                } else if (state is MovieLoaded) {
                  final movies = state.movies;
                  return CarouselSlider.builder(
                    itemCount: movies.length,
                    itemBuilder: (context, index, realIndex) {
                      final movie = movies[index];
                      final String title = movie['title'] ?? 'No title';
                      final String posterPath = movie['poster_path'] ?? '';

                      return Container(
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 5.0,
                              spreadRadius: 2.0,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Image.network(
                                'https://image.tmdb.org/t/p/w500$posterPath',
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                              Container(
                                color: Colors.black54,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 15.0),
                                child: Text(
                                  title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenWidth * .04,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 16 /
                          9, // هذه تعني نسبة العرض الى الارتفاع يعني العرض 16 بالنسبة للارتفاع 9
                      autoPlayInterval: const Duration(seconds: 3),
                      viewportFraction: 0.9,
                    ),
                  );
                }
                return Container(
                  color: Colors.black,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
