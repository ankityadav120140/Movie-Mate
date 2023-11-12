import 'package:movie_mate/models/genre.dart';

abstract class GenreState {}

class GenreLoadingState extends GenreState {}

class GenreLoadedState extends GenreState {
  final List<Genre> genres;
  GenreLoadedState(this.genres);
}

class GenreErrorState extends GenreState {
  final String error;
  GenreErrorState(this.error);
}
