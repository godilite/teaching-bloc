import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teaching_bloc/src/movies/domain/usecase/fetch_now_playing_movies_usecase.dart';
import 'package:teaching_bloc/src/movies/presentation/bloc/now_playing_movie/now_playing_movie_event.dart';
import 'package:teaching_bloc/src/movies/presentation/bloc/now_playing_movie/now_playing_movie_state.dart';

class NowPlayingMovieBloc
    extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  final FetchNowPlayingMovieRepositoryUsecase
      fetchNowPlayingMovieRepositoryUsecase;

  NowPlayingMovieBloc(this.fetchNowPlayingMovieRepositoryUsecase)
      : super(Fetching()) {
    on<Initialized>(_onInitilized);
    on<RetryPressed>(_onRetryPressed);
  }

  void _onInitilized(
      Initialized event, Emitter<NowPlayingMovieState> emit) async {
    emit(Fetching());

    try {
      final movies = await fetchNowPlayingMovieRepositoryUsecase.execute();
      emit(Loaded(movies));
    } catch (_) {
      emit(FetchError());
    }
  }

  void _onRetryPressed(
      RetryPressed event, Emitter<NowPlayingMovieState> emit) async {
    emit(Fetching());

    try {
      final movies = await fetchNowPlayingMovieRepositoryUsecase.execute();
      emit(Loaded(movies));
    } catch (_) {
      emit(FetchError());
    }
  }
}
