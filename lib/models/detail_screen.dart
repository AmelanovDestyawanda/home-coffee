import 'package:brew_verse/data/order.dart';
import 'package:brew_verse/models/cart_screen.dart';
import 'package:flutter/material.dart';
import '../data/product.dart';
import '../data/coffee.dart';
import '../data/food.dart';

class DetailScreen extends StatelessWidget {
  final Product product;

  const DetailScreen({super.key, required this.product, required image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Gambar Produk
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                product is Coffee
                    ? (product as Coffee).image
                    : (product as Food).image,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),

            // Nama Produk
            Text(
              product.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            // Kategori + Harga
            Text(
              "${product.getCategory()} • Rp ${product.price.toStringAsFixed(0)}",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            const SizedBox(height: 20),

            // Info tambahan
            if (product is Coffee)
              Text(
                "Size: ${(product as Coffee).size}",
                style: const TextStyle(fontSize: 16),
              ),
            if (product is Food)
              Text(
                "Type: ${(product as Food).type}",
                style: const TextStyle(fontSize: 16),
              ),
            const SizedBox(height: 40),

            // Tombol Add to Cart
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // cek apakah produk sudah ada di cart
                  final index = cartItems.indexWhere(
                    (item) => item.product.id == product.id,
                  );

                  if (index >= 0) {
                    // kalau sudah ada, tambahin quantity
                    cartItems[index].quantity += 1;
                  } else {
                    // kalau belum ada, bikin order baru
                    cartItems.add(Order(product, 1));
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${product.name} ditambahkan ke Cart!"),
                    ),
                  );

                  Navigator.pop(context); // kembali ke menu setelah add
                },
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                label: const Text(
                  "Add to Cart",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
