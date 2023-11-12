import 'package:movie_mate/models/movie.dart';

abstract class MovieSate {}

class MovieLoadingState extends MovieSate {}

class MovieLoadedState extends MovieSate {
  final List<Movie> movies;
  MovieLoadedState(this.movies);
}

class MovieErrorState extends MovieSate {
  final String error;
  MovieErrorState(this.error);
}
