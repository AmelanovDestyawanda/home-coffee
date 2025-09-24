import 'product.dart';

class Coffee extends Product {
  String _size; 
  String _image;

  Coffee(super.id, super.name, super.price, this._size, this._image);

  String get size => _size;
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
