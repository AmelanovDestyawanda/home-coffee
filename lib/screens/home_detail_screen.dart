import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/product.dart'; // Import model Product
import '../provider/cart_provider.dart'; // Import CartProvider

// 1. Ubah menjadi StatefulWidget untuk mengelola jumlah (quantity)
class HomeDetailScreen extends StatefulWidget {
  final String name;
  final int price;
  final String image;
  final Object heroTag;
  // Tambahkan product asli untuk dimasukkan ke cart
  final Product product;

  const HomeDetailScreen({
    super.key,
    required this.name,
    required this.price,
    required this.image,
    required this.heroTag,
    required this.product, // Wajib ada
  });

  @override
  State<HomeDetailScreen> createState() => _HomeDetailScreenState();
}

class _HomeDetailScreenState extends State<HomeDetailScreen> {
  // 2. Buat state untuk menyimpan jumlah item
  int _quantity = 1;

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Hero(
            tag: widget.heroTag,
            child: Image.asset(
              widget.image,
              height: 350, // Sedikit lebih tinggi agar lebih dramatis
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: GoogleFonts.lato(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Rp ${widget.price}",
                  style: GoogleFonts.lato(
                      fontSize: 22,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const Spacer(), // Mendorong widget di bawahnya ke dasar

          // ===== 3. WIDGET BARU UNTUK JUMLAH & TOMBOL CART =====
          _buildAddToCartSection(context),
        ],
      ),
    );
  }

  // Widget terpisah untuk bagian bawah (quantity & tombol)
  Widget _buildAddToCartSection(BuildContext context) {
    // Mengambil CartProvider
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 10,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // --- Tombol Quantity ---
          Row(
            children: [
              _buildQuantityButton(Icons.remove, _decrementQuantity),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  _quantity.toString(),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              _buildQuantityButton(Icons.add, _incrementQuantity),
            ],
          ),

          // --- Tombol Add to Cart ---
          ElevatedButton.icon(
            onPressed: () {
              // Memanggil fungsi addItem dari CartProvider
              cart.addItem(widget.product, _quantity);

              // Menampilkan notifikasi
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${widget.name} x$_quantity ditambahkan ke keranjang"),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.green,
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
            label: const Text("Add to Cart", style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper untuk membuat tombol + dan -
  Widget _buildQuantityButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(icon, size: 20),
        ),
      ),
    );
  }
}