// lib/models/food.dart

import 'product.dart';

// Food adalah 'anak' dari Product
class Food extends Product {
  Food({
    required String id,
    required String name,
    required double price,
    required String image,
  }) : super(
            id: id,
            name: name,
            price: price,
            image: image,
            description: "Makanan lezat pendamping kopimu."); // Deskripsi default untuk food

  // Memberikan implementasi spesifik untuk getCategory()
  @override
  String getCategory() {
    return 'Food';
  }
}