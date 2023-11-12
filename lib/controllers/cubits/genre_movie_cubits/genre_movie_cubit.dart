// ignore_for_file: unnecessary_new

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mate/models/movie.dart';
import 'package:movie_mate/controllers/cubits/genre_movie_cubits/genre_movie_state.dart';
import 'package:movie_mate/services/movie_repository.dart';

class GenreMovieCubit extends Cubit<GenreMovieState> {
  GenreMovieCubit() : super(GenreMovieLoadingState()) {
    fetchGenreMovie(28);
  }

  void fetchGenreMovie(int id) async {
    MovieRepository movieRepository = MovieRepository();
    try {
      List<Movie> genreMovies = await movieRepository.getMoviesByGenre(id);
      emit(GenreMovieLoadedState(genreMovies));
    } catch (ex) {
      emit(GenreMovieLoadedState([]));
      // print("Error Caught : $ex");
      // emit(GenreMovieErrorState(ex.toString()));
    }
  }
}
