import 'package:flutter/material.dart';

import '../core/services/auth_service.dart';
import '../models/user_model.dart';
import '../shared/env.dart';

class LoginController extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  String? errorMessage;
  User? currentUser;

  late final AuthService _authService;

  LoginController() {
    _authService = AuthService(accessToken: Environment.production.token);
  }

  Future<bool> login() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final user = await _authService.login(
        username: emailController.text,
        password: passwordController.text,
      );

      currentUser = user;
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = 'Erro ao fazer login: ${e.toString()}';
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> checkExistingSession() async {
    try {
      final user = await _authService.getCurrentUser();
      if (user != null) {
        currentUser = user;
        notifyListeners();
      }
    } catch (e) {
      // Ignora erros ao verificar sessão existente
    }
  }

  Future<void> logout() async {
    await _authService.clearSession();
    currentUser = null;
    emailController.clear();
    passwordController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
