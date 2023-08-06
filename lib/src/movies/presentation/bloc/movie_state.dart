import 'package:equatable/equatable.dart';
import 'package:teaching_bloc/src/movies/domain/models/movie_model.dart';

sealed class MovieState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Fetching extends MovieState {}

class Loaded extends MovieState {
  final List<MovieModel> movies;

  Loaded(this.movies);

  @override
  List<Object?> get props => [movies];
}

class FetchError extends MovieState {}
