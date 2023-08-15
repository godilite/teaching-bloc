import 'package:teaching_bloc/src/movies/domain/models/movie_model.dart';
import 'package:teaching_bloc/src/movies/domain/repository/movie_repository.dart';

class FetchMoviesUseCase {
  final MovieRepository movieRepository;

  FetchMoviesUseCase(this.movieRepository);

  Future<List<MovieModel>> execute() async {
    final movies = await movieRepository.fetchAllMovies();
    movies.sort();
    return movies;
  }
}
