// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/constant/error_handling.dart';
import 'package:amazon_clone/constant/global_variable.dart';
import 'package:amazon_clone/constant/utils.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        onSuccess: () async {
          showSnackBar(context, 'Account created! Login with same credentials');
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomeScreen.routeName,
            (route) => false,
          );
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

      debugPrint('res: $res');
      httpErrorHandel(
          response: res,
          context: context,
          onSuccess: () async {
            showSnackBar(context, 'Login Successful');
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(res.body);
            await prefs.setString(
                'x-auth-token', jsonDecode(res.body)['token']);
            Navigator.pushNamedAndRemoveUntil(
              context,
              BottomBar.routeName,
              (route) => false,
            );
          });
    } catch (e) {
      showSnackBar(context, e.toString(), error: true);
    }
  }

  // get user data
  void getUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http
          .get(Uri.parse('$uri/auth/tokenIsValid'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token!
      });

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/auth'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          },
        );
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString(), error: true);
    }
  }
}
