class Movie {
  final int id;
  final double popularity;
  final String title;
  final String backdropPath;
  final String posterPath;
  final String overview;
  final double rating;

  Movie(
    this.id,
    this.popularity,
    this.title,
    this.backdropPath,
    this.posterPath,
    this.overview,
    this.rating,
  );

  Movie.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        popularity = json["popularity"].toDouble(),
        title = json["title"],
        backdropPath =
            json["backdrop_path"] ?? "/jntLBq0MLR3hrwKaTQswxACRPMs.jpg",
        posterPath = json["poster_path"] ?? "/jntLBq0MLR3hrwKaTQswxACRPMs.jpg",
        overview = json["overview"],
        rating = json["vote_average"].toDouble();
}
