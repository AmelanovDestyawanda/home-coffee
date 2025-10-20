import 'product.dart';

class Food extends Product {
  Food({
    required String id,
    required String name,
    required double price,
    required String image,
  }) : super(
            id: id,
            name: name,
            price: price,
            image: image,
            description: "Makanan lezat pendamping kopimu.");

  @override
  String getCategory() {
    return 'Food';
  }
}