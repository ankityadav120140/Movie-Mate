// ignore_for_file: avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_new, prefer_interpolation_to_compose_strings, sized_box_for_whitespace, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mate/consts/constants.dart';
import 'package:movie_mate/controllers/cubits/genre_cubits/genre_cubit.dart';
import 'package:movie_mate/controllers/cubits/genre_cubits/genre_state.dart';
import 'package:movie_mate/controllers/cubits/genre_movie_cubits/genre_movie_cubit.dart';
import 'package:movie_mate/controllers/cubits/genre_movie_cubits/genre_movie_state.dart';
import 'package:movie_mate/controllers/cubits/internet_cubits/internet_cubit.dart';
import 'package:movie_mate/controllers/cubits/internet_cubits/internet_state.dart';
import 'package:movie_mate/controllers/cubits/movie_cubits/movie_cubit.dart';
import 'package:movie_mate/controllers/cubits/movie_cubits/movie_state.dart';
import 'package:movie_mate/views/widgets/genre_movie.dart';
import 'package:movie_mate/views/widgets/genre_tile.dart';
import 'package:movie_mate/views/widgets/top_movie.dart';
import 'package:page_indicator/page_indicator.dart';
import '../widgets/drawer_widget.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  PageController pageController =
      PageController(viewportFraction: 1, keepPage: false);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Movie Mate"),
      ),
      drawer: DrawerWidget(context),
      body: Container(
        padding: EdgeInsets.all(10),
        child: BlocConsumer<InternetCubit, InternetState>(
          listener: (context, state) {
            if (state == InternetState.Connected) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: SNACKBAR_DURATION,
                  content: Text(
                    "Connected!",
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state == InternetState.Disconnected) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: SNACKBAR_DURATION,
                  content: Text(
                    "Offline!",
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: ((context, state) {
            if (state == InternetState.Connected) {
              return Column(
                children: [
                  BlocProvider(
                    create: (context) => MovieCubit(),
                    child: BlocBuilder<MovieCubit, MovieSate>(
                        builder: (context, state) {
                      if (state is MovieLoadingState) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is MovieLoadedState) {
                        return Container(
                          height: TOP_CARD_HEIGHT,
                          child: PageIndicatorContainer(
                            align: IndicatorAlign.bottom,
                            length: state.movies.take(10).length,
                            indicatorSpace: 8.0,
                            padding: EdgeInsets.only(bottom: 15),
                            shape: IndicatorShape.circle(size: 10.0),
                            indicatorSelectorColor: Colors.grey.shade700,
                            child: PageView.builder(
                              pageSnapping: true,
                              controller: pageController,
                              scrollDirection: Axis.horizontal,
                              itemCount: state.movies.take(10).length,
                              itemBuilder: (context, index) {
                                return TopMovie(state.movies[index], context);
                              },
                            ),
                          ),
                        );
                      } else {
                        return Text("Server Error!");
                      }
                    }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BlocProvider(
                    create: (context) => GenreCubit(),
                    child: BlocBuilder<GenreCubit, GenreState>(
                      builder: (context, genreState) {
                        if (genreState is GenreErrorState) {
                          return Text("Error Loading Genres");
                        } else if (genreState is GenreLoadedState) {
                          return BlocProvider<GenreMovieCubit>(
                            create: (context) => GenreMovieCubit(),
                            child:
                                BlocBuilder<GenreMovieCubit, GenreMovieState>(
                              builder: (context, movieState) {
                                if (movieState is GenreMovieErrorState) {
                                  return Text("Error Loading Movies");
                                } else if (movieState
                                    is GenreMovieLoadedState) {
                                  return Column(
                                    children: [
                                      Container(
                                        height: 40,
                                        child: ListView.builder(
                                          itemCount: genreState.genres.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return GenreTile(
                                              genreState.genres[index],
                                              context,
                                              index,
                                            );
                                          },
                                        ),
                                      ),
                                      if (movieState.genreMovies.isEmpty)
                                        Container(
                                          height: GENRE_MOVIE_CARD_HEIGHT + 80,
                                          child: Center(
                                            child: Text(
                                                "No movies available for this genre!"),
                                          ),
                                        ),
                                      if (movieState.genreMovies.isNotEmpty)
                                        Container(
                                          height: GENRE_MOVIE_CARD_HEIGHT + 80,
                                          child: ListView.builder(
                                            itemCount:
                                                movieState.genreMovies.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              return GenreMovie(
                                                  movieState.genreMovies[index],
                                                  context);
                                            },
                                          ),
                                        ),
                                    ],
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  )
                ],
              );
            } else if (state == InternetState.Disconnected) {
              return Center(child: (Text("No Offline contect available")));
            } else {
              return CircularProgressIndicator();
            }
          }),
        ),
      ),
    );
  }
}
