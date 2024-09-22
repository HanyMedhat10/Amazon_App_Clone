import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text, {bool error = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: error ? Colors.red : Colors.green,
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
    ),
  );
}
