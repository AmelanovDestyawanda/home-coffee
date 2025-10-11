import 'package:flutter/material.dart';
import 'package:home/models/cart_item.dart';
import 'package:home/models/product.dart';

class CartProvider with ChangeNotifier {
  // Menggunakan Map untuk menyimpan item dengan ID produk sebagai kunci
  final Map<String, CartItem> _cartItems = {};

  Map<String, CartItem> get cartItems => {..._cartItems};

  int get itemCount {
    return _cartItems.length;
  }

  void addToCart(Product product) {
    if (_cartItems.containsKey(product.id)) {
      // Jika produk sudah ada, tambah kuantitasnya
      _cartItems.update(
        product.id,
        (existingItem) => CartItem(
          product: existingItem.product,
          quantity: existingItem.quantity + 1,
        ),
      );
    } else {
      // Jika produk baru, tambahkan ke keranjang
      _cartItems.putIfAbsent(
        product.id,
        () => CartItem(product: product),
      );
    }
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_cartItems.containsKey(productId)) return;

    if (_cartItems[productId]!.quantity > 1) {
      // Jika kuantitas lebih dari 1, kurangi saja
      _cartItems.update(
        productId,
        (existingItem) => CartItem(
          product: existingItem.product,
          quantity: existingItem.quantity - 1,
        ),
      );
    } else {
      // Jika kuantitas hanya 1, hapus dari keranjang
      _cartItems.remove(productId);
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  double get totalPrice {
    var total = 0.0;
    _cartItems.forEach((key, cartItem) {
      total += cartItem.product.price * cartItem.quantity;
    });
    return total;
  }
}