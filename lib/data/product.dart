// Abstract Product
abstract class Product {
  String _id;
  String _name;
  double _price;

  Product(this._id, this._name, this._price);

  // Getter
  String get id => _id;
  String get name => _name;
  double get price => _price;

  // Setter
  set id(String value) {
    if (value.isNotEmpty) _id = value;
  }

  set name(String value) {
    if (value.isNotEmpty) _name = value;
  }

  set price(double value) {
    if (value > 0) _price = value;
  }

  // Polymorphism
  String getCategory();
}

// Coffee Product
class CoffeeProduct extends Product {
  String image;

  CoffeeProduct(super.id, super.name, super.price, this.image);

  @override
  String getCategory() => "Coffee";
}

// Food Product
class FoodProduct extends Product {
  String image;

  FoodProduct(super.id, super.name, super.price, this.image);

  @override
  String getCategory() => "Food";
}

// ================= Dummy Data =================
final coffeeMenu = [
  CoffeeProduct("c1", "Latte", 28000, "assets/images/latte.jpg"),
  CoffeeProduct("c2", "Cappuccino", 25000, "assets/images/cappucino.jpg"),
  CoffeeProduct("c3", "Americano", 22000, "assets/images/amer.jpg"),
];

final foodMenu = [
  FoodProduct("f1", "Brownies", 15000, "assets/images/brownis.jpg"),
  FoodProduct("f2", "Croissant", 18000, "assets/images/croissant.jpg"),
  FoodProduct("f3", "Muffin", 12000, "assets/images/muffin.jpg"),
];
