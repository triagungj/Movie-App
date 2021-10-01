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
    voteAverage = json['vote_average'].toDouble();
    voteCount = json['vote_count'] as int;
  }
}

class Movies {
  late List<Movie> listMovies;
  late int totalResults;

  Movies.fromJson(Map<String, dynamic> json) {
    totalResults = json['total_results'];
    if (json['results'] != null) {
      listMovies = [];
      json['results'].forEach((v) {
        listMovies.add(Movie.fromJson(v));
      });
    } else {
      listMovies.add(Movie(
          id: 123,
          originalLanguage: "Dummy",
          originalTitle: "Dummy",
          overview: "Dummy",
          popularity: 123,
          posterPath: "Dummy",
          releaseDate: "Dummy",
          title: "Dummy",
          voteAverage: 123,
          voteCount: 123));
    }
  }
}
