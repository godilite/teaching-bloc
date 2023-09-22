import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teaching_bloc/src/movies/domain/usecase/fetch_upcoming_movies_usecase.dart';
import 'package:teaching_bloc/src/movies/presentation/bloc/upcoming_movie/upcoming_movie_event.dart';
import 'package:teaching_bloc/src/movies/presentation/bloc/upcoming_movie/upcoming_movie_state.dart';

class UpcomingMovieBloc extends Bloc<UpcomingMovieEvent, UpcomingMovieState> {
  final FetchUpcomingMoviesUsecase fetchUpcomingMoviesUsecase;

  UpcomingMovieBloc(this.fetchUpcomingMoviesUsecase) : super(Fetching()) {
    on<Initialized>(_onInitilized);
    on<RetryPressed>(_onRetryPressed);
  }

  void _onInitilized(
      Initialized event, Emitter<UpcomingMovieState> emit) async {
    emit(Fetching());

    try {
      final upcomingMovies = await fetchUpcomingMoviesUsecase.execute();
      emit(Loaded(upcomingMovies));
    } catch (_) {
      emit(FetchError());
    }
  }

  void _onRetryPressed(
      RetryPressed event, Emitter<UpcomingMovieState> emit) async {
    emit(Fetching());

    try {
      final upcomingMovies = await fetchUpcomingMoviesUsecase.execute();
      emit(Loaded(upcomingMovies));
    } catch (_) {
      emit(FetchError());
    }
  }
}
