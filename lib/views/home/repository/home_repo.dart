import 'package:dio/dio.dart';

import '../../../shared/env.dart';
import '../../../models/movie_simple_model.dart';

class HomeRepository {
  final url = Environment.apiBaseUrl;
  final token = Environment.token;

  Future<List<MovieSimple>?> getMovies() async {
    try {
      final Dio dio = Dio();
      dio.options.headers['Content-Type'] = 'application/json';
      dio.options.headers["authorization"] = "Bearer $token";

      final res = await dio.get('$url/discover/movie');

      List<MovieSimple> movies = [];

      res.data['results'].forEach((m) {
        final movie = MovieSimple.fromJson(m);
        movies.add(movie);
      });

      return movies;
    } on DioException catch (e) {
      print(e);
      return null;
    }
  }
}
