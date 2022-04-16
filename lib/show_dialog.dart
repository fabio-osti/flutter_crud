import 'package:flutter/material.dart';

class ShowDialog {
  static void ok({required BuildContext context, String? title, String? message}) {
    showDialog<void>(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        title: Text(title ?? 'AlertDialog Title'),
        content: Text(message ?? 'AlertDialog message'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(ctx, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
