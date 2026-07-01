import 'package:dio/dio.dart';

import '../../models/movie_detail_model.dart';
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
        movies.add(movie);
      });

      return movies;

      // ignore: empty_catches
    } on DioException {
      return null;
    }
  }

  Future<MovieDetail> getMovieDetails({required String movieId}) async {
    try {
      final Dio dio = Dio();
      dio.options.headers["Authorization"] = "Bearer $token";

      final res = await dio.get('$url/movie/$movieId');

      MovieDetail movieDetails = MovieDetail();

      movieDetails = MovieDetail.fromMap(res.data);

      return movieDetails;
    } on DioException {
      throw Exception("Não foi possível carregar os detalhes do filme");
    }
  }
}
