import 'dart:convert';
import 'package:flutter/cupertino.dart';
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
        'https://api.themoviedb.org/4/list/1?page=2&api_key=937dad13a793012eda640fc7394d471c'));

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
        appBar: AppBar(title: Text('Movie API')),
        body: SafeArea(
            child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: <Color>[Color(0xff750404), Color(0xff0d0e1a)],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft),
          ),
          child: Center(
            child: FutureBuilder<Movies>(
              future: futureMovie,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      physics: ClampingScrollPhysics(),
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
                            shadowColor: Colors.white,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.network(
                                            "https://image.tmdb.org/t/p/w500/" +
                                                movie.posterPath,
                                            fit: BoxFit.fill,
                                            height: 120),
                                      )),
                                ),
                                Expanded(
                                  flex: 10,
                                  child: Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 8, 16, 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 4, 8, 4),
                                              decoration: const BoxDecoration(
                                                  color: Colors.red),
                                              child: Text(
                                                (movie.originalLanguage)
                                                    .toUpperCase(),
                                                maxLines: 3,
                                              ),
                                            ),
                                            Text(
                                              movie.releaseDate,
                                              style: const TextStyle(
                                                fontSize: 12.0,
                                              ),
                                              textAlign: TextAlign.end,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Text(movie.title,
                                            style: const TextStyle(
                                                fontSize: 18.0,
                                                fontFamily: 'Anton')),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Rating: " +
                                                movie.voteAverage.toString()),
                                            Text("Voted: " +
                                                movie.voteCount.toString())
                                          ],
                                        )
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
                return const CircularProgressIndicator(
                  color: Color(0xFFdedede),
                );
              },
            ),
          ),
        )));
  }
}
