import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  const CustomButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: backgroundColor,
      ),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 17,
            color: backgroundColor == null ? Colors.white : Colors.black),
      ),
    );
  }
}
