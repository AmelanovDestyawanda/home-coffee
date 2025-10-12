import 'package:home/models/product.dart';

class Coffee extends Product {
  String _size;
  String _image;

  Coffee(String id, String name, double price, this._size, this._image)
      : super(id, name, price, _image);

  String get size => _size;
  @override
  String get image => _image;

  set size(String value) {
    if (value.isNotEmpty) _size = value;
  }

  set image(String value) {
    if (value.isNotEmpty) _image = value;
  }

  @override
  String getCategory() => "Coffee";
}
