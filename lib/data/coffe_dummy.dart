// Coffee Product
import 'package:home/models/product.dart';

class CoffeeProduct extends Product {
  @override
  String image;

  CoffeeProduct(super.id, super.name, super.price, this.image);

  @override
  String getCategory() => "Coffee";
}

// ================= Dummy Data =================
final coffeeMenu = [
  CoffeeProduct("c1", "Latte", 28000, "assets/images/latte.jpg"),
  CoffeeProduct("c2", "Cappuccino", 25000, "assets/images/cappucino.jpg"),
  CoffeeProduct("c3", "Americano", 22000, "assets/images/amer.jpg"),
];