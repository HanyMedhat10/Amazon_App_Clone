import 'dart:convert';

import 'package:amazon_clone/constant/error_handling.dart';
import 'package:amazon_clone/constant/global_variable.dart';
import 'package:amazon_clone/constant/utils.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AccountServices {
  Future<List<Order>> fetchMyOrders({required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    List<Order> orderList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/user/me-orders'), headers: <String, String>{
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
              orderList.add(
                Order.fromJson(
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
    return orderList;
  }
}
