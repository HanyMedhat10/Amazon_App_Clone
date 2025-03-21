import 'dart:convert';

import 'package:amazon_clone/constant/error_handling.dart';
import 'package:amazon_clone/constant/global_variable.dart';
import 'package:amazon_clone/constant/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProductDetailsServices {
  void rateProduct({
    required BuildContext context,
    required Product product,
    required double rating,
  }) async {
    try {
      final userProvider =
          Provider.of<UserProvider>(context, listen: false).user;
      http.Response res = await http.post(
        Uri.parse('$uri/product/rate-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // ignore: use_build_context_synchronously
          'x-auth-token': userProvider.token
        },
        body: jsonEncode(
          {'productId': product.id, 'rating': rating},
        ),
      );
      httpErrorHandel(
          response: res,
          // ignore: use_build_context_synchronously
          context: context,
          onSuccess: () {});
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString(), error: true);
    }
  }
}
