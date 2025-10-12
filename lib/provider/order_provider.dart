import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class Order {
  final String id;
  final List<CartItem> items;
  final double total;
  final DateTime date;

  Order({required this.id, required this.items, required this.total, required this.date});
}

class OrderProvider with ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  void addOrder(List<CartItem> cartItems, double total) {
    final newOrder = Order(
      id: DateTime.now().toString(),
      items: cartItems,
      total: total,
      date: DateTime.now(),
    );
    _orders.insert(0, newOrder);
    notifyListeners();
  }
}