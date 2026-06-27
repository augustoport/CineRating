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

  Future<List<MovieSimple>?> getMovieByName({required String movie}) async {
    try {
      final Dio dio = Dio();
      dio.options.headers["Authorization"] = "Bearer $token";

      final res = await dio.get(
        "$url/search/movie",
        queryParameters: {"query": movie, "language": "en-US;pt-BR"},
      );

      List<MovieSimple> movies = [];

      res.data['results'].forEach((m) {
        final movie = MovieSimple.fromMap(m);
        print(movie);
        movies.add(movie);
      });

      print(movies);

      return movies;

      // ignore: empty_catches
    } on DioException catch (e) {
      print(e);
    }
  }
}
