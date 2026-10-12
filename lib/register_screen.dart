import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'ui.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  bool agree = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  void goBack() {
    Navigator.of(context).pop();
  }

  void register() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: goBack,
                icon: const Icon(Icons.chevron_left, size: 28),
              ),
              const SizedBox(height: 8),
              const PulseLogo(),
              const SizedBox(height: 20),
              const Text(
                'Создать аккаунт',
                style: TextStyle(color: textColor, fontSize: 24, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 6),
              const Text(
                'Начните следить за доступностью сервисов за пару минут',
                style: TextStyle(color: mutedColor, fontSize: 13),
              ),
              const SizedBox(height: 20),
              AppField(
                label: 'Имя',
                hint: 'Ваше имя',
                controller: nameController,
              ),
              const SizedBox(height: 14),
              AppField(
                label: 'Email',
                hint: 'name@company.kz',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 14),
              AppField(
                label: 'Пароль',
                hint: 'Минимум 8 символов',
                controller: passwordController,
                obscure: true,
              ),
              const SizedBox(height: 14),
              AppField(
                label: 'Повторите пароль',
                hint: 'Повторите пароль',
                controller: confirmController,
                obscure: true,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Checkbox(
                    value: agree,
                    onChanged: (value) => setState(() => agree = value ?? false),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                  const SizedBox(width: 6),
                  const Expanded(
                    child: Wrap(
                      children: [
                        Text(
                          'Я согласен с ',
                          style: TextStyle(color: mutedColor, fontSize: 12),
                        ),
                        Text(
                          'условиями использования',
                          style: TextStyle(color: primaryColor, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              PrimaryButton(text: 'Зарегистрироваться', onPressed: register),
              const SizedBox(height: 20),
              const OrDivider(),
              const SizedBox(height: 20),
              BottomLink(
                text: 'Уже есть аккаунт? ',
                linkText: 'Войти',
                onTap: goBack,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
