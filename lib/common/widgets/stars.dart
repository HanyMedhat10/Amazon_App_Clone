import 'package:amazon_clone/constant/global_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Stars extends StatelessWidget {
  final double rating;
  const Stars({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      direction: Axis.horizontal,
      rating: rating,
      itemCount: 5,
      itemSize: 15,
      itemBuilder: (BuildContext context, int index) {
        return const Icon(
          Icons.star,
          color: GlobalVariables.secondaryColor,
        );
      },
    );
  }
}
