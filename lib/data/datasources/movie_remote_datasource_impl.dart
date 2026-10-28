import 'package:dio/dio.dart';

import '../../domain/entities/movie.dart';
import '../../data/models/movie_simple_model.dart';
import '../../core/shared/env.dart';
import 'movie_remote_datasource.dart';

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final Dio _dio = Dio();

  MovieRemoteDataSourceImpl() {
    _dio.options.headers["Authorization"] =
        "Bearer ${Environment.production.token}";
    _dio.options.baseUrl = Environment.production.baseUrl;
  }

  @override
  Future<List<Movie>> getMovies() async {
    final response = await _dio.get('/discover/movie');
    return (response.data['results'] as List)
        .map((json) => _mapToEntity(MovieSimple.fromMap(json)))
        .toList();
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    final response = await _dio.get(
      '/search/movie',
      queryParameters: {'query': query, 'language': 'en-US;pt-BR'},
    );
    return (response.data['results'] as List)
        .map((json) => _mapToEntity(MovieSimple.fromMap(json)))
        .toList();
  }

  @override
  Future<Movie> getMovieDetails(String movieId) async {
    final response = await _dio.get('/movie/$movieId');
    final model = MovieSimple.fromMap(response.data);
    return _mapToEntity(model);
  }

  Movie _mapToEntity(MovieSimple model) {
    return Movie(
      id: model.id ?? 0,
      title: model.title,
      name: model.name,
      overview: model.overview,
      posterPath: model.posterPath,
      backdropPath: model.backdropPath,
      voteAverage: model.voteAverage,
      releaseDate: model.releaseDate,
      genreIds: model.genreIds,
    );
  }
}
