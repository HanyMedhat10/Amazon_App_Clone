import 'package:amazon_clone/constant/global_variable.dart';
import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  // temporary list orders
  List orders = [
    {
      'id': '1',
      'title': 'black hat',
      'image': 'https://i.ibb.co/cvpntL1/hats.png',
      'price': '\$100',
      'status': 'Completed',
    },
    {
      'id': '1',
      'title': 'black hat',
      'image': 'https://i.ibb.co/cvpntL1/hats.png',
      'price': '\$100',
      'status': 'Completed',
    },
    {
      'id': '1',
      'title': 'black hat',
      'image': 'https://i.ibb.co/cvpntL1/hats.png',
      'price': '\$100',
      'status': 'Completed',
    },
    {
      'id': '1',
      'title': 'black hat',
      'image': 'https://i.ibb.co/cvpntL1/hats.png',
      'price': '\$100',
      'status': 'Completed',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: const Text(
                'Your Orders',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                'See all',
                style: TextStyle(
                  color: GlobalVariables.selectedNavBarColor,
                ),
              ),
            ),
            // display orders
          ],
        ),
        // display orders
        Container(
          height: 170,
          padding: const EdgeInsets.only(
            left: 10,
            top: 20,
            right: 0,
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: orders.length,
            itemBuilder: (context, index) {
              // return Container();
              return SingleProduct(
                image: orders[index]['image'],
              );
            },
          ),
        ),
      ],
    );
  }
}
