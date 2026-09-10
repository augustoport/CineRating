import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../shared/env.dart';

class AuthService {
  final Dio _dio;
  final FlutterSecureStorage _storage;

  AuthService({
    required String accessToken,
  })  : _dio = Dio(
          BaseOptions(
            baseUrl: Environment.apiBaseUrl,
            headers: {
              'Authorization': 'Bearer $accessToken',
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        ),
        _storage = const FlutterSecureStorage();

  Future<String> createRequestToken() async {
    final response = await _dio.get(
      '/authentication/token/new',
    );

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
      data: {
        'request_token': requestToken,
      },
    );

    return response.data['session_id'];
  }

  Future<String> login({
    required String username,
    required String password,
  }) async {
    // 1. Cria request token
    final requestToken = await createRequestToken();

    // 2. Valida usuário e senha
    final validatedToken = await validateLogin(
      username: username,
      password: password,
      requestToken: requestToken,
    );

    // 3. Cria a sessão
    final sessionId = await createSession(
      validatedToken,
    );

    // 4. Salva a sessão
    await _storage.write(
      key: 'tmdb_session_id',
      value: sessionId,
    );

    return sessionId;
  }

  Future<String?> getSessionId() {
    return _storage.read(
      key: 'tmdb_session_id',
    );
  }

  Future<void> clearSession() {
    return _storage.delete(
      key: 'tmdb_session_id',
    );
  }
}