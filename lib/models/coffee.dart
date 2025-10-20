import 'product.dart';

class Coffee extends Product {
  Coffee({
    required String id,
    required String name,
    required double price,
    required String image,
  }) : super(id: id, name: name, price: price, image: image);

  @override
  String getCategory() {
    return 'Coffee';
  }
}