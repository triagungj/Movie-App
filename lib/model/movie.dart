class Movie {
  late int id;
  late String originalLanguage;
  late String originalTitle;
  late String overview;
  late double popularity;
  late String posterPath;
  late String releaseDate;
  late String title;
  late double voteAverage;
  late int voteCount;

  Movie({
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    title = json['title'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }
}

class Movies {
  late List<Movie> listMovies;

  Movies(this.listMovies);

  Movies.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      listMovies = [];
      json['results'].forEach((v) {
        listMovies.add(Movie.fromJson(v));
      });
    }
  }
}
