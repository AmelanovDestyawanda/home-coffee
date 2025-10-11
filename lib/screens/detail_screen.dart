import 'package:home/data/coffe_dummy.dart';
import 'package:home/data/food_dummy.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../provider/cart_provider.dart';

class DetailScreen extends StatelessWidget {
  final Product product;

  const DetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    String image = "assets/images/amer.jpg";
    if (product is CoffeeProduct) image = (product as CoffeeProduct).image;
    if (product is FoodProduct) image = (product as FoodProduct).image;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Colors.brown,
      ),
      body: Column(
        children: [
          Hero(
            tag: product.id,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
              child: Image.asset(image,
                  height: 250, width: double.infinity, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 20),
          Text(product.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text("Rp ${product.price.toInt()}",
              style: const TextStyle(fontSize: 20, color: Colors.brown)),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.shopping_cart),
                    label: const Text("Tambah ke Keranjang"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      Provider.of<CartProvider>(context, listen: false)
                          .addToCart(product);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${product.name} ditambahkan ke keranjang"),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Checkout berhasil!")),
                      );
                    },
                    child: const Text("Checkout Sekarang"),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
