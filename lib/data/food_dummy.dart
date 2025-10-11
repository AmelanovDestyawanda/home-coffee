// Food Product
import 'package:home/models/product.dart';

class FoodProduct extends Product {
  @override
  String image;

  FoodProduct(super.id, super.name, super.price, this.image);

  @override
  String getCategory() => "Food";
}

final foodMenu = [
  FoodProduct("f1", "Brownies", 15000, "assets/images/brownis.jpg"),
  FoodProduct("f2", "Croissant", 18000, "assets/images/croissant.jpg"),
  FoodProduct("f3", "Muffin", 12000, "assets/images/muffin.jpg"),
];