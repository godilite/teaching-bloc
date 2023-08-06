import 'package:teaching_bloc/src/movies/domain/models/movie_model.dart';

abstract class MovieRepository {
  Future<List<MovieModel>> fetchAllMovies();
}
