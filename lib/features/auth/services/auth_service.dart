import 'dart:convert';

import 'package:amazon_clone/constant/error_handling.dart';
import 'package:amazon_clone/constant/global_variable.dart';
import 'package:amazon_clone/constant/utils.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService {
  // sign up user
  Future<void> signUpUser({
    required String name,
    required String email,
    required String password,
    String? type,
    required BuildContext context,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        type: type ?? '',
        token: '',
      );

      http.Response res = await http.post(
        Uri.parse('$uri/auth/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      debugPrint('res: $res');
      httpErrorHandel(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Account created! Login with same credentials');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString(), error: true);
    }
  }

  // sign in user
  Future<void> signInUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/auth/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandel(response: res, context: context, onSuccess: () async {
        showSnackBar(context, 'Login Successful');
        
      });
    } catch (e) {
      showSnackBar(context, e.toString(), error: true);
    }
  }
}
