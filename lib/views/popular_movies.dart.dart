//*_*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movi/block/home_cubit/home_movi_cubit.dart';
import 'package:movi/block/home_cubit/home_movi_state.dart';
import 'package:movi/widget/all_popular.dart';

class PopularMovie extends StatelessWidget {
  const PopularMovie({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text('Popular Movies',
                  style: TextStyle(
                      fontSize: screenWidth * .07,
                      fontFamily: "PlayfairDisplay",
                      color: Colors.blue[700])),
              Spacer(),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AllPopular(),
                    ));
                  },
                  child: Text(
                    "See all",
                    style: TextStyle(
                        color: Colors.grey[600], fontSize: screenWidth * .04),
                  ))
            ],
          ),
        ),
        BlocBuilder<HomeCubit, HomeState>(
          bloc: homeCubit,
          buildWhen: (previous, current) =>
              current is HomeListLoaded ||
              current is HomeListError ||
              current is HomeListLoading,
          builder: (context, state) {
            if (state is HomeListLoaded) {
              final movieList = state.movies;
              return SizedBox(
                height: screenHeight * .188,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movieList.length,
                  itemBuilder: (context, index) {
                    final movieItem = movieList[index];
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * .015),
                      child: Container(
                        child: Column(
                          children: [
                            movieItem["poster_path"] != null
                                ? Image.network(
                                    'https://image.tmdb.org/t/p/w500${movieItem['poster_path']}',
                                    width: screenWidth * .27,
                                    height: screenHeight * .147,
                                    fit: BoxFit.cover,
                                  )
                                : Icon(Icons.movie),
                            SizedBox(height: screenHeight * .01),
                            Text(
                              movieItem['title'] ?? 'عنوان غير متوفر',
                              style: TextStyle(
                                  fontSize: screenWidth * .042,
                                  color: Colors.grey[600]),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (state is HomeListLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (state is HomeListError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Container(
                color: Colors.green,
              );
            }
          },
        ),
      ],
    );
  }
}
