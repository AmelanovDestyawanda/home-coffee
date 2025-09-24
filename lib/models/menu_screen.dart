import 'package:flutter/material.dart';
import '../data/coffee.dart';
import '../data/food.dart';
import 'detail_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Daftar produk (dummy data)
    final products = [
      Coffee("C001", "Espresso", 15000, "Small", "assets/images/espresso.png"),
      Coffee(
        "C002",
        "Cappuccino",
        20000,
        "Medium",
        "assets/images/cappuccino.png",
      ),
      Coffee("C003", "Latte", 22000, "Large", "assets/images/latte.png"),
      Food("F001", "Croissant", 12000, "Snack", "assets/images/croissant.png"),
      Food("F002", "Brownies", 18000, "Dessert", "assets/images/brownies.png"),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Menu"), centerTitle: true),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  product is Coffee ? product.image : (product as Food).image,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                product.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                "${product.getCategory()} • Rp ${product.price.toStringAsFixed(0)}",
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailScreen(product: product, image: null,),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
