// lib/models/coffee.dart

import 'product.dart';

class Coffee extends Product {
  // Constructor
  Coffee({
    required String id,
    required String name,
    required double price,
    required String image,
  }) : super(id, name, price, image);

  @override
  String getCategory() => "Coffee";

  // Factory constructor untuk membuat objek Coffee dari Map
  factory Coffee.fromMap(Map<String, dynamic> data) {
    return Coffee(
      id: data['id'],
      name: data['name'],
      // Konversi ke double dengan aman
      price: (data['price'] as num).toDouble(), 
      image: data['image'],
    );
  }
}