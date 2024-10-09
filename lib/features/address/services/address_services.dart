import 'dart:convert';

import 'package:amazon_clone/constant/error_handling.dart';
import 'package:amazon_clone/constant/global_variable.dart';
import 'package:amazon_clone/constant/utils.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AddressServices {
  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res =
          await http.post(Uri.parse('$uri/user/save-user-address'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                // ignore: use_build_context_synchronously
                'x-auth-token': userProvider.user.token
              },
              body: jsonEncode({
                'address': address,
              }));
      httpErrorHandel(
          response: res,
          // ignore: use_build_context_synchronously
          context: context,
          onSuccess: () {
            User user = userProvider.user
                .copyWith(address: jsonDecode(res.body)['address']);
            userProvider.setUserFromModel(user);
          });
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString(), error: true);
    }
  }

  // get all the products
  void placeOrder(
      {required BuildContext context,
      required String address,
      required double totalSum}) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      http.Response res = await http.post(Uri.parse('$uri/user/order'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            // ignore: use_build_context_synchronously
            'x-auth-token': userProvider.user.token
          },
          body: jsonEncode({
            'cart': userProvider.user.cart,
            'address': address,
            'totalPrice': totalSum
          }));
      httpErrorHandel(
          response: res,
          // ignore: use_build_context_synchronously
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Your order has been placed!');
            User user = userProvider.user.copyWith(cart: []);
            userProvider.setUserFromModel(user);
            // Navigator.pop(context);
          });
    } catch (e) {
      debugPrint(e.toString());
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString(), error: true);
    }
  }

  // delete product
  void deleteProduct({
    required BuildContext context,
    required String id,
    required VoidCallback onSuccess,
  }) async {
    try {
      final userProvider =
          Provider.of<UserProvider>(context, listen: false).user;
      http.Response res = await http.delete(
          Uri.parse('$uri/admin/delete-product/$id'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            // ignore: use_build_context_synchronously
            'x-auth-token': userProvider.token
          });
      httpErrorHandel(
        response: res,
        // ignore: use_build_context_synchronously
        context: context,
        onSuccess: onSuccess,
      );
    } catch (e) {
      debugPrint(e.toString());
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString(), error: true);
    }
  }
}
