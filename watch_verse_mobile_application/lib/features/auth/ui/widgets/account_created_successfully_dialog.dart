import 'package:flutter/material.dart';

Future<dynamic> accountCreatedSuccessfullyDialog(
  BuildContext context,
  VoidCallback onPressed,
  String message,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Success", style: TextStyle(color: Colors.green)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: onPressed,
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}
