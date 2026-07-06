import 'package:cinerating/models/tv_crew_model.dart';
import 'package:cinerating/models/tv_show_model.dart';
import 'package:dio/dio.dart';

import '../../models/movie_detail_model.dart';
import '../../models/movie_simple_model.dart';
import '../../shared/env.dart';

class TvService {
  final url = Environment.apiBaseUrl;
  final token = Environment.token;

  Future<List<MovieSimple>?> getTvShows() async {
    try {
      final Dio dio = Dio();
      dio.options.headers["Authorization"] = "Bearer $token";

      final res = await dio.get('$url/discover/tv');

      List<MovieSimple> tvShows = [];

      res.data['results'].forEach((m) {
        final movie = MovieSimple.fromMap(m);
        tvShows.add(movie);
      });

      return tvShows;
    } on DioException {
      return null;
    }
  }

  Future<TvShowModel> getShowId({required String serieId}) async {
    try {
      final Dio dio = Dio();
      dio.options.headers["Authorization"] = "Bearer $token";

      final res = await dio.get('$url/tv/$serieId');

      TvShowModel tvshow = TvShowModel();

      tvshow = TvShowModel.fromMap(res.data);

      return tvshow;
    } on DioException {
      throw Exception("Não foi possível carregar os detalhes do filme");
    }
  }

  Future<TvShowCrew?> getShowCrew({required String id}) async {
    try {
      final Dio dio = Dio();
      dio.options.headers["Authorization"] = "Bearer $token";

      final res = await dio.get('$url/tv/$id/aggregate_credits');

      TvShowCrew crew = TvShowCrew();
      crew = TvShowCrew.fromMap(res.data);

      return crew;
    } on DioException {
      return null;
    }
  }
}
