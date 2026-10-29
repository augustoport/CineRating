import 'package:dio/dio.dart';

import '../../../domain/entities/tv_show.dart';
import '../../models/movie_simple_model.dart';
import '../../../core/shared/env.dart';
import '../data/tv_data.dart';

class TvImplementation implements TvData {
  final Dio _dio = Dio();

  TvImplementation() {
    _dio.options.headers["Authorization"] =
        "Bearer ${Environment.production.token}";
    _dio.options.baseUrl = Environment.production.baseUrl;
  }

  @override
  Future<List<TvShow>> getTvShows() async {
    final response = await _dio.get('/discover/tv');
    return (response.data['results'] as List)
        .map((json) => _mapToEntity(MovieSimpleModel.fromMap(json)))
        .toList();
  }

  @override
  Future<List<TvShow>> searchTvShows(String query) async {
    final response = await _dio.get(
      '/search/tv',
      queryParameters: {'query': query, 'language': 'en-US;pt-BR'},
    );
    return (response.data['results'] as List)
        .map((json) => _mapToEntity(MovieSimpleModel.fromMap(json)))
        .toList();
  }

  @override
  Future<TvShow> getTvShowDetails(String tvShowId) async {
    final response = await _dio.get('/tv/$tvShowId');
    final model = MovieSimpleModel.fromMap(response.data);
    return _mapToEntity(model);
  }

  TvShow _mapToEntity(MovieSimpleModel model) {
    return TvShow(
      id: model.id ?? 0,
      name: model.name,
      overview: model.overview,
      posterPath: model.posterPath,
      backdropPath: model.backdropPath,
      voteAverage: model.voteAverage,
      firstAirDate: model.releaseDate,
      genreIds: model.genreIds,
    );
  }

  @override
  Future<dynamic> getTvShowCrew(String tvShowId) async {
    final response = await _dio.get('/tv/$tvShowId/aggregate_credits');
    return response.data;
  }

  @override
  Future<dynamic> getTvShowDetailsFull(String tvShowId) async {
    final response = await _dio.get('/tv/$tvShowId');
    return response.data;
  }
}
