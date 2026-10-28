import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_remote_datasource.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

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
}
