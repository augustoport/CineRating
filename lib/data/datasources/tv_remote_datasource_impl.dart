import 'package:dio/dio.dart';

import '../../domain/entities/tv_show.dart';
import '../../data/models/movie_simple_model.dart';
import '../../shared/env.dart';
import 'tv_remote_datasource.dart';

class TvRemoteDataSourceImpl implements TvRemoteDataSource {
  final Dio _dio = Dio();

  TvRemoteDataSourceImpl() {
    _dio.options.headers["Authorization"] =
        "Bearer ${Environment.production.token}";
    _dio.options.baseUrl = Environment.production.baseUrl;
  }

  @override
  Future<List<TvShow>> getTvShows() async {
    final response = await _dio.get('/discover/tv');
    return (response.data['results'] as List)
        .map((json) => _mapToEntity(MovieSimple.fromMap(json)))
        .toList();
  }

  @override
  Future<List<TvShow>> searchTvShows(String query) async {
    final response = await _dio.get(
      '/search/tv',
      queryParameters: {'query': query, 'language': 'en-US;pt-BR'},
    );
    return (response.data['results'] as List)
        .map((json) => _mapToEntity(MovieSimple.fromMap(json)))
        .toList();
  }

  @override
  Future<TvShow> getTvShowDetails(String tvShowId) async {
    final response = await _dio.get('/tv/$tvShowId');
    final model = MovieSimple.fromMap(response.data);
    return _mapToEntity(model);
  }

  TvShow _mapToEntity(MovieSimple model) {
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
}
