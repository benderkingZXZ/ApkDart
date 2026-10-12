import 'package:flutter/material.dart';

const Color bgColor = Color(0xFF0A0D1A);
const Color cardColor = Color(0xFF111528);
const Color fieldColor = Color(0xFF141829);
const Color borderColor = Color(0xFF1E2338);
const Color primaryColor = Color(0xFF5169EE);
const Color secondaryButtonColor = Color(0xFF171B30);
const Color textColor = Color(0xFFFFFFFF);
const Color mutedColor = Color(0xFF8A90A8);
const Color greenColor = Color(0xFF3ED598);
const Color yellowColor = Color(0xFFF5B83D);
const Color redColor = Color(0xFFF0605D);

OutlineInputBorder fieldBorder(Color color) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: color),
  );
}

class PulseLogo extends StatelessWidget {
  const PulseLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.radio_button_checked, color: textColor, size: 22),
        ),
        const SizedBox(width: 12),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pulse',
              style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.w700),
            ),
            Text(
              'Мониторинг API и сервисов',
              style: TextStyle(color: mutedColor, fontSize: 11),
            ),
          ],
        ),
      ],
    );
  }
}

class AppField extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final bool obscure;
  final TextInputType keyboardType;

  const AppField({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.obscure = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: mutedColor, fontSize: 12)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboardType,
          style: const TextStyle(color: textColor, fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: mutedColor, fontSize: 14),
            filled: true,
            fillColor: fieldColor,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            border: fieldBorder(borderColor),
            enabledBorder: fieldBorder(borderColor),
            focusedBorder: fieldBorder(primaryColor),
          ),
        ),
      ],
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool secondary;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.secondary = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: secondary ? secondaryButtonColor : primaryColor,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(color: borderColor, height: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text('или', style: TextStyle(color: mutedColor, fontSize: 12)),
        ),
        Expanded(child: Divider(color: borderColor, height: 1)),
      ],
    );
  }
}

class BottomLink extends StatelessWidget {
  final String text;
  final String linkText;
  final VoidCallback onTap;

  const BottomLink({
    super.key,
    required this.text,
    required this.linkText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text, style: const TextStyle(color: mutedColor, fontSize: 13)),
        GestureDetector(
          onTap: onTap,
          child: Text(
            linkText,
            style: const TextStyle(
              color: primaryColor,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
