import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teaching_bloc/src/di/base_module.dart';
import 'package:teaching_bloc/src/movies/data/repository/movie_repository.dart';
import 'package:teaching_bloc/src/movies/domain/usecase/fetch_all_movies_use_case.dart';
import 'package:teaching_bloc/src/movies/presentation/bloc/movie_bloc.dart';
import 'package:teaching_bloc/src/movies/presentation/bloc/movie_event.dart';
import 'package:teaching_bloc/src/movies/presentation/bloc/movie_state.dart';
import 'package:teaching_bloc/src/network/base_api_client.dart';
import 'package:teaching_bloc/src/movies/presentation/widgets/search_field.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => MovieBloc(
              FetchMoviesUseCase(
                MovieRepositoryImpl(getIt<ApiClient>()),
              ),
            )..add(
                Intialized(),
              ),
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "What do you want to watch?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          body: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                SearchField(),
                SizedBox(
                  height: 10,
                ),
                ExpandedMovie(
                  title: Text("What's popular"),
                ),
                SizedBox(
                  height: 10,
                ),
                ExpandedMovie(
                  title: Text("Now Playing"),
                ),
                SizedBox(
                  height: 10,
                ),
                ExpandedMovie(
                  title: Text("Top Rated"),
                ),
                SizedBox(
                  height: 10,
                ),
                ExpandedMovie(
                  title: Text("Upcoming"),
                )
              ],
            ),
          ),
        ));
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


class ExpandedMovie extends StatelessWidget {
  const ExpandedMovie({super.key, required this.title});

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        return switch (state) {
          FetchError() => const Center(
              child: Text('Something has gone wrong'),
            ),
          Fetching() => const Center(
              child: CircularProgressIndicator(),
            ),
          Loaded(movies: var data) => data.isEmpty
              ? const NoMovieWidget()
              : ExpansionTile(
                  title: title,
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
      },
    );
  }
}
