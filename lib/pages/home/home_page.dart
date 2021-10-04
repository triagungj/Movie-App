import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_latihan/model/movie.dart';
import 'package:project_latihan/pages/detail/detail_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Movies> futureMovie;
  int listId = 1;

  Future<Movies> fetchMovie() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/4/list/$listId?page=1&api_key=937dad13a793012eda640fc7394d471c'));
    Future.delayed(const Duration(milliseconds: 2000), () {
      futureMovie = Future.value(Movies.fromJson(jsonDecode(response.body)));
    });

    if (response.statusCode == 200) {
      return Movies.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load movie');
    }
  }

  Future<void> _refresh() async {
    listId++;
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/4/list/$listId?page=1&api_key=937dad13a793012eda640fc7394d471c'));

    setState(() {
      Future.delayed(const Duration(milliseconds: 2000), () {
        futureMovie = Future.value(Movies.fromJson(jsonDecode(response.body)));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    futureMovie = fetchMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
            Theme.of(context).colorScheme.secondaryVariant,
            Theme.of(context).colorScheme.primaryVariant
          ], begin: Alignment.centerLeft, end: Alignment.bottomRight),
        ),
        child: Center(
          child: FutureBuilder<Movies>(
              future: futureMovie,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return RefreshIndicator(
                      onRefresh: _refresh,
                      child: CustomScrollView(
                        slivers: <Widget>[
                          SliverAppBar(
                              pinned: false,
                              snap: true,
                              floating: true,
                              flexibleSpace: const FlexibleSpaceBar(
                                title: Text(
                                  'M O V I E',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: 'Staatliches',
                                  ),
                                ),
                              ),
                              centerTitle: true,
                              leading: const Icon(
                                Icons.menu,
                              ),
                              actions: <Widget>[
                                IconButton(
                                  icon: const Icon(Icons.favorite),
                                  tooltip: 'Your Favorite',
                                  onPressed: () {},
                                ),
                              ]),
                          SliverToBoxAdapter(
                              child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 16, 12, 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Watch A Movie",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4),
                                      const SizedBox(height: 12),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 7,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                  prefixIcon: Icon(
                                                    Icons.search,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary,
                                                  ),
                                                  focusedBorder:
                                                      const UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0xffffffff),
                                                    ),
                                                  ),
                                                  hintText: 'Search Movie'),
                                            ),
                                          ),
                                          const SizedBox(width: 20),
                                          Expanded(
                                            flex: 3,
                                            child: ElevatedButton(
                                              onPressed: () {},
                                              child: const Text(
                                                'Search',
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ))),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                final Movie movie =
                                    snapshot.data!.listMovies[index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return DetailScreen(movieId: movie.id);
                                    }));
                                  },
                                  child: Card(
                                    child: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 12, 16, 12),
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 4,
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: Image.network(
                                                      "https://image.tmdb.org/t/p/w500/" +
                                                          movie.posterPath,
                                                      fit: BoxFit.fill,
                                                      height: 120),
                                                )),
                                          ),
                                          Expanded(
                                            flex: 8,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      8, 8, 12, 8),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                8, 4, 8, 4),
                                                        decoration: const BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            4)),
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
                                                        textAlign:
                                                            TextAlign.end,
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  Text(movie.title,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline2),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Rating: " +
                                                            movie.voteAverage
                                                                .toString(),
                                                        style: const TextStyle(
                                                            fontStyle: FontStyle
                                                                .italic),
                                                      ),
                                                      Text(
                                                        "Voted: " +
                                                            movie.voteCount
                                                                .toString(),
                                                        style: const TextStyle(
                                                            fontStyle: FontStyle
                                                                .italic),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              childCount: snapshot.data!.listMovies.length,
                            ),
                          ),
                        ],
                      ));
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator(
                  color: Color(0xFFdedede),
                );
              }),
        ),
      ),
    );
  }
}
