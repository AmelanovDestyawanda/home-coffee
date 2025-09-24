import 'product.dart';

class Order {
  final Product product;
  int _quantity;

  Order(this.product, this._quantity);

  int get quantity => _quantity;

  set quantity(int value) {
    if (value > 0) _quantity = value;
  }

  double get totalPrice => product.price * _quantity;
}
