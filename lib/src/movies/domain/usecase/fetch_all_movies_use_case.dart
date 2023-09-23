import 'package:teaching_bloc/src/movies/domain/models/movie_model.dart';
import 'package:teaching_bloc/src/movies/domain/repository/movie_repository.dart';
import 'package:teaching_bloc/src/movies/dto/move_type.dart';

class FetchMoviesUseCase {
  final MovieRepository movieRepository;

  FetchMoviesUseCase(this.movieRepository);

  Future<List<MovieModel>> execute(MovieType movieType) {
    return movieRepository.fetchAllMovies(movieType);
  }
}
