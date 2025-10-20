// lib/models/product.dart

// Abstract Class sebagai dasar Inheritance
abstract class Product {
  // Properti dibuat private (diawali _)
  String _id;
  String _name;
  double _price;
  String _image;
  String _description;

  // Constructor
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

  // ===== GETTER =====
  // Menyediakan akses read-only ke properti private
  String get id => _id;
  String get name => _name;
  double get price => _price;
  String get image => _image;
  String get description => _description;

  // ===== SETTER =====
  // Menyediakan cara untuk mengubah nilai dengan validasi
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

  // ===== POLYMORPHISM =====
  // Method abstract yang WAJIB di-override oleh kelas anak (subclass)
  String getCategory();
}