// lib/models/food.dart

import 'product.dart';

class Food extends Product {
  // Constructor
  Food({
    required String id,
    required String name,
    required double price,
    required String image,
  }) : super(id, name, price, image);

  @override
  String getCategory() => "Food";

  // Factory constructor untuk membuat objek Food dari Map
  factory Food.fromMap(Map<String, dynamic> data) {
    return Food(
      id: data['id'],
      name: data['name'],
      // Konversi ke double dengan aman
      price: (data['price'] as num).toDouble(),
      image: data['image'],
    );
  }
}