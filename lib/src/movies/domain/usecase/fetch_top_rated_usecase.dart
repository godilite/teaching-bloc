import 'package:teaching_bloc/src/movies/domain/models/movie_model.dart';
import 'package:teaching_bloc/src/movies/domain/repository/top_rated_movie_repository.dart';

class FetchTopRatesMoviesUsecase {
  final TopRatedMovieRepository topRatedMovieRepository;

  FetchTopRatesMoviesUsecase(this.topRatedMovieRepository);

  Future<List<MovieModel>> execute() async {
    final topRatedMovies = await topRatedMovieRepository.fetchTopRatedMovies();
    return topRatedMovies;
  }
}
