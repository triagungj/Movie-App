class Movie {
  final int id;
  final String title;
  final String released;
  final String overview;
  final double rating;
  final String poster;

  Movie(
      {required this.id,
      required this.title,
      required this.released,
      required this.overview,
      required this.rating,
      required this.poster});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        id: json['id'],
        title: json['title'],
        released: json['release_date'],
        overview: json['overview'],
        rating: json['vote_average'],
        poster: json['poster_path']);
  }
}
