import 'package:flutter/material.dart';
import 'package:project_latihan/model/movie.dart';

class DetailScreen extends StatelessWidget {
  final Movie movie;

  DetailScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Container(
        height: 350,
        child: Image.network(movie.posterPath),
      )
    ]));
  }
}
