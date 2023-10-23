import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teaching_bloc/src/di/base_module.dart';
import 'package:teaching_bloc/src/movies/data/repository/movie_repository.dart';
import 'package:teaching_bloc/src/movies/domain/usecase/fetch_all_movies_use_case.dart';
import 'package:teaching_bloc/src/movies/dto/move_type.dart';
import 'package:teaching_bloc/src/movies/presentation/bloc/movie_bloc.dart';
import 'package:teaching_bloc/src/movies/presentation/bloc/movie_event.dart';
import 'package:teaching_bloc/src/movies/presentation/bloc/movie_state.dart';
import 'package:teaching_bloc/src/network/base_api_client.dart';
import 'package:teaching_bloc/src/movies/presentation/widgets/search_field.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "What do you want to watch?",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SearchField(),
            ...MovieType.values
                .map(
                  (movieType) => Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      BlocProvider(
                        create: (context) => MovieBloc(
                          FetchMoviesUseCase(
                            MovieRepositoryImpl(getIt<ApiClient>()),
                          ),
                          movieType,
                        ),
                        child: ExpandedMovie(
                          isInitiallyExpanded: movieType.index < 2,
                          title: Text(movieType.value),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}

class NoMovieWidget extends StatelessWidget {
  final VoidCallback onRetry;

  const NoMovieWidget({super.key, required this.onRetry});

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
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

class ExpandedMovie extends StatefulWidget {
  final bool isInitiallyExpanded;
  const ExpandedMovie({
    super.key,
    required this.title,
    this.isInitiallyExpanded = false,
  });
  final Widget title;

  @override
  State<ExpandedMovie> createState() => _ExpandedMovieState();
}

class _ExpandedMovieState extends State<ExpandedMovie> {
  @override
  void didChangeDependencies() {
    if (widget.isInitiallyExpanded) {
      context.read<MovieBloc>().add(Intialized());
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: widget.title,
      initiallyExpanded: widget.isInitiallyExpanded,
      onExpansionChanged: (isExpanded) {
        if (isExpanded) {
          context.read<MovieBloc>().add(Intialized());
        }
      },
      children: [
        BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: switch (state) {
              FetchError() => const Center(
                  child: Text('Something has gone wrong'),
                ),
              Fetching() => const Center(
                  child: CircularProgressIndicator(),
                ),
              Loaded(movies: var data) => data.isEmpty
                  ? NoMovieWidget(
                      onRetry: () {
                        context.read<MovieBloc>().add(RetryPressed());
                      },
                    )
                  : ListView.builder(
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
            },
          );
        })
      ],
    );
  }
}
