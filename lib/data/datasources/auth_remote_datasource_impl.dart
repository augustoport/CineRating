import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/entities/user.dart';
import '../../shared/env.dart';
import 'auth_remote_datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;
  final FlutterSecureStorage _storage;

  AuthRemoteDataSourceImpl()
    : _dio = Dio(
        BaseOptions(
          baseUrl: Environment.production.baseUrl,
          headers: {
            'Authorization': 'Bearer ${Environment.production.token}',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      ),
      _storage = const FlutterSecureStorage();

  @override
  Future<User> login({
    required String username,
    required String password,
  }) async {
    final requestToken = await createRequestToken();
    final validatedToken = await validateLogin(
      username: username,
      password: password,
      requestToken: requestToken,
    );
    final sessionId = await createSession(validatedToken);
    await _storage.write(key: 'tmdb_session_id', value: sessionId);
    return await getAccountDetails(sessionId);
  }

  @override
  Future<User> getAccountDetails(String sessionId) async {
    final response = await _dio.get(
      '/account',
      queryParameters: {'session_id': sessionId},
    );

    return User(
      id: response.data['id'],
      username: response.data['username'],
      name: response.data['name'],
      avatar: Avatar(
        gravatar: Gravatar(hash: response.data['avatar']['gravatar']['hash']),
        tmdb: Tmdb(avatarPath: response.data['avatar']['tmdb']['avatar_path']),
      ),
      sessionId: sessionId,
    );
  }

  Future<String> createRequestToken() async {
    final response = await _dio.get('/authentication/token/new');
    return response.data['request_token'];
  }

  Future<String> validateLogin({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    final response = await _dio.post(
      '/authentication/token/validate_with_login',
      data: {
        'username': username,
        'password': password,
        'request_token': requestToken,
      },
    );
    return response.data['request_token'];
  }

  Future<String> createSession(String requestToken) async {
    final response = await _dio.post(
      '/authentication/session/new',
      data: {'request_token': requestToken},
    );
    return response.data['session_id'];
  }
}
