import 'dart:convert';

import 'package:amazon_clone/constant/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandel(
    {required http.Response response,
    required BuildContext context,
    required VoidCallback onSuccess}) {
  switch (response.statusCode) {
    case 200:
    case 201:
    case 204:
      onSuccess();
      break;
    case 400:
    case 401:
    case 402:
    case 403:
    case 404:
    case 409:
    case 422:
    showSnackBar(context, jsonDecode(response.body)['error'], error: true);
      break;
    case 500:
    showSnackBar(context, jsonDecode(response.body)['error'], error: true);
      break;
    default:
    showSnackBar(context, jsonDecode(response.body), error: true);
      break;
  }
}
