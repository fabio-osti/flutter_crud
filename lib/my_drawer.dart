import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, '/');
            },
            child: const Text('Home'),
          ),
          TextButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, '/counter');
            },
            child: const Text('Counter'),
          ),
          TextButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, '/login');
            },
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, '/signup');
            },
            child: const Text('Signup'),
          ),
        ],
      ),
    );
  }
}
