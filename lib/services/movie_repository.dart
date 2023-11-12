// ignore_for_file: unused_field, unused_catch_stack
import 'package:dio/dio.dart';
import 'package:movie_mate/models/genre.dart';
import 'package:movie_mate/models/movie.dart';

import '../consts/constants.dart';

class MovieRepository {
  final Dio _dio = Dio();
  var getPopularUrl = '$MAIN_URL/movie/top_rated';
  var getMoviesUrl = '$MAIN_URL/movie';
  var getPlayingUrl = '$MAIN_URL/movie/now_plaing';
  var getGenresUrl = '$MAIN_URL/genre/movie/list';
  var getMoviesByGenreUrl = '$MAIN_URL/discover/movie';

  Future<List<Movie>> getMovies() async {
    var params = {
      "api_key": API_KEY,
      "language": "en-US",
      "page": 1,
    };
    try {
      Response response =
          await _dio.get(getPopularUrl, queryParameters: params);
      List<Movie> movies = (response.data["results"] as List)
          .map((i) => Movie.fromJson(i))
          .toList();
      return movies;
    } catch (error, stacktrace) {
      rethrow;
    }
  }

  Future<List<Genre>> getGenres() async {
    var params = {
      "api_key": API_KEY,
      "language": "en-US",
      "page": 1,
    };
    try {
      Response response = await _dio.get(getGenresUrl, queryParameters: params);

      List<Genre> genres = (response.data["genres"] as List)
          .map((i) => Genre.fromJson(i))
          .toList();
      return genres;
    } catch (error, stacktrace) {
      rethrow;
    }
  }

  Future<List<Movie>> getMoviesByGenre(int id) async {
    var params = {
      "api_key": API_KEY,
      "with_genres": id,
      "language": "en_US",
      "page": 1,
    };
    try {
      Response response =
          await _dio.get(getMoviesByGenreUrl, queryParameters: params);
      if (response.data.containsKey("results") &&
          response.data["results"] is List) {
        List<Movie> movies = (response.data["results"] as List).map((i) {
          return Movie.fromJson(i);
        }).toList();
        return movies;
      } else {
        return [];
      }
    } catch (error, stacktrace) {
      rethrow;
    }
  }
}
