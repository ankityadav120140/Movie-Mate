// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/genre.dart';
import '../../controllers/cubits/genre_movie_cubits/genre_movie_cubit.dart';

int selectedIndex = 0;
Widget GenreTile(Genre genre, BuildContext context, int index) {
  return InkWell(
    onTap: () {
      selectedIndex = index;
      BlocProvider.of<GenreMovieCubit>(context).fetchGenreMovie(genre.id);
    },
    child: Container(
      decoration: BoxDecoration(
          color: index == selectedIndex ? Colors.grey : Colors.transparent,
          border: Border.all(),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(5))),
      width: 120,
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 5),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: Center(
        child: Text(
          genre.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}
