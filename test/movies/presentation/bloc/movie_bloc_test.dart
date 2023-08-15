import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:teaching_bloc/src/movies/domain/models/movie_model.dart';
import 'package:teaching_bloc/src/movies/domain/usecase/fetch_all_movies_use_case.dart';
import 'package:teaching_bloc/src/movies/presentation/bloc/movie_bloc.dart';
import 'package:teaching_bloc/src/movies/presentation/bloc/movie_event.dart';
import 'package:teaching_bloc/src/movies/presentation/bloc/movie_state.dart';

class FetchMoviesUseCaseMock extends Mock implements FetchMoviesUseCase {}

void main() {
  group(
    'MovieBloc',
    () {
      late FetchMoviesUseCaseMock fetchMoviesUseCaseMock;
      late MovieBloc bloc;

      final movieItem = MovieModel(
          title: 'Ogbanje movie',
          posterPath: 'https://linktofile.png',
          overview: 'This is ogbanje movie',
          releaseDate: '19/02/2023',
          id: 1,
          rating: 3);

      setUp(() {
        fetchMoviesUseCaseMock = FetchMoviesUseCaseMock();
        bloc = MovieBloc(fetchMoviesUseCaseMock);
      });

      blocTest<MovieBloc, MovieState>(
        'emit Fetching and Loaded with 1 item when Initilized Event is added',
        build: () => bloc,
        setUp: () {
          when(() => fetchMoviesUseCaseMock.execute())
              .thenAnswer((_) async => [movieItem]);
        },
        act: (bloc) => bloc.add(Intialized()),
        expect: () => [
          Fetching(),
          Loaded([movieItem])
        ],
        verify: (_) => [
          verify(() => fetchMoviesUseCaseMock.execute()).called(1),
        ],
      );

      blocTest<MovieBloc, MovieState>(
        'emit Fetching and Loaded when Initilized Event is added',
        build: () => bloc,
        setUp: () {
          when(() => fetchMoviesUseCaseMock.execute())
              .thenAnswer((_) async => []);
        },
        act: (bloc) => bloc.add(Intialized()),
        expect: () => [
          isA<Fetching>(),
          isA<Loaded>(),
        ],
        verify: (_) => [
          verify(() => fetchMoviesUseCaseMock.execute()).called(1),
        ],
      );

      blocTest<MovieBloc, MovieState>(
        'should emit FetchError when fetchMoviesUseCaseMock returns an error',
        build: () => bloc,
        setUp: () {
          when(() => fetchMoviesUseCaseMock.execute()).thenThrow(
            Exception(),
          );
        },
        act: (bloc) => bloc.add(Intialized()),
        expect: () => [
          Fetching(),
          FetchError(),
        ],
      );
      
      blocTest<MovieBloc, MovieState>(
        'should emit fetching when RetryPressed Event is added, then, calls fetchMoviesUseCaseMock and emits Loaded State if successful',
        build: () => bloc,
        setUp: () {
          when(() => fetchMoviesUseCaseMock.execute()).thenAnswer(
            (_) async {
              return [movieItem];
            },
          );
        },
        act: (bloc) => bloc.add(RetryPressed()),
        expect: () => [
          Fetching(),
          Loaded([movieItem]),
        ],
        verify: (bloc) => verify(
          () => fetchMoviesUseCaseMock.execute(),
        ).called(1),
      );
      blocTest(
        'should emit fetching when RetryPressed Event is added, then, calls fetchMoviesCaseMock and emits an error if it fails',
        build: () => bloc,
        setUp: () {
          when(() => fetchMoviesUseCaseMock.execute()).thenThrow(
            Exception(),
          );
        },
        act: (bloc) => bloc.add(RetryPressed()),
        expect: () => [
          Fetching(),
          FetchError(),
        ],
        verify: (bloc) => verify(
          () => fetchMoviesUseCaseMock.execute(),
        ).called(1),
      );
    },
  );
}
