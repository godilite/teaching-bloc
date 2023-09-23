import 'package:teaching_bloc/src/movies/domain/models/movie_model.dart';
import 'package:teaching_bloc/src/movies/domain/repository/movie_repository.dart';
import 'package:teaching_bloc/src/movies/dto/move_type.dart';
import 'package:teaching_bloc/src/network/base_api_client.dart';

class MovieRepositoryImpl implements MovieRepository {
  final String apiKey = '9615d585fe799a30b4302e086d95622e';
  final ApiClient _client;

  MovieRepositoryImpl(this._client);

  String _getApiUrl(MovieType movieType) {
    switch (movieType) {
      case MovieType.popular:
        return 'https://api.themoviedb.org/3/movie/popular';
      case MovieType.topRated:
        return 'https://api.themoviedb.org/3/movie/top_rated';
      case MovieType.upcoming:
        return 'https://api.themoviedb.org/3/movie/upcoming';
      case MovieType.nowPlaying:
        return 'https://api.themoviedb.org/3/movie/now_playing';
    }
  }

  @override
  Future<List<MovieModel>> fetchAllMovies(MovieType movieType) async {
    final params = {
      'api_key': apiKey,
      'language': 'en-US',
    };

    final response = await _client.get(_getApiUrl(movieType), queryParameters: params);

    final movieList = response['results'] as List<dynamic>;
    return movieList.map((movie) => MovieModel.fromJson(movie as Map<String, dynamic>)).toList();
  }
}
