import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:teaching_bloc/src/movies/domain/models/movie_model.dart';
import 'package:teaching_bloc/src/movies/domain/repository/movie_repository.dart';
import 'package:teaching_bloc/src/movies/domain/usecase/fetch_all_movies_use_case.dart';

class MovieRepositoryMock extends Mock implements MovieRepository {}

void main() {
  group('FetchMoviesUseCase', () {
    late MovieRepositoryMock movieRepositoryMock;
    late FetchMoviesUseCase fetchMoviesUseCase;

    final movies = [
      MovieModel(
          title: 'Ogbanje movie',
          posterPath: 'https://linktofile.png',
          overview: 'This is ogbanje movie',
          releaseDate: '19/02/2023',
          id: 1,
          rating: 1),
      MovieModel(
          title: 'Agbado movie',
          posterPath: 'https://linktofile.png',
          overview: 'This is agbado best movie part 1',
          releaseDate: '19/02/2023',
          id: 2,
          rating: 2)
    ];

    setUp(() {
      movieRepositoryMock = MovieRepositoryMock();
      fetchMoviesUseCase = FetchMoviesUseCase(movieRepositoryMock);
    });

    test('Returns list of two movies when execute() method is called',
        () async {
      when(() => movieRepositoryMock.fetchAllMovies())
          .thenAnswer((_) async => movies);

      final result = await fetchMoviesUseCase.execute();

      expect(result.length, equals(2));
    });

    test('Throws error when newtowrk error occurs', () async {
      when(() => movieRepositoryMock.fetchAllMovies()).thenThrow(Exception());

      final result = fetchMoviesUseCase.execute();

      expect(result, throwsA(isA<Exception>()));
    });

    test('Verify that first movie in list is `Ogbanje movie`', () async {
      when(() => movieRepositoryMock.fetchAllMovies())
          .thenAnswer((_) async => movies);

      final result = await fetchMoviesUseCase.execute();

      expect(result.first.title, equals('Ogbanje movie'));
    });
  });
}
