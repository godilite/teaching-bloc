import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teaching_bloc/src/di/base_module.dart';
import 'package:teaching_bloc/src/movies/presentation/bloc/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:teaching_bloc/src/movies/presentation/view/movie_page.dart';
import 'package:teaching_bloc/src/network/base_api_client.dart';
import 'package:teaching_bloc/src/movies/data/repository/top_rated_movie_respository.dart';
import 'package:teaching_bloc/src/movies/domain/usecase/fetch_top_rated_usecase.dart';
import 'package:teaching_bloc/src/movies/presentation/bloc/top_rated_movie/top_rated_movie_event.dart';
import 'package:teaching_bloc/src/movies/presentation/bloc/top_rated_movie/top_rated_movie_state.dart';

class TopRatedMovie extends StatelessWidget {
  const TopRatedMovie({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TopRatedMovieBloc(
        FetchTopRatedMoviesUsecase(
          TopRatedMovieRepositoryImpl(getIt<ApiClient>()),
        ),
      )..add(
          Initialized(),
        ),
      child: BlocBuilder<TopRatedMovieBloc, TopRatedMovieState>(
          builder: (context, state) {
        return switch (state) {
          FetchError() => const Center(
              child: Text('Something has gone wrong'),
            ),
          Fetching() => const Center(
              child: CircularProgressIndicator(),
            ),
          Loaded(topRatedMovies: var data) => data.isEmpty
              ? const NoMovieWidget()
              : ExpansionTile(
                  title: const Text('Top Rated Movies'),
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
                        })
                  ],
                )
        };
      }),
    );
  }
}
