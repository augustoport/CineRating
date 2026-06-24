import 'package:dio/dio.dart';

import '../../shared/env.dart';
import '../../models/movie_simple_model.dart';

class MovieService {
  final url = Environment.apiBaseUrl;
  final token = Environment.token;

  Future<List<MovieSimple>?> getMovies() async {
    try {
      final Dio dio = Dio();
      dio.options.headers["Authorization"] = "Bearer $token";

      final res = await dio.get('$url/discover/movie');

      List<MovieSimple> movies = [];

      res.data['results'].forEach((m) {
        final movie = MovieSimple.fromMap(m);
        movies.add(movie);
      });

      return movies;
    } on DioException {
      return null;
    }
  }
}
