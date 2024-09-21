import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text, {bool error = false}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(
      color: error ? Colors.red : Colors.green,
      fontSize: 16.0,
    ),
  )));
}
