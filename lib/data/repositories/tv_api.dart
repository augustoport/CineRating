import '../../domain/entities/tv_show.dart';
import '../../domain/repositories/tv_repository.dart';
import '../datasources/data/tv_data.dart';

class TvRepositoryImpl implements TvRepository {
  final TvData remoteDataSource;

  TvRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<TvShow>> getTvShows() {
    return remoteDataSource.getTvShows();
  }

  @override
  Future<List<TvShow>> searchTvShows(String query) {
    return remoteDataSource.searchTvShows(query);
  }

  @override
  Future<TvShow> getTvShowDetails(String tvShowId) {
    return remoteDataSource.getTvShowDetails(tvShowId);
  }

  @override
  Future<dynamic> getTvShowCrew(String tvShowId) {
    return remoteDataSource.getTvShowCrew(tvShowId);
  }

  @override
  Future<dynamic> getTvShowDetailsFull(String tvShowId) {
    return remoteDataSource.getTvShowDetailsFull(tvShowId);
  }
}
