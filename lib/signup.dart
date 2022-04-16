import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cryptography/cryptography.dart';
import 'package:flutter_crud/show_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_crud/authentication.dart';
import 'package:flutter_crud/email_field.dart';
import 'package:flutter_crud/password_field.dart';
import 'package:flutter_crud/username_field.dart';
import 'package:flutter_crud/my_drawer.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final pwrdController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    pwrdController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  submit() async {
    if (formKey.currentState!.validate()) {
      final email = emailController.text;
      final pwrd = pwrdController.text;
      final username = usernameController.text;
      formKey.currentState!.reset();

      final random = Random.secure();
      final salt = List<int>.generate(24, (i) => random.nextInt(256));
      final saltedPwrd = Authentication.hashAndSalt(
        salt: salt,
        password: pwrd,
      );
      final user = {
        'username': username,
        'email': email,
        'salt': base64Url.encode(salt),
        'password': base64Url.encode(await saltedPwrd),
      };
      final response = await http.post(
        Uri.parse('https://localhost:7045/user/signup'),
        body: jsonEncode(user),
        headers: {
          "Accept": "text/plain",
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        Authentication.setUser(response.body);
        ShowDialog.ok(
          context: context,
          title: "Success",
          message: "User successfully registered",
        );
      } else {
        ShowDialog.ok(
          context: context,
          title: "Error",
          message: "Email already registered",
        );
      }
    } else {
      formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
      ),
      drawer: const MyDrawer(),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(minWidth: 200, maxWidth: 400),
          margin: const EdgeInsets.all(8),
          child: Form(
            key: formKey,
            child: Wrap(
              direction: Axis.horizontal,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: <Widget>[
                UsernameField(controller: usernameController,),
                EmailField(controller: emailController,),
                PasswordField(controller: pwrdController,),
                Container(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: submit,
                    child: const Text("Signup"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
