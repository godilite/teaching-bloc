import 'package:teaching_bloc/src/movies/domain/models/movie_model.dart';

abstract class NowPlayingMovieRepository {
  Future<List<MovieModel>> fetchNowPlayingMovies();
}