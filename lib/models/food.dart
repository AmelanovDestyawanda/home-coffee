import 'product.dart';

class Food extends Product {
  String _type; 
  String _image;

  Food(super.id, super.name, super.price, this._type, this._image);

  String get type => _type;
  String get image => _image;

  set type(String value) {
    if (value.isNotEmpty) _type = value;
  }

  set image(String value) {
    if (value.isNotEmpty) _image = value;
  }

  @override
  String getCategory() => "Food";
}
