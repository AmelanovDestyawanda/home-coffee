import 'package:flutter/material.dart';
import 'package:home/screens/detail_screen.dart';
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
      // Menggunakan ListView agar bisa di-scroll
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        // Menggunakan Wrap agar kartu bisa berbaris dan turun ke bawah secara otomatis
        child: Wrap(
          spacing: 8.0, // Jarak horizontal antar kartu
          runSpacing: 8.0, // Jarak vertikal antar baris kartu
          children: products.map((product) {
            // Kita panggil widget kartu produk yang sama seperti di home screen
            return _buildProductCard(context, product);
          }).toList(),
        ),
      ),
    );
  }

  // WIDGET KARTU PRODUK (SAMA PERSIS DENGAN YANG DI HOME SCREEN)
  // Ini memastikan tampilan yang konsisten
  Widget _buildProductCard(BuildContext context, Product product) {
    String imagePath = "assets/images/amer.jpg"; // Gambar default
    if (product.image != null && product.image!.isNotEmpty) {
      imagePath = product.image!;
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailScreen(product: product),
          ),
        );
      },
      // Container dengan ukuran yang sama seperti di home screen
      child: Container(
        width: 180, // Lebar kartu yang sama
        height: 260, // Tinggi kartu yang sama
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hero(
                tag: product.id,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  child: Image.asset(
                    imagePath,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.coffee, size: 50, color: Colors.grey);
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Rp ${product.price.toInt()}",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
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