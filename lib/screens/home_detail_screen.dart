import 'package:flutter/material.dart';

class HomeDetailScreen extends StatelessWidget {
  final String name;
  final int price;
  final String image;

  const HomeDetailScreen({
    super.key,
    required this.name,
    required this.price,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.brown,
        elevation: 0,
        title: Text(
          name,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔥 Gambar produk
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
              child: Image.asset(
                image,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),

            // 🔥 Nama + harga
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Rp $price",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 🔥 Deskripsi dummy
                  const Text(
                    "Kopi pilihan dengan racikan terbaik, dibuat dari biji kopi berkualitas "
                    "dan disajikan dengan cinta. Cocok untuk menemani pagi atau waktu santai kamu.",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 30),

                  // 🔥 Tombol Add to Cart
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown[700],
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 5,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("$name ditambahkan ke keranjang!"),
                            backgroundColor: Colors.brown,
                          ),
                        );
                      },
                      icon: const Icon(Icons.shopping_cart, color: Colors.white),
                      label: const Text(
                        "Tambah ke Keranjang",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
