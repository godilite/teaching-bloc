import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teaching_bloc/src/movies/domain/usecase/fetch_top_rated_usecase.dart';
import 'package:teaching_bloc/src/movies/presentation/bloc/top_rated_movie/top_rated_movie_event.dart';
import 'package:teaching_bloc/src/movies/presentation/bloc/top_rated_movie/top_rated_movie_state.dart';

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  final FetchTopRatesMoviesUsecase fetchTopRatesMoviesUsecase;
  TopRatedMovieBloc(this.fetchTopRatesMoviesUsecase) : super(Fetching()) {
    on<Intialized>(_onInitialized);
    on<RetryPressed>(_onRetryPressed);
  }

  void _onInitialized(
      Intialized event, Emitter<TopRatedMovieState> emit) async {
    emit(Fetching());

    try {
      final movies = await fetchTopRatesMoviesUsecase.execute();
      emit(Loaded(movies));
    } catch (_) {
      emit(FetchError());
    }
  }

  void _onRetryPressed(
      RetryPressed event, Emitter<TopRatedMovieState> emit) async {
    emit(Fetching());

    try {
      final movies = await fetchTopRatesMoviesUsecase.execute();
      emit(Loaded(movies));
    } catch (_) {
      emit(FetchError());
    }
  }
}
