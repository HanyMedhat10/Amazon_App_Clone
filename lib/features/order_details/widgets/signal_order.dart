import 'package:amazon_clone/models/order.dart';
import 'package:flutter/material.dart';

class SignalOrder extends StatelessWidget {
  const SignalOrder({
    super.key,
    required this.order,
    required this.i,
  });

  final Order order;
  final int i;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(
          order.products[i].images[0],
          height: 120,
          width: 120,
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                order.products[i].name,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'Qty: ${order.quantity[i]}',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
