import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  final HomeServices homeServices = HomeServices();
  Product? product;
  @override
  void initState() {
    super.initState();
    fetchDealOfDay();
  }

  void fetchDealOfDay() async {
    product = await homeServices.fetchDealOfDay(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : product!.name.isEmpty
            ? const SizedBox()
            : GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/product-details',
                  arguments: product,
                );
              },
              child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 15, top: 15),
                      child: const Text(
                        'Deal of the Day',
                        style: TextStyle(
                          fontSize: 22,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      child: Image.network(
                        product!.images[0],
                        height: 235,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        '\$${product!.price}',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                      alignment: Alignment.topLeft,
                      child: Text(
                        product!.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: product!.images.map((e) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Image.network(
                                e,
                                fit: BoxFit.fitWidth,
                                width: 100,
                                height: 100,
                              ),
                            );
                          }).toList()),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'See all deals',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.cyan[800],
                        ),
                      ),
                    ),
                  ],
                ),
            );
  }
}
