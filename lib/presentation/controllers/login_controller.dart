import 'package:flutter/material.dart';

import '../../../core/locator.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/get_current_user_usecase.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../../../domain/usecases/logout_usecase.dart';

class LoginController extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  User? currentUser;

  final LoginUseCase _loginUseCase = getIt<LoginUseCase>();
  final GetCurrentUserUseCase _getCurrentUserUseCase = getIt<GetCurrentUserUseCase>();
  final LogoutUseCase _logoutUseCase = getIt<LogoutUseCase>();

  Future<bool> login() async {
    isLoading = true;
    notifyListeners();

    try {
      final user = await _loginUseCase(
        username: emailController.text,
        password: passwordController.text,
      );

      currentUser = user;
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> checkExistingSession() async {
    final user = await _getCurrentUserUseCase();
    if (user != null) {
      currentUser = user;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _logoutUseCase();
    currentUser = null;
    emailController.clear();
    passwordController.clear();
    notifyListeners();
  }
}
