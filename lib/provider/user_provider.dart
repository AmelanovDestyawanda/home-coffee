import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _userName = "Coffee Lover";
  String _userEmail = "user@brewverse.com";

  String get userName => _userName;
  String get userEmail => _userEmail;

  void updateUser(String newName, String newEmail) {
    _userName = newName.isNotEmpty ? newName : "Coffee Lover";
    _userEmail = newEmail.isNotEmpty ? newEmail : "user@brewverse.com";
    notifyListeners();
  }
}