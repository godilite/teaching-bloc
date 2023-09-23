import 'package:teaching_bloc/src/movies/domain/models/movie_model.dart';
import 'package:teaching_bloc/src/movies/dto/move_type.dart';

abstract class MovieRepository {
  Future<List<MovieModel>> fetchAllMovies(MovieType movieType);
}
