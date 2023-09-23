import 'package:equatable/equatable.dart';
import 'package:teaching_bloc/src/movies/domain/models/movie_model.dart';

sealed class TopRatedMovieState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Fetching extends TopRatedMovieState {}

class Loaded extends TopRatedMovieState {
  final List<MovieModel> topRatedMovies;
  Loaded(this.topRatedMovies);

  @override
  List<Object?> get props => [topRatedMovies];
}

class FetchError extends TopRatedMovieState {}
