import 'package:teaching_bloc/src/movies/domain/models/movie_model.dart';
import 'package:teaching_bloc/src/movies/domain/repository/movie_repository.dart';
import 'package:teaching_bloc/src/network/base_api_client.dart';

class MovieRepositoryImpl implements MovieRepository {
  final String apiKey = '9615d585fe799a30b4302e086d95622e';
  static String movieURL = 'https://api.themoviedb.org/3/movie/popular';
  final ApiClient _client;
  MovieRepositoryImpl(this._client);
  @override
  Future<List<MovieModel>> fetchAllMovies() async {
    final params = {
      'api_key': apiKey,
      'language': 'en-US',
    };

    final response = await _client.get(movieURL, queryParameters: params);

    final movieList = response['results'] as List<dynamic>;
    return movieList
        .map((movie) => MovieModel.fromJson(movie as Map<String, dynamic>))
        .toList();
  }
}
