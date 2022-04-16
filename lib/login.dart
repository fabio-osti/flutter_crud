import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_crud/authentication.dart';
import 'package:flutter_crud/email_field.dart';
import 'package:flutter_crud/password_field.dart';
import 'package:flutter_crud/show_dialog.dart';
import 'package:http/http.dart' as http;

import 'my_drawer.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwrdController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  submit() async {
    if (formKey.currentState!.validate()) {
      final email = emailController.text;
      final pwrd = pwrdController.text;
      formKey.currentState!.reset();

      final saltResponse = await http.post(
        Uri.parse("https://localhost:7045/user/getsalt"),
        body: email,
        headers: {
          "Accept": "text/plain",
          "Content-Type": "application/json",
        },
      );
      final saltedPwrd = Authentication.hashAndSalt(
        salt: utf8.encode(saltResponse.body),
        password: pwrd,
      );
      
      final login = {
        'email': email,
        'hashedPassword': base64Url.encode(await saltedPwrd),
      };
      final response = await http.post(
        Uri.parse('https://localhost:7045/user/signup'),
        body: jsonEncode(login),
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
          message: "Loged in successfully",
        );
      } else {
        ShowDialog.ok(
          context: context,
          title: "Error",
          message: "Wrong password",
        );
      }
    } else {
      formKey.currentState!.reset();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    pwrdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
                EmailField(controller: emailController),
                PasswordField(controller: pwrdController),
                Container(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Login"),
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
