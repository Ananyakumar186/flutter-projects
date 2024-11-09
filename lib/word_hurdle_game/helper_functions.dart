import 'package:flutter/material.dart';

void showResult(
    {required BuildContext context,
    required String title,
    required String body,
    required VoidCallback onPLayAgain,
    required VoidCallback onCancel}) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(body),
            actions: [
              TextButton(onPressed: onCancel, child: const Text('QUIT')),
              TextButton(onPressed: onPLayAgain, child: const Text('PLAY AGAIN'))
            ],
          ));
}

void showMessage({required BuildContext context, required String msg}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}
