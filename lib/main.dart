import 'package:flutter/material.dart';
import 'package:flutter_crud/authentication.dart';
import 'package:flutter_crud/login.dart';
import 'package:flutter_crud/signup.dart';
import 'counter.dart';
import 'home.dart';

void main() {
  Authentication.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        '/counter': (context) => const Counter(title: 'Counter'),
        '/login': (context) => const Login(),
        '/signup': (context) => const Signup()
      },
    );
  }
}



