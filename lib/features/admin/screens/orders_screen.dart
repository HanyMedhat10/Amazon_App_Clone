import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/features/order_details/screens/order_details_screen.dart';
import 'package:flutter/material.dart';

import '../../../models/order.dart';

class OrdersScreen extends StatefulWidget {
  static const String routeName = '/orders-screen';
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrdersScreen> {
  final AdminServices adminServices = AdminServices();
  List<Order>? orders = [];
  @override
  void initState() {
    super.initState();
    fetchAllOrders();
  }

  void fetchAllOrders() async {
    orders = await adminServices.fetchAllOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Center(child: CircularProgressIndicator())
        : GridView.builder(
            itemCount: orders!.length,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  // navigate to order details
                  Navigator.pushNamed(
                    context,
                    OrderDetailsScreen.routerName,
                    arguments: orders![index],
                  );
                },
                child: SizedBox(
                  height: 140,
                  child: SingleProduct(
                      image: orders![index].products[0].images[0]),
                ),
              );
            },
          );
  }
}
