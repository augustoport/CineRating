import 'package:cinerating/shared/themes/app_colors.dart';
import 'package:cinerating/views/home_page.dart';
import 'package:flutter/material.dart';

import '../controllers/login_controller.dart';
import '../widgets/text_field_custom.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController loginController = LoginController();

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
                  onTap: () {},
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
            onTap: () {},
            child: Container(
              width: size.width * 0.8,
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom + 30,
              ),
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
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
