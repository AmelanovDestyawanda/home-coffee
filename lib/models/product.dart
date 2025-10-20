abstract class Product {

  String _id;
  String _name;
  double _price;
  String _image;
  String _description;

  Product({
    required String id,
    required String name,
    required double price,
    required String image,
    String description = "Minuman kopi spesial untuk harimu.",
  })  : _id = id,
        _name = name,
        _price = price,
        _image = image,
        _description = description;

  String get id => _id;
  String get name => _name;
  double get price => _price;
  String get image => _image;
  String get description => _description;

  set name(String value) {
    if (value.isNotEmpty) {
      _name = value;
    }
  }
  set price(double value) {
    if (value > 0) {
      _price = value;
    }
  }
  String getCategory();
}