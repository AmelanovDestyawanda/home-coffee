abstract class Product {
  String _id;
  String _name;
  double _price;
  String _image;

  Product(this._id, this._name, this._price, this._image);

  // Getter
  String get id => _id;
  String get name => _name;
  double get price => _price;
  String get image => _image;

  get description => null;

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

  static fromMap(Map<String, dynamic> productData) {}
}
