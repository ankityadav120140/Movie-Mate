import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mate/controllers/cubits/movie_cubits/movie_state.dart';
import 'package:movie_mate/services/movie_repository.dart';

import '../../../models/movie.dart';

class MovieCubit extends Cubit<MovieSate> {
  MovieCubit() : super(MovieLoadingState()) {
    fetchMovies();
  }
  MovieRepository movieRepository = MovieRepository();

  void fetchMovies() async {
    try {
      List<Movie> movies = await movieRepository.getMovies();
      emit(MovieLoadedState(movies));
    } catch (ex) {
      emit(MovieErrorState(ex.toString()));
    }
  }
}
