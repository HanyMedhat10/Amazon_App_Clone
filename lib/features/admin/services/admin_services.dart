import 'dart:convert';
import 'dart:io';
import 'package:amazon_clone/constant/error_handling.dart';
import 'package:amazon_clone/constant/global_variable.dart';
import 'package:amazon_clone/constant/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class AdminServices {
  void sellProduct ({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images
  })async{
    try{
      var res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'name': name,
          'description': description,
          'quantity': quantity,
          'price': price,
          'category': category
        }),
      );
      httpErrorHandel(
        response: res,
        // ignore: use_build_context_synchronously
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Product Added Successfully');
          Navigator.pop(context);
        },
      );
    }catch(e){
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
  }
}