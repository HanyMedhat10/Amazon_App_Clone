import 'package:amazon_clone/constant/global_variable.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: GlobalVariables.carouselImages.map(
        (image) {
          return Builder(
            builder: (BuildContext context) {
              return Image.network(image, fit: BoxFit.cover, height: 200);
            },
          );
        },
      ).toList(),
      options: CarouselOptions(
        viewportFraction: 1,
        autoPlay: true,
        aspectRatio: 2.0,
        enlargeCenterPage: true,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
      ),
    );
  }
}
