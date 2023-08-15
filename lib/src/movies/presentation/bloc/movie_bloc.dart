import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teaching_bloc/src/movies/domain/usecase/fetch_all_movies_use_case.dart';
import 'package:teaching_bloc/src/movies/presentation/bloc/movie_event.dart';
import 'package:teaching_bloc/src/movies/presentation/bloc/movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final FetchMoviesUseCase fetchMoviesUseCase;

  MovieBloc(this.fetchMoviesUseCase) : super(Fetching()) {
    on<Intialized>(_onInitilized);
    on<RetryPressed>(_onRetryPressed);
  }

  void _onInitilized(Intialized event, Emitter<MovieState> emit) async {
    emit(Fetching());

    try {
      final movies = await fetchMoviesUseCase.execute();
      emit(Loaded(movies));
    } catch (_) {
      emit(FetchError());
    }
  }

  void _onRetryPressed(RetryPressed event, Emitter<MovieState> emit) async {
    emit(Fetching());

    try {
      final movies = await fetchMoviesUseCase.execute();
      emit(Loaded(movies));
    } catch (_) {
      emit(FetchError());
    }
  }
}
