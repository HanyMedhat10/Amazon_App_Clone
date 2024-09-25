import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
            'https://images-eu.ssl-images-amazon.com/images/I/71Swqqe7XAL._AC._SR360,460.jpg',
            height: 235,
            fit: BoxFit.fitHeight,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 15),
          child: const Text(
            '\$100',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
          alignment: Alignment.topLeft,
          child: const Text(
            'Razer Kraken Tournament Edition - Mechanical Gaming Keyboard',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                'https://m.media-amazon.com/images/I/71Swqqe7XAL._AC._SR360,460.jpg',
                fit: BoxFit.fitHeight,
                width: 100,
                height: 100,
              ),
              Image.network(
                'https://m.media-amazon.com/images/I/71Swqqe7XAL._AC._SR360,460.jpg',
                fit: BoxFit.fitHeight,
                width: 100,
                height: 100,
              ),
              Image.network(
                'https://m.media-amazon.com/images/I/71Swqqe7XAL._AC._SR360,460.jpg',
                fit: BoxFit.fitHeight,
                width: 100,
                height: 100,
              ),
              Image.network(
                'https://m.media-amazon.com/images/I/71Swqqe7XAL._AC._SR360,460.jpg',
                fit: BoxFit.fitHeight,
                width: 100,
                height: 100,
              ),
              Image.network(
                'https://m.media-amazon.com/images/I/71Swqqe7XAL._AC._SR360,460.jpg',
                fit: BoxFit.fitHeight,
                width: 100,
                height: 100,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
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
    );
  }
}
