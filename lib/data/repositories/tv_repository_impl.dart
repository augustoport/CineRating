import '../../domain/entities/tv_show.dart';
import '../../domain/repositories/tv_repository.dart';
import '../datasources/tv_remote_datasource.dart';

class TvRepositoryImpl implements TvRepository {
  final TvRemoteDataSource remoteDataSource;

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
}
