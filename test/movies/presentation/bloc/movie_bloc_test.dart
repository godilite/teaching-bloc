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
  group('MovieBloc', () {
    late FetchMoviesUseCaseMock fetchMoviesUseCaseMock;
    late MovieBloc bloc;

    final movieItem = MovieModel(
      title: 'Ogbanje movie',
      posterPath: 'https://linktofile.png',
      overview: 'This is ogbanje movie',
      releaseDate: '19/02/2023',
      id: 1,
    );

    setUp(() {
      fetchMoviesUseCaseMock = FetchMoviesUseCaseMock();
      bloc = MovieBloc(fetchMoviesUseCaseMock);
    });

    blocTest(
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

    blocTest(
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

    blocTest(
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
  });
}
