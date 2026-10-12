import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'register_screen.dart';
import 'ui.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  void openRegister() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const PulseLogo(),
              const SizedBox(height: 40),
              const Text(
                'С возвращением',
                style: TextStyle(color: textColor, fontSize: 26, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 6),
              const Text(
                'Войдите, чтобы следить за доступностью сервисов',
                style: TextStyle(color: mutedColor, fontSize: 13),
              ),
              const SizedBox(height: 28),
              AppField(
                label: 'Email',
                hint: 'name@company.kz',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              AppField(
                label: 'Пароль',
                hint: 'Введите пароль',
                controller: passwordController,
                obscure: true,
              ),
              const SizedBox(height: 12),
              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Забыли пароль?',
                  style: TextStyle(color: primaryColor, fontSize: 13),
                ),
              ),
              const SizedBox(height: 24),
              PrimaryButton(text: 'Войти', onPressed: login),
              const SizedBox(height: 20),
              const OrDivider(),
              const SizedBox(height: 20),
              BottomLink(
                text: 'Нет аккаунта? ',
                linkText: 'Зарегистрироваться',
                onTap: openRegister,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
