// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:movie_mate/consts/constants.dart';
import 'package:movie_mate/views/pages/movie_details.dart';
import '../../models/movie.dart';

Widget TopMovie(Movie movie, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MovieDetailsPage(movie: movie)));
    },
    child: Stack(
      children: <Widget>[
        Container(
          height: TOP_CARD_HEIGHT,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                "https://image.tmdb.org/t/p/original/" + movie.backdropPath,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
                  0.5,
                  0.9,
                ],
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ]),
          ),
        ),
        Positioned(
          bottom: 35.0,
          child: Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            width: 250.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  movie.title,
                  style: TextStyle(
                      height: 1.5,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
