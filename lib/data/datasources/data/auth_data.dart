import '../../../domain/entities/user.dart';

abstract class AuthData {
  Future<User> login({required String username, required String password});
  Future<User> getAccountDetails(String sessionId);
}
