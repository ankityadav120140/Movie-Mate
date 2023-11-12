// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_mate/models/movie.dart';
import 'package:movie_mate/views/widgets/drawer_widget.dart';

class MovieDetailsPage extends StatefulWidget {
  final Movie movie;
  const MovieDetailsPage({required this.movie, super.key});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      endDrawer: DrawerWidget(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image(
                image: NetworkImage(
                    "https://image.tmdb.org/t/p/original/${widget.movie.backdropPath}")),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    widget.movie.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      shadows: [
                        Shadow(
                          color: Colors.grey,
                          blurRadius: 20,
                          offset: Offset(2, 2),
                        ),
                      ],
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        widget.movie.rating.toString(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      RatingBarIndicator(
                        rating: widget.movie.rating / 2,
                        itemCount: 5,
                        itemSize: 17.0,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.people, size: 25),
                      SizedBox(width: 15),
                      Text(
                        widget.movie.popularity.toString(),
                        style: TextStyle(fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 5, bottom: 10),
                        child: Text(
                          "OVERVIEW",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(widget.movie.overview),
                  SizedBox(height: 20),
                  Image(
                      image: NetworkImage(
                          "https://image.tmdb.org/t/p/original/${widget.movie.posterPath}")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
