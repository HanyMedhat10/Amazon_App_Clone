import 'dart:convert';

import 'package:amazon_clone/constant/error_handling.dart';
import 'package:amazon_clone/constant/global_variable.dart';
import 'package:amazon_clone/constant/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../models/product.dart';
import '../../../providers/user_provider.dart';

class SearchService {

   Future<List<Product>> fetchSearchProducts(
      {required BuildContext context, required String searchQuery}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
          Uri.parse('$uri/product/get-products/search/$searchQuery'),
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
}