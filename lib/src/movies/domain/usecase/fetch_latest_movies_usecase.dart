import 'package:teaching_bloc/src/movies/domain/models/movie_model.dart';
import 'package:teaching_bloc/src/movies/domain/repository/latest_movie_repository.dart';

class FetchLatestMoviesUseCase {
  final LatestMovieRepository latestMovieRepository;

  FetchLatestMoviesUseCase(this.latestMovieRepository);

  Future<List<MovieModel>> execute() async {
    final latestMovies = await latestMovieRepository.fetchLatestMovies();
    return latestMovies;
  }
}
