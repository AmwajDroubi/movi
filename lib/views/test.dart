import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movi/block/vedio_cubit/vedio_cubit.dart';
import 'package:movi/block/vedio_cubit/vedio_state.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailerScreen extends StatelessWidget {
  final int movieId;

  const TrailerScreen({required this.movieId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Trailer'),
      ),
      body: BlocProvider(
        create: (context) => TrailerCubit()..fetchTrailer(movieId),
        child: BlocBuilder<TrailerCubit, TrailerState>(
          builder: (context, state) {
            if (state is TrailerLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TrailerError) {
              return Center(child: Text('Error: ${state.errorMessage}'));
            } else if (state is TrailerLoaded) {
              return YoutubePlayer(
                controller: YoutubePlayerController(
                  initialVideoId: state.videoKey,
                  flags: const YoutubePlayerFlags(
                    autoPlay: true,
                    mute: false,
                  ),
                ),
                showVideoProgressIndicator: true,
              );
            } else {
              return const Center(child: Text('Trailer not available'));
            }
          },
        ),
      ),
    );
  }
}


