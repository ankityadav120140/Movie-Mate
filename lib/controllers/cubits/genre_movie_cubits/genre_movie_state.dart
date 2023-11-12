import '../../../models/movie.dart';

abstract class GenreMovieState {}

class GenreMovieLoadingState extends GenreMovieState {}

class GenreMovieLoadedState extends GenreMovieState {
  final List<Movie> genreMovies;
  GenreMovieLoadedState(this.genreMovies);
}

class GenreMovieErrorState extends GenreMovieState {
  final String error;
  GenreMovieErrorState(this.error);
}
