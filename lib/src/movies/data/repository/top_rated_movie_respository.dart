import 'package:teaching_bloc/src/movies/domain/models/movie_model.dart';
import 'package:teaching_bloc/src/movies/domain/repository/top_rated_movie_repository.dart';
import 'package:teaching_bloc/src/network/base_api_client.dart';

class TopRatedMovieRepositoryImpl implements TopRatedMovieRepository {
  final String apiKey = '9615d585fe799a30b4302e086d95622e';
  static String movieURL = 'https://api.themoviedb.org/3/movie/top_rated';
  final ApiClient _client;
  TopRatedMovieRepositoryImpl(this._client);
  @override
  Future<List<MovieModel>> fetchTopRatedMovies() async {
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