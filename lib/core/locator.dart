import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../presentation/bloc/home/home_cubit.dart';
import '../presentation/controllers/login_controller.dart';
import './services/auth_service.dart';
import './services/movie_service.dart';
import './services/tv_service.dart';
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
import '../domain/usecases/get_current_user_usecase.dart';
import '../domain/usecases/get_movies_usecase.dart';
import '../domain/usecases/get_tv_shows_usecase.dart';
import '../domain/usecases/login_usecase.dart';
import '../domain/usecases/logout_usecase.dart';
import '../domain/usecases/search_movies_usecase.dart';
import '../domain/usecases/search_tv_shows_usecase.dart';
import 'shared/env.dart';

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

  getIt.registerFactory<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(getIt<AuthRepository>()),
  );

  getIt.registerFactory<LogoutUseCase>(
    () => LogoutUseCase(getIt<AuthRepository>()),
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

  // Controllers
  getIt.registerFactory<LoginController>(() => LoginController());

  // Cubits
  getIt.registerFactory<HomeCubit>(() => HomeCubit());

  // Serviços legados (usados por cubits de detalhes)
  getIt.registerLazySingleton<AuthService>(
    () => AuthService(accessToken: Environment.production.token),
  );

  getIt.registerLazySingleton<MovieService>(() => MovieService());

  getIt.registerLazySingleton<TvService>(() => TvService());
}
