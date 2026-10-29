import 'package:dio/dio.dart';

import '../../../domain/entities/movie.dart';
import '../../models/movie_simple_model.dart';
import '../../../core/shared/env.dart';
import '../data/movie_data.dart';

class MovieImplementation implements MovieData {
  final Dio _dio = Dio();

  MovieImplementation() {
    _dio.options.headers["Authorization"] =
        "Bearer ${Environment.production.token}";
    _dio.options.baseUrl = Environment.production.baseUrl;
  }

  @override
  Future<List<Movie>> getMovies() async {
    final response = await _dio.get('/discover/movie');
    return (response.data['results'] as List)
        .map((json) => _mapToEntity(MovieSimpleModel.fromMap(json)))
        .toList();
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    final response = await _dio.get(
      '/search/movie',
      queryParameters: {'query': query, 'language': 'en-US;pt-BR'},
    );
    return (response.data['results'] as List)
        .map((json) => _mapToEntity(MovieSimpleModel.fromMap(json)))
        .toList();
  }

  @override
  Future<Movie> getMovieDetails(String movieId) async {
    final response = await _dio.get('/movie/$movieId');
    final model = MovieSimpleModel.fromMap(response.data);
    return _mapToEntity(model);
  }

  Movie _mapToEntity(MovieSimpleModel model) {
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

  @override
  Future<dynamic> getMovieCrew(String movieId) async {
    final response = await _dio.get('/movie/$movieId/credits');
    return response.data;
  }

  @override
  Future<dynamic> getMovieDetailsFull(String movieId) async {
    final response = await _dio.get('/movie/$movieId');
    return response.data;
  }
}
