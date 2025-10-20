// lib/models/coffee.dart

import 'product.dart';

// Coffee adalah 'anak' dari Product
class Coffee extends Product {
  Coffee({
    required String id,
    required String name,
    required double price,
    required String image,
  }) : super(id: id, name: name, price: price, image: image);

  // Memberikan implementasi spesifik untuk getCategory()
  @override
  String getCategory() {
    return 'Coffee';
  }
}