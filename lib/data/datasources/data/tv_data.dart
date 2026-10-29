import '../../../domain/entities/tv_show.dart';

abstract class TvData {
  Future<List<TvShow>> getTvShows();
  Future<List<TvShow>> searchTvShows(String query);
  Future<TvShow> getTvShowDetails(String tvShowId);
  Future<dynamic> getTvShowCrew(String tvShowId);
  Future<dynamic> getTvShowDetailsFull(String tvShowId);
}
