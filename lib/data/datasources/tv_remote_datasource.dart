import '../../domain/entities/tv_show.dart';

abstract class TvRemoteDataSource {
  Future<List<TvShow>> getTvShows();
  Future<List<TvShow>> searchTvShows(String query);
  Future<TvShow> getTvShowDetails(String tvShowId);
}
