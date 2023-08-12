class MovieModel {
  final String title;
  final String posterPath;
  final String overview;
  final String releaseDate;
  final int id;
  final dynamic rating;

  MovieModel({
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.releaseDate,
    required this.id,
    required this.rating,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      title: json['title'],
      posterPath: json['poster_path'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      id: json['id'],
      rating: json['vote_average'],
    );
  }
}
