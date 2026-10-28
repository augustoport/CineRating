import 'package:flutter/material.dart';

import '../../../core/locator.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/login_usecase.dart';

class LoginController extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  User? currentUser;

  final LoginUseCase _loginUseCase = getIt<LoginUseCase>();

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
    // TODO: Implementar use case para getCurrentUser
    // Por enquanto, manter sessão vazia
  }

  Future<void> logout() async {
    // TODO: Implementar use case para logout
    currentUser = null;
    emailController.clear();
    passwordController.clear();
    notifyListeners();
  }
}
