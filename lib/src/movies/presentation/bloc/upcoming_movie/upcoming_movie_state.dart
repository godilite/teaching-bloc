import 'package:equatable/equatable.dart';
import 'package:teaching_bloc/src/movies/domain/models/movie_model.dart';

sealed class UpcomingMovieState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Fetching extends UpcomingMovieState {}

class Loaded extends UpcomingMovieState {
  final List<MovieModel> upcomingMovies;

  Loaded(this.upcomingMovies);

  @override
  List<Object> get props => [upcomingMovies];
}

class FetchError extends UpcomingMovieState {}