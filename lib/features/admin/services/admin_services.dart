import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/constant/error_handling.dart';
import 'package:amazon_clone/constant/global_variable.dart';
import 'package:amazon_clone/constant/utils.dart';
import 'package:amazon_clone/features/admin/model/sales.dart';
import 'package:amazon_clone/models/order.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required num price,
    required num quantity,
    required String category,
    required List<File> images,
  }) async {
    try {
      final userProvider =
          Provider.of<UserProvider>(context, listen: false).user;
      final cloudinary =
          CloudinaryPublic(dotenv.get('cloudName'), dotenv.get('uploadPreset'));
      List<String> imageUrls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(res.secureUrl);
      }
      Product product = Product(
        name: name,
        description: description,
        price: price,
        quantity: quantity,
        category: category,
        images: imageUrls,
        // ignore: use_build_context_synchronously
        // userId: Provider.of<UserProvider>(context).user.id
      );
      http.Response res = await http.post(Uri.parse('$uri/admin/add-product'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            // ignore: use_build_context_synchronously
            'x-auth-token': userProvider.token
          },
          body: product.toJson());
      httpErrorHandel(
          response: res,
          // ignore: use_build_context_synchronously
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Product Added Successfully');
            Navigator.pop(context);
          });
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString(), error: true);
    }
  }

  // get all the products
  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    List<Product> productList = [];
    try {
      final userProvider =
          Provider.of<UserProvider>(context, listen: false).user;
      http.Response res = await http
          .get(Uri.parse('$uri/admin/get-products'), headers: <String, String>{
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

  Future<List<Order>> fetchAllOrders({required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    List<Order> orderList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/admin/get-orders'), headers: <String, String>{
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

  Future<Map<String, dynamic>> getEarnings(
      {required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false).user;
    List<Sales> sales = [];
    int totalEarnings = 0;
    const categories = [
      "Mobiles",
      "Essentials",
      "Appliances",
      "Books",
      "Fashion",
    ];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/admin/analytics'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // ignore: use_build_context_synchronously
        'x-auth-token': userProvider.token
      });
      httpErrorHandel(
          response: res,
          // ignore: use_build_context_synchronously
          context: context,
          onSuccess: () {
            var response = jsonDecode(res.body);
            totalEarnings = response['totalEarnings'];
            for (var element in categories) {
              sales.add(Sales(
                label: element,
            // because the response have not all categories
                earning: response[element] ?? 0,
              ));
            }
          });
    } catch (e) {
      debugPrint(e.toString());
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString(), error: true);
    }
    return {'sales': sales, 'totalEarnings': totalEarnings};
  }

  void updateOrderStatus({
    required BuildContext context,
    required int status,
    required Order order,
    required VoidCallback onSuccess,
  }) async {
    try {
      final userProvider =
          Provider.of<UserProvider>(context, listen: false).user;
      http.Response res =
          await http.patch(Uri.parse('$uri/admin/update-order/${order.id}'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                // ignore: use_build_context_synchronously
                'x-auth-token': userProvider.token
              },
              body: jsonEncode({
                'status': status,
              }));
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
