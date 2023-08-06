import 'package:teaching_bloc/src/movies/domain/models/movie_model.dart';
import 'package:teaching_bloc/src/movies/domain/repository/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  @override
  Future<List<MovieModel>> fetchAllMovies() async {
    await Future.delayed(const Duration(seconds: 5));

    return [];
  }
}
