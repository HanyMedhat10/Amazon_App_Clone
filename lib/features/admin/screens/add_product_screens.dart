import 'dart:io';

import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constant/global_variable.dart';
import 'package:amazon_clone/constant/utils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  String category = 'Mobiles';
  List<File> productImages = [];
  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion',
  ];
  void selectImages() async {
    var res = await pickImages();
    debugPrint('res: $res');
    debugPrint('');

    setState(() {
      productImages = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: const Center(
            child: Text(
              'Add Product',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(height: 20),
                productImages.isEmpty
                    ? CarouselSlider(
                        items: productImages.map(
                          (image) {
                            return Builder(
                              builder: (BuildContext context) => Image.file(
                                  image,
                                  fit: BoxFit.cover,
                                  height: 200),
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
                      )
                    : GestureDetector(
                        onTap: selectImages,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                SizedBox(height: 15),
                                Text(
                                  'Select Product Images',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 30),
                CustomTextfield(
                  controller: productNameController,
                  hintText: 'Product Name',
                ),
                const SizedBox(height: 10),
                CustomTextfield(
                  controller: descriptionController,
                  hintText: 'Description',
                  maxLines: 7,
                ),
                const SizedBox(height: 10),
                CustomTextfield(
                  controller: priceController,
                  hintText: 'Price',
                ),
                const SizedBox(height: 10),
                CustomTextfield(
                  controller: quantityController,
                  hintText: 'Quantity',
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      dropdownColor: Colors.white,
                      items: productCategories.map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: category,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      onChanged: (String? value) {
                        setState(
                          () {
                            category = value!;
                          },
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: 'Sell',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
