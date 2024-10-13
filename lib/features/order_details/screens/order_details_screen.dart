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
  int currentStep = 0;
  @override
  void initState() {
    super.initState();
    currentStep = widget.order.status;
  }

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
            const SizedBox(height: 10),
            const Text(
              'Tracking Order',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                ),
              ),
              child: Stepper(
                currentStep: currentStep,
                controlsBuilder: (context, details) {
                  return const SizedBox();
                },
                steps: [
                  Step(
                    title: const Text('Pending'),
                    content: const Text('Your order is yet to delivered'),
                    isActive: currentStep >= 0,
                    state: currentStep >= 0
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: const Text('Completed'),
                    content: const Text(
                        'Your order has been delivered , you are yet to sign.'),
                    isActive: currentStep >= 1,
                    state: currentStep >= 1
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: const Text('Received'),
                    content: const Text(
                        'Your order has been delivered and signed by you.'),
                    isActive: currentStep >= 2,
                    state: currentStep >= 2
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: const Text('Delivered'),
                    content: const Text(
                        'Your order has been delivered and signed by you!'),
                    isActive: currentStep >= 3,
                    state: currentStep >= 3
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
