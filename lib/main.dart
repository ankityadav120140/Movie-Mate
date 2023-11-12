// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mate/consts/themes/theme_manager.dart';
import 'package:movie_mate/controllers/cubits/internet_cubits/internet_cubit.dart';
import 'package:movie_mate/views/pages/home_page.dart';
import 'consts/themes/theme_contants.dart';

void main() {
  runApp(MyApp());
}

ThemeManager themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InternetCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie Mate',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: themeManager.themeMode,
        home: Homepage(),
      ),
    );
  }
}
