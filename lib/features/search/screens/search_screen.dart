import 'package:amazon_clone/common/widgets/custom_app_bar_search.dart';
import 'package:amazon_clone/features/home/widgets/address_box.dart';
import 'package:amazon_clone/features/product_details/screens/product_detail_screen.dart';
import 'package:amazon_clone/features/search/services/search_service.dart';
import 'package:amazon_clone/features/search/widget/search_product.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search';
  final String searchQuery;
  const SearchScreen({super.key, required this.searchQuery});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchService searchService = SearchService();
  List<Product>? products;
  @override
  void initState() {
    super.initState();
    fetchSearchProducts(context: context, searchQuery: widget.searchQuery);
  }

  Future<void> fetchSearchProducts(
      {required BuildContext context, required String searchQuery}) async {
    products = await searchService.fetchSearchProducts(
        context: context, searchQuery: searchQuery);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarSearch(
        context,
      ),
      body: products == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const AddressBox(),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: products!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ProductDetailScreen.routeName,
                            arguments: products![index],
                          );
                        },
                        child: SearchProduct(
                          product: products![index],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
