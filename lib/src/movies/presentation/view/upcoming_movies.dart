import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teaching_bloc/src/di/base_module.dart';
import 'package:teaching_bloc/src/movies/presentation/bloc/upcoming_movie/upcoming_movie_bloc.dart';
import 'package:teaching_bloc/src/movies/presentation/view/movie_page.dart';
import 'package:teaching_bloc/src/network/base_api_client.dart';
import 'package:teaching_bloc/src/movies/data/repository/upcoming_movie_repository.dart';
import 'package:teaching_bloc/src/movies/domain/usecase/fetch_upcoming_movies_usecase.dart';
import 'package:teaching_bloc/src/movies/presentation/bloc/upcoming_movie/upcoming_movie_event.dart';
import 'package:teaching_bloc/src/movies/presentation/bloc/upcoming_movie/upcoming_movie_state.dart';

class UpcomingMovies extends StatelessWidget {
  const UpcomingMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpcomingMovieBloc(
        FetchUpcomingMoviesUsecase(
          UpcomingMovieRepositoryImpl(getIt<ApiClient>()),
        ),
      )..add(
          Initialized(),
        ),
      child: BlocBuilder<UpcomingMovieBloc, UpcomingMovieState>(
          builder: (context, state) {
        return switch (state) {
          FetchError() => const Center(
              child: Text('Something has gone wrong'),
            ),
          Fetching() => const Center(
              child: CircularProgressIndicator(),
            ),
          Loaded(upcomingMovies: var data) => data.isEmpty
              ? const NoMovieWidget()
              : ExpansionTile(
                  title: const Text('Upcoming movies'),
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
                    ),
                  ],
                ),
        };
      }),
    );
  }
}
