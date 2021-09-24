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
  late Future<List<Movie>> futureMovie;

  Future<List<Movie>> fetchMovie() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/4/list/1?page=1&api_key=937dad13a793012eda640fc7394d471c'));

    if (response.statusCode == 200) {
      var _movie = jsonDecode(response.body)['results'] as List;
      List<Movie> listMovies =
          _movie.map((_movie) => Movie.fromJson(_movie)).toList();

      return listMovies;
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
        appBar: AppBar(title: Text("Movie API")),
        body: SafeArea(
            child: Center(
          child: FutureBuilder<List<Movie>>(
            future: futureMovie,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemBuilder: (context, index) {
                      final Movie movie = snapshot.data![index];
                      return InkWell(
                        onTap: () {
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) {
                          //   return DetailScreen(place: place);
                          // }));
                        },
                        child: Card(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: Center(
                                    child: Image.network(
                                        "https://image.tmdb.org/t/p/w500/" +
                                            movie.poster)),
                              ),
                              Expanded(
                                flex: 10,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        movie.title,
                                        style: TextStyle(fontSize: 16.0),
                                      ),
                                      const SizedBox(
                                        height: 18,
                                      ),
                                      Text(movie.released),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: snapshot.data!.length);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            },
          ),
        )));
  }
}
