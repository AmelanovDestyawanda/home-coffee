import 'package:home/models/product.dart';

class CoffeeProduct extends Product {
  CoffeeProduct(super.id, super.name, super.price, super.image);

  @override
  String getCategory() => "Coffee";
}

final coffeeMenu = [
  CoffeeProduct("c1", "Latte", 28000, "assets/images/latte.jpg"),
  CoffeeProduct("c2", "Cappuccino", 25000, "assets/images/cappucino.jpg"),
  CoffeeProduct("c3", "Americano", 22000, "assets/images/amer.jpg"),
];