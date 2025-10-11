// lib/provider/user_provider.dart

import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String _userName = "Coffee Lover"; // Nama default

  String get userName => _userName;

  void updateUser(String newName) {
    _userName = newName.isNotEmpty ? newName : "Coffee Lover";
    notifyListeners();
  }
}