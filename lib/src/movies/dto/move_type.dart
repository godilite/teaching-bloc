enum MovieType {
  popular,
  nowPlaying,
  topRated,
  upcoming;
}

extension MovieTypeTitle on MovieType {
  String get value {
    switch (this) {
      case MovieType.popular:
        return 'Whats Popular';
      case MovieType.nowPlaying:
        return 'Now Playing';
      case MovieType.topRated:
        return 'Top Rated';
      case MovieType.upcoming:
        return 'Upcoming';
    }
  }
}
