import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_latihan/model/movie.dart';
import 'package:http/http.dart' as http;

class DetailScreen extends StatefulWidget {
  final int movieId;
  const DetailScreen({Key? key, required this.movieId}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<Movie> futureMovie;

  Future<Movie> _fetchMovie() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/${widget.movieId}?api_key=937dad13a793012eda640fc7394d471c&language=en-US'));

    if (response.statusCode == 200) {
      return Movie.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load movie');
    }
  }

  @override
  void initState() {
    super.initState();
    futureMovie = _fetchMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: <Color>[Color(0xff750404), Color(0xff000000)],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft),
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 500.0,
            maxHeight: double.infinity,
            maxWidth: double.infinity,
          ),
          child: Align(
            alignment: Alignment.topCenter,
            child: FutureBuilder<Movie>(
                future: futureMovie,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final Movie movie = snapshot.data!;
                    DateTime parseDt = DateTime.parse(movie.releaseDate);
                    var newFormat = DateFormat.y().format(parseDt);
                    return SingleChildScrollView(
                      child: Center(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Stack(children: <Widget>[
                                SizedBox(
                                  height: 500,
                                  width: double.infinity,
                                  child: Image.network(
                                    'https://image.tmdb.org/t/p/w500/' +
                                        movie.posterPath,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                IconButton(
                                    focusColor:
                                        const Color.fromARGB(80, 240, 23, 50),
                                    icon: const Icon(Icons.arrow_back_outlined,
                                        size: 32),
                                    color: Colors.black,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }),
                              ]),
                              Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 16, 12, 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(movie.originalTitle,
                                          style: const TextStyle(
                                              fontFamily: 'Staatliches',
                                              fontSize: 32)),
                                      const SizedBox(height: 12),
                                      RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                            style: const TextStyle(
                                              color: Color(0XFFc9c5c5),
                                              fontFamily: 'Oxygen',
                                              fontSize: 14,
                                            ),
                                            children: [
                                              TextSpan(
                                                  text: newFormat + "  |  "),
                                              TextSpan(
                                                  text: movie.originalLanguage
                                                          .toUpperCase() +
                                                      "  |  "),
                                              const WidgetSpan(
                                                child: Icon(
                                                  Icons.star,
                                                  size: 16,
                                                  color: Color(0XFFc9c5c5),
                                                ),
                                              ),
                                              TextSpan(
                                                  text: " " +
                                                      movie.voteAverage
                                                          .toString() +
                                                      " / 10"),
                                            ]),
                                      ),
                                      const SizedBox(height: 12),
                                      const Text("Synopsis: ",
                                          style: TextStyle(
                                            fontFamily: 'Cardo',
                                            fontSize: 18,
                                          )),
                                      Text(movie.overview,
                                          style: const TextStyle(
                                              fontFamily: 'Oxygen',
                                              fontSize: 14,
                                              color: Color(0XFFc9c5c5))),
                                    ],
                                  )),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 12, 16, 12),
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                        minimumSize: MaterialStateProperty.all(
                                            const Size.fromHeight(42)),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                const Color(0xff750404)),
                                      ),
                                      onPressed: () {},
                                      child: const Text('Watch Movie',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'Anton',
                                          ))))
                            ]),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator(
                    color: Color(0xFFdedede),
                  );
                }),
          ),
        ),
      ),
    ));
  }
}
