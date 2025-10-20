// lib/data/food_dummy.dart

import 'package:home/models/product.dart';

class FoodProduct extends Product {
  // 'image' sudah ada di class Product, jadi tidak perlu ditulis ulang.
  // Constructor di bawah ini sudah diperbaiki agar sesuai dengan parent class.
  FoodProduct(super.id, super.name, super.price, super.image);

  @override
  String getCategory() => "Food";
}

final foodMenu = [
  FoodProduct("f1", "Brownies", 15000, "assets/images/brownis.jpg"),
  FoodProduct("f2", "Croissant", 18000, "assets/images/croissant.jpg"),
  FoodProduct("f3", "Muffin", 12000, "assets/images/muffin.jpg"),
];