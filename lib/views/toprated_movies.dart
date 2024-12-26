import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movi/block/home_cubit/home_movi_cubit.dart';
import 'package:movi/block/home_cubit/home_movi_state.dart';
import 'package:movi/widget/all_top.dart';

class TopRatedMovies extends StatelessWidget {
  const TopRatedMovies({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text('Top Rated Movies',
                  style: TextStyle(
                      fontSize: 28,
                      fontFamily: "PlayfairDisplay",
                      color: Colors.blue[700])),
              Spacer(),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AllTop(),
                    ));
                  },
                  child: Text(
                    "See all",
                    style: TextStyle(color: Colors.grey[600], fontSize: 17),
                  ))
            ],
          ),
        ),
        const SizedBox(height: 9),
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
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movieList.length,
                  itemBuilder: (context, index) {
                    final movieItem = movieList[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        // width: 110,
                        child: Column(
                          children: [
                            movieItem["poster_path"] != null
                                ? Image.network(
                                    'https://image.tmdb.org/t/p/w500${movieItem['poster_path']}',
                                    width: 120,
                                    //  height: 140,
                                    fit: BoxFit.cover,
                                  )
                                : Icon(Icons.movie),
                            SizedBox(height: 10),
                            Text(
                              movieItem['title'] ?? 'عنوان غير متوفر',
                              style: TextStyle(
                                  fontSize: 16.5, color: Colors.grey[600]),
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
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
