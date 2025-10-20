import 'package:flutter/material.dart';
import 'package:home/screens/detail_screen.dart'; // Tetap menggunakan DetailScreen-mu
import '../models/product.dart';

class MenuListScreen extends StatelessWidget {
  final String title;
  final List<Product> products;

  const MenuListScreen({
    super.key,
    required this.title,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      // ===== PERUBAHAN UTAMA DI SINI =====
      // Mengganti GridView.builder menjadi ListView.builder
      body: ListView.builder(
        padding: const EdgeInsets.all(8), // Padding agar tidak terlalu mepet
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          
          // Menggunakan ListTile untuk tampilan daftar vertikal yang rapi
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              // Gambar produk di sebelah kiri
              leading: Hero(
                tag: 'list_${product.id}', // Tag Hero agar animasi tetap jalan
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    product.image,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.broken_image, size: 70, color: Colors.grey);
                    },
                  ),
                ),
              ),
              // Nama dan harga
              title: Text(
                product.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Rp ${product.price.toInt()}"),
              // Ikon panah di sebelah kanan
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // Navigasi tetap ke DetailScreen-mu
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      product: product, 
                      heroTag: 'list_${product.id}', // Mengirim tag yang unik
                    ),
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