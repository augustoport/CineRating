import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/logic/cubit/movie_detail/movie_cubit.dart';

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
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder(
        bloc: movieCubit,
        builder: (context, state) {
          return Column(
            children: [
              if (state is MovieLoading)
                Center(child: CircularProgressIndicator()),
              if (state is MovieSuccess) ...[
                Image.network(state.movieDetail.posterPath ?? ""),
              ],
            ],
          );
        },
      ),
    );
  }
}
