import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/logic/cubit/movie_detail/movie_cubit.dart';
import '../widgets/cast_card.dart';

class MovieDetailPage extends StatefulWidget {
  final String movieId;
  const MovieDetailPage({super.key, required this.movieId});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  MovieCubit movieCubit = MovieCubit();

  @override
  initState() {
    Future.microtask(() {
      movieCubit.getMovieDetails(widget.movieId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder(
        bloc: movieCubit,
        builder: (context, state) {
          if (state is MovieLoading) {
            return Expanded(child: Center(child: CircularProgressIndicator()));
          } else if (state is MovieSuccess) {
            return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) => Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepPurple.shade900,
                          spreadRadius: .15,
                          blurRadius: .8,
                          offset: Offset(0, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: size.width,
                          child: Expanded(
                            child: Container(
                              height: size.height * .27,
                              width: size.width,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade900,
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(4),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                                child: Image.network(
                                  state.movieDetail.backdropPath ?? "",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 10,
                          top: 10,
                          child: Container(
                            height: size.height * .25,
                            width: size.width * .35,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.grey.shade400,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(6),
                              child: Image.network(
                                fit: BoxFit.cover,
                                state.movieDetail.posterPath ?? "",
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value:
                                              loadingProgress
                                                          .expectedTotalBytes !=
                                                      null &&
                                                  loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                              ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                state.movieDetail.title ?? "N/A",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 18,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  state.movieDetail.voteAverage
                                          ?.toStringAsFixed(1) ??
                                      "N/A",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "(${state.movieDetail.voteCount?.toString() ?? "N/A"})",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  DateFormat("dd/MM/yyyy").format(
                                    state.movieDetail.releaseDate ??
                                        DateTime.now(),
                                  ),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "${state.movieDetail.runtime?.toString() ?? "N/A"} min",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Genres:",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: List.generate(
                            state.movieDetail.genres?.length ?? 0,
                            (i) {
                              final genre = state.movieDetail.genres![i];
                              return Container(
                                margin: EdgeInsets.only(right: 5),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.deepPurple.shade900,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    genre.name ?? "N/A",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          state.movieDetail.overview ?? "N/A",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Cast:",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(state.cast.length, (i) {
                              final actor = state.cast[i];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CastCard(actor),
                              );
                            }),
                          ),
                        ),
                        SizedBox(height: 15),
                        if (state.director.name != "N/A")
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: .end,
                            children: [
                              Text(
                                "Directed by:",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Column(
                                children: [
                                  if (state.director.profilePath != null) ...[
                                    Image.network(
                                      state.director.profilePath ?? "",
                                      height: 80,
                                      width: 50,
                                      fit: BoxFit.cover,
                                    ),
                                  ] else ...[
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade400,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Icon(Icons.person, size: 50),
                                    ),
                                  ],
                                  SizedBox(height: 5),
                                  Text(
                                    state.director.name ?? "N/A",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
                ],
              ),
            );
          } else {
            return Center(
              child: Text(
                "Error",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            );
          }
        },
      ),
    );
  }
}
