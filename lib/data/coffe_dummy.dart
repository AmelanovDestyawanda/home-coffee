// lib/data/coffe_dummy.dart

import 'package:home/models/product.dart';

class CoffeeProduct extends Product {
  CoffeeProduct(String id, String name, double price, String image)
      : super(id, name, price, image);

  @override
  String getCategory() => "Coffee";
}


// ================= Dummy Data =================
final coffeeMenu = [
  CoffeeProduct("c1", "Latte", 28000, "assets/images/latte.jpg"),
  CoffeeProduct("c2", "Cappuccino", 25000, "assets/images/cappucino.jpg"),
  CoffeeProduct("c3", "Americano", 22000, "assets/images/amer.jpg"),
];