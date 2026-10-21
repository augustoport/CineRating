import 'package:cinerating/shared/themes/app_colors.dart';
import 'package:cinerating/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/login_controller.dart';
import '../widgets/text_field_custom.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController loginController = LoginController();

  @override
  void initState() {
    super.initState();
    loginController.checkExistingSession();
    loginController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    loginController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (loginController.emailController.text.isEmpty ||
        loginController.passwordController.text.isEmpty) {
      setState(() {
        loginController.errorMessage = 'Preencha todos os campos';
      });
      return;
    }

    final success = await loginController.login();

    if (success && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  Future<void> _openTmdbSignup() async {
    final Uri url = Uri.parse('https://www.themoviedb.org/signup');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          Image.asset('assets/img/logo.png'),
          TextFieldCustom(
            controller: loginController.emailController,
            hintText: 'Email',
            onChanged: (value) {},
          ),
          SizedBox(height: 30),
          TextFieldCustom(
            controller: loginController.passwordController,
            hintText: 'Senha',
            onChanged: (value) {},
            isPassword: true,
          ),
          SizedBox(height: 10),
          if (loginController.errorMessage != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                loginController.errorMessage!,
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Não possui conta no TMDB? ",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                InkWell(
                  onTap: _openTmdbSignup,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "Clique aqui",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          InkWell(
            onTap: loginController.isLoading ? null : _handleLogin,
            child: Container(
              width: size.width * 0.8,
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom + 30,
              ),
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: loginController.isLoading
                    ? AppColors.primaryColor.withOpacity(0.5)
                    : AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: loginController.isLoading
                  ? Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ),
                    )
                  : Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
