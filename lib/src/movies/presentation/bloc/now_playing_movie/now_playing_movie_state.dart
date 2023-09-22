import 'package:equatable/equatable.dart';
import 'package:teaching_bloc/src/movies/domain/models/movie_model.dart';

sealed class NowPlayingMovieState extends Equatable{
  @override
  List<Object?> get props => [];
}

class Fetching extends NowPlayingMovieState{}

class Loaded extends NowPlayingMovieState{
  final List<MovieModel> movies;

  Loaded(this.movies);
  @override
  List<Object?> get props => [movies];
}

class FetchError extends NowPlayingMovieState{}