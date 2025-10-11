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
        // Menggunakan warna AppBar yang konsisten dengan tema
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 kolom
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.75, // Mengatur rasio kartu agar lebih tinggi
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return _buildProductGridCard(context, product);
        },
      ),
    );
  }

  // WIDGET BARU UNTUK KARTU PRODUK DI GRID
  Widget _buildProductGridCard(BuildContext context, Product product) {
    // Ambil path gambar dari produk
    String imagePath = "assets/images/amer.jpg"; // Default image
    if (product.image != null && product.image!.isNotEmpty) {
      imagePath = product.image!;
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Produk dengan Hero Animation
            Expanded(
              child: Hero(
                tag: product.id, // Tag untuk animasi Hero
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  child: Image.asset(
                    imagePath,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    // Tambahkan error builder jika gambar tidak ditemukan
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.coffee, size: 50, color: Colors.grey);
                    },
                  ),
                ),
              ),
            ),
            // Detail Produk
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