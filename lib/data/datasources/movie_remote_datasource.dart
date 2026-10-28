import '../../domain/entities/movie.dart';

abstract class MovieRemoteDataSource {
  Future<List<Movie>> getMovies();
  Future<List<Movie>> searchMovies(String query);
  Future<Movie> getMovieDetails(String movieId);
}
