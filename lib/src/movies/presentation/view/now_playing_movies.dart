import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teaching_bloc/src/di/base_module.dart';
import 'package:teaching_bloc/src/movies/data/repository/now_playing_movie_repository.dart';
import 'package:teaching_bloc/src/movies/domain/usecase/fetch_now_playing_movies_usecase.dart';
import 'package:teaching_bloc/src/movies/presentation/bloc/now_playing_movie/now_playing_movie_bloc.dart';
import 'package:teaching_bloc/src/movies/presentation/view/movie_page.dart';
import 'package:teaching_bloc/src/network/base_api_client.dart';
import 'package:teaching_bloc/src/movies/presentation/bloc/now_playing_movie/now_playing_movie_event.dart';
import 'package:teaching_bloc/src/movies/presentation/bloc/now_playing_movie/now_playing_movie_state.dart';

class NowPlayingMovie extends StatelessWidget {
  const NowPlayingMovie({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NowPlayingMovieBloc(
        FetchNowPlayingMovieRepositoryUsecase(
          NowPlayingMovieRepositoryImpl(getIt<ApiClient>()),
        ),
      )..add(
          Initialized(),
        ),
      child: BlocBuilder<NowPlayingMovieBloc, NowPlayingMovieState>(
        builder: ((context, state) {
          return switch (state) {
            FetchError() => const Center(
                child: Text('Something has gone wrong'),
              ),
            Fetching() => const Center(
                child: CircularProgressIndicator(),
              ),
            Loaded(nowPlayingMovies: var data) => data.isEmpty
                ? const NoMovieWidget()
                : ExpansionTile(
                    title: const Text('Now Playing'),
                    children: [
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final movie = data[index];

                          return ListTile(
                            title: Text(movie.title),
                            subtitle: Text(movie.overview),
                          );
                        },
                      )
                    ],
                  )
          };
        }),
      ),
    );
  }
}
