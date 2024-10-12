import 'package:amazon_clone/common/widgets/custom_app_bar_search.dart';
import 'package:amazon_clone/features/order_details/widgets/signal_order.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const routerName = '/order-details';
  final Order order;
  const OrderDetailsScreen({super.key, required this.order});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarSearch(
        context,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'View order details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order Date:${DateFormat().format(
                    DateTime.fromMillisecondsSinceEpoch(widget.order.orderedAt),
                  )}'),
                  Text('Order ID:          ${widget.order.id}'),
                  Text('Order Total:      \$${widget.order.totalPrice}'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Purchase Details',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                ),
              ),
              child: Column(
                children: [
                  for (int i = 0; i < widget.order.products.length; i++)
                    SignalOrder(order: widget.order, i: i),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
