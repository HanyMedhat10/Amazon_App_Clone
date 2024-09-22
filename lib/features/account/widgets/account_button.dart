// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AccountButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const AccountButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        // border: Border.all(
        //   color: Colors.black12,
        //   width: 1.0,
        // ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: OutlinedButton(
        style: ElevatedButton.styleFrom(
          side: BorderSide(
            color: Colors.black12.withOpacity(0.2),
            width: 1.0,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(5),
            // ),
          ),
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
