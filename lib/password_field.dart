import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;

  const PasswordField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Senha',
        border: OutlineInputBorder(),
        icon: Icon(Icons.key),
        hintText: 'Informe a senha',
      ),
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false
    );
  }
}