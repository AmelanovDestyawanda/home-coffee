// lib/data/bestseller_dummy.dart

import '../models/product.dart';
import 'coffe_dummy.dart';
import 'food_dummy.dart';

// List ini bisa berisi campuran objek Coffee dan Food (Polymorphism)
final List<Product> bestSeller = [
  coffeeMenu[1], // Cappuccino
  foodMenu[0],   // Croissant
  coffeeMenu[4], // Americano
  foodMenu[2],   // Muffin
];