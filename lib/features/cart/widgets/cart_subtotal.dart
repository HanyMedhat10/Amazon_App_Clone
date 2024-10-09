import 'package:flutter/material.dart';

class CartSubtotal extends StatelessWidget {
  const CartSubtotal({super.key, required this.sum});
  final int sum;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Text(
            "Cart subtotal",
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(width: 5),
          Text(
            '\$ $sum',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          // backgroundColor: Colors.lightBlue,

          /* const Spacer(),
          Expanded(
            child: SizedBox(
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {},
                child: const Text(
                  "Check out",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ), */
        ],
      ),
    );
  }
}
