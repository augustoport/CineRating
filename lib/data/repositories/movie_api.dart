import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/data/movie_data.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieData remoteDataSource;

  MovieRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Movie>> getMovies() {
    return remoteDataSource.getMovies();
  }

  @override
  Future<List<Movie>> searchMovies(String query) {
    return remoteDataSource.searchMovies(query);
  }

  @override
  Future<Movie> getMovieDetails(String movieId) {
    return remoteDataSource.getMovieDetails(movieId);
  }

  @override
  Future<dynamic> getMovieCrew(String movieId) {
    return remoteDataSource.getMovieCrew(movieId);
  }

  @override
  Future<dynamic> getMovieDetailsFull(String movieId) {
    return remoteDataSource.getMovieDetailsFull(movieId);
  }
}
