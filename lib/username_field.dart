import 'package:flutter/material.dart';

class UsernameField extends StatelessWidget {
  final TextEditingController controller;

  const UsernameField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      validator: (input) {
        if (input == null) return "NULL";
        if (input.length < 3) return "User must have at least three charachters";
        return null;
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Username',
        icon: Icon(Icons.person),
        hintText: 'Type your username',
      ),
    );
  }
}
