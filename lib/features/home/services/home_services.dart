import 'dart:convert';

import 'package:amazon_clone/constant/error_handling.dart';
import 'package:amazon_clone/constant/global_variable.dart';
import 'package:amazon_clone/constant/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeServices {
  Future<List<Product>> fetchCategoryProducts(
      {required BuildContext context, required String category}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
          Uri.parse('$uri/product/get-products?category=$category'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            // ignore: use_build_context_synchronously
            'x-auth-token': userProvider.token
          });
      httpErrorHandel(
          response: res,
          // ignore: use_build_context_synchronously
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productList.add(
                Product.fromJson(
                  jsonEncode(jsonDecode(res.body)[i]),
                ),
              );
            }
          });
    } catch (e) {
      debugPrint(e.toString());
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString(), error: true);
    }
    return productList;
  }

  Future<Product> fetchDealOfDay({required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    Product product = Product(
      name: '',
      description: '',
      quantity: 0,
      images: [],
      category: '',
      price: 0,
    );
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/product/deal-of-day'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // ignore: use_build_context_synchronously
        'x-auth-token': userProvider.token
      });
      httpErrorHandel(
          response: res,
          // ignore: use_build_context_synchronously
          context: context,
          onSuccess: () {
            product = Product.fromJson(res.body);
          });
    } catch (e) {
      debugPrint(e.toString());
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString(), error: true);
    }
    return product;
  }
}
