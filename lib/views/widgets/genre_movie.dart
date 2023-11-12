// ignore_for_file: prefer_const_constructors, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_mate/consts/constants.dart';
import 'package:movie_mate/views/pages/movie_details.dart';

import '../../models/movie.dart';

Widget GenreMovie(Movie movie, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MovieDetailsPage(movie: movie)));
    },
    child: Container(
      margin: EdgeInsets.all(5),
      width: GENRE_MOVIE_CARD_WIDTH,
      height: GENRE_MOVIE_CARD_HEIGHT,
      decoration: BoxDecoration(border: Border.all()),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: GENRE_MOVIE_CARD_HEIGHT,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "https://image.tmdb.org/t/p/original/${movie.posterPath}"),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 43,
            padding: EdgeInsets.all(3),
            child: Text(
              movie.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 2),
            child: Row(
              children: [
                RatingBarIndicator(
                  rating: movie.rating / 2,
                  itemCount: 5,
                  itemSize: 17.0,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                ),
                Text("(${(movie.popularity).toInt()})")
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
