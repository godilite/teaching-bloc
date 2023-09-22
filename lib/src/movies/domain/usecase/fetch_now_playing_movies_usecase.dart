import 'package:teaching_bloc/src/movies/domain/models/movie_model.dart';
import 'package:teaching_bloc/src/movies/domain/repository/now_playing_movie_repository.dart';

class FetchNowPlayingMovieRepositoryUsecase{
  final NowPlayingMovieRepository nowPlayingMovieRepository;

  FetchNowPlayingMovieRepositoryUsecase(this.nowPlayingMovieRepository);

  Future<List<MovieModel>> execute() async{
    final nowPlayingMovies = await nowPlayingMovieRepository.fetchNowPlayingMovies();
    return nowPlayingMovies;
  }
}