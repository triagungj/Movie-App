import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_latihan/model/movie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Movies> futureMovie;

  Future<Movies> fetchMovie() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/4/list/1?page=1&api_key=937dad13a793012eda640fc7394d471c'));

    if (response.statusCode == 200) {
      return Movies.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load movie');
    }
  }

  @override
  void initState() {
    super.initState();
    futureMovie = fetchMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
      child: FutureBuilder<Movies>(
        future: futureMovie,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemBuilder: (context, index) {
                  final Movie movie = snapshot.data!.listMovies[index];
                  return InkWell(
                    onTap: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) {
                      //   return DetailScreen(place: place);
                      // }));
                    },
                    child: Card(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(17),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    "https://image.tmdb.org/t/p/w500/" +
                                        movie.posterPath,
                                  ),
                                )),
                          ),
                          Expanded(
                            flex: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    movie.title,
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    movie.overview,
                                    maxLines: 3,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: snapshot.data!.listMovies.length);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    )));
  }
}
