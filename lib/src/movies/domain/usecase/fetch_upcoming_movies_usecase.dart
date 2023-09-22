import 'package:teaching_bloc/src/movies/domain/models/movie_model.dart';
import 'package:teaching_bloc/src/movies/domain/repository/upcoming_movies_repository.dart';

class FetchUpcomingMoviesUsecase{
  final UpcomingMovieRepository upcomingMovieRepository;

  FetchUpcomingMoviesUsecase(this.upcomingMovieRepository);

  Future<List<MovieModel>> execute() async{
    final upcomingMovies = await upcomingMovieRepository.fetchUpcomingMovies();
    return upcomingMovies;
  }
}