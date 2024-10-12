import 'dart:convert';

import 'package:amazon_clone/constant/error_handling.dart';
import 'package:amazon_clone/constant/global_variable.dart';
import 'package:amazon_clone/constant/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CartServices {
  void addToCart({
    required BuildContext context,
    required Product product,
    int quantity = 1,
  }) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.post(
        Uri.parse('$uri/user/add-to-cart'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // ignore: use_build_context_synchronously
          'x-auth-token': userProvider.user.token
        },
        body: jsonEncode(
          {'id': product.id, 'quantity': quantity},
        ),
      );
      httpErrorHandel(
          response: res,
          // ignore: use_build_context_synchronously
          context: context,
          onSuccess: () {
            User user =
                userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
            debugPrint('cart user: ${jsonDecode(res.body)['cart']}');
            userProvider.setUserFromModel(user);
          });
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString(), error: true);
    }
  }

  /* remove from cart  quantity = 1 If not, it decrements the cart quantity by 1 */
  void removeFromCart({
    required BuildContext context,
    required Product product,
  }) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.delete(
        Uri.parse('$uri/user/remove-from-cart/${product.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // ignore: use_build_context_synchronously
          'x-auth-token': userProvider.user.token
        },
        // body: jsonEncode(
        // {'id': product.id},
        // ),
      );
      httpErrorHandel(
          response: res,
          // ignore: use_build_context_synchronously
          context: context,
          onSuccess: () {
            User user =
                userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
            userProvider.setUserFromModel(user);
          });
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString(), error: true);
    }
  }
}
