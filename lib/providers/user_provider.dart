import 'package:amazon_clone/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
late User _user = User(
  id: '',
  name: '',
  email: '',
  password: '',
  type: '',
  token: '',
  address: '',
);
User get user => _user;
void setUser (String user) {
  _user = User.fromJson(user);
  notifyListeners();
}

}