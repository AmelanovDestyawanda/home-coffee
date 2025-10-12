// Abstract Product
abstract class Product {
  String _id;
  String _name;
  double _price;

  Product(this._id, this._name, this._price, String item);

  // Getter
  String get id => _id;
  String get name => _name;
  double get price => _price;

  String? get image => null;

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