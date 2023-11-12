import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mate/controllers/cubits/genre_cubits/genre_state.dart';
import 'package:movie_mate/services/movie_repository.dart';

import '../../../models/genre.dart';

class GenreCubit extends Cubit<GenreState> {
  GenreCubit() : super(GenreLoadingState()) {
    fetchGenres();
  }
  MovieRepository movieRepository = MovieRepository();
  void fetchGenres() async {
    try {
      List<Genre> genres = await movieRepository.getGenres();
      emit(GenreLoadedState(genres));
    } catch (ex) {
      emit(GenreErrorState(ex.toString()));
    }
  }
}
