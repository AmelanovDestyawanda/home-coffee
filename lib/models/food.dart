import 'product.dart';

class Food extends Product {
  String _type;
  String _image;

  Food(String id, String name, double price, this._type, this._image)
      : super(id, name, price, _image);

  String get type => _type;
  @override
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
