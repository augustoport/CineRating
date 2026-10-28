import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../core/logic/cubit/home/home_cubit.dart';
import '../data/datasources/auth_remote_datasource.dart';
import '../data/datasources/auth_remote_datasource_impl.dart';
import '../data/datasources/movie_remote_datasource.dart';
import '../data/datasources/movie_remote_datasource_impl.dart';
import '../data/datasources/tv_remote_datasource.dart';
import '../data/datasources/tv_remote_datasource_impl.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../data/repositories/movie_repository_impl.dart';
import '../data/repositories/tv_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/repositories/movie_repository.dart';
import '../domain/repositories/tv_repository.dart';
import '../domain/usecases/get_movies_usecase.dart';
import '../domain/usecases/get_tv_shows_usecase.dart';
import '../domain/usecases/login_usecase.dart';
import '../domain/usecases/search_movies_usecase.dart';
import '../domain/usecases/search_tv_shows_usecase.dart';
import '../presentation/controllers/controllers/login_controller.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Datasources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  getIt.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(),
  );

  getIt.registerLazySingleton<TvRemoteDataSource>(
    () => TvRemoteDataSourceImpl(),
  );

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: getIt<AuthRemoteDataSource>(),
      storage: const FlutterSecureStorage(),
    ),
  );

  getIt.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(remoteDataSource: getIt<MovieRemoteDataSource>()),
  );

  getIt.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(remoteDataSource: getIt<TvRemoteDataSource>()),
  );

  // Use Cases
  getIt.registerFactory<LoginUseCase>(
    () => LoginUseCase(getIt<AuthRepository>()),
  );

  getIt.registerFactory<GetMoviesUseCase>(
    () => GetMoviesUseCase(getIt<MovieRepository>()),
  );

  getIt.registerFactory<SearchMoviesUseCase>(
    () => SearchMoviesUseCase(getIt<MovieRepository>()),
  );

  getIt.registerFactory<GetTvShowsUseCase>(
    () => GetTvShowsUseCase(getIt<TvRepository>()),
  );

  getIt.registerFactory<SearchTvShowsUseCase>(
    () => SearchTvShowsUseCase(getIt<TvRepository>()),
  );

  // Controllers (manter compatibilidade temporária)
  getIt.registerFactory<LoginController>(() => LoginController());

  // Cubits (manter compatibilidade temporária)
  getIt.registerFactory<HomeCubit>(() => HomeCubit());
}
