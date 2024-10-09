import 'package:amazon_clone/common/widgets/custom_app_bar_search.dart';
import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/features/address/screens/address_screen.dart';
import 'package:amazon_clone/features/cart/widgets/cart_product.dart';
import 'package:amazon_clone/features/cart/widgets/cart_subtotal.dart';
import 'package:amazon_clone/features/home/widgets/address_box.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navigateToAddressScreen(int sum) {
    Navigator.pushNamed(context, AddressScreen.routeName,
        arguments: sum.toString());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map(
          (e) => sum += e['quantity'] * e['product']['price'] as int,
        )
        .toList();
    return Scaffold(
      appBar: CustomAppBarSearch(context),
      body: Column(
        children: [
          const AddressBox(),
          const SizedBox(height: 10),
          CartSubtotal(
            sum: sum,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              text: 'Proceed to Buy (${user.cart.length} items)',
              onPressed: () => navigateToAddressScreen(sum),
              backgroundColor: Colors.yellow.shade600,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            color: Colors.black12.withOpacity(0.08),
            height: 1,
            width: double.infinity,
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: user.cart.length,
              itemBuilder: (context, index) {
                return CartProduct(
                  index: index,
                );
              },
            ),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
