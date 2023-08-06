import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teaching_bloc/src/movies/data/repository/movie_repository.dart';
import 'package:teaching_bloc/src/movies/domain/usecase/fetch_all_movies_use_case.dart';
import 'package:teaching_bloc/src/movies/presentation/bloc/movie_bloc.dart';
import 'package:teaching_bloc/src/movies/presentation/bloc/movie_event.dart';
import 'package:teaching_bloc/src/movies/presentation/bloc/movie_state.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieBloc(
        FetchMoviesUseCase(
          MovieRepositoryImpl(),
        ),
      )..add(Intialized()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Movies'),
        ),
        body: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            return switch (state) {
              FetchError() => const Center(
                  child: Text('Something went wrong!'),
                ),
              Fetching() => const Center(
                  child: CircularProgressIndicator(),
                ),
              Loaded(movies: var data) => data.isEmpty
                  ? const NoMovieWidget()
                  : ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final movie = data[index];

                        return ListTile(
                          title: Text(movie.title),
                          subtitle: Text(movie.overview),
                        );
                      },
                    ),
            };
          },
        ),
      ),
    );
  }
}

class NoMovieWidget extends StatelessWidget {
  const NoMovieWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('No movies found'),
          const Text('Please try again later'),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              context.read<MovieBloc>().add(RetryPressed());
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
