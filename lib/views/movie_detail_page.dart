import 'package:cinerating/widgets/content_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../core/logic/cubit/movie_detail/movie_cubit.dart';
import '../shared/themes/app_colors.dart';
import '../widgets/cast_card.dart';

class MovieDetailPage extends StatefulWidget {
  final String movieId;
  const MovieDetailPage({super.key, required this.movieId});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  MovieCubit movieCubit = MovieCubit();
  AppColors appColors = AppColors();

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
            return ContentDetail(
              content: state.movieDetail,
              type: "movie",
              cast: state.cast,
              director: state.director,
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
