import 'package:home/data/coffe_dummy.dart';
import 'package:home/data/food_dummy.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Keranjang"),
        backgroundColor: Colors.brown,
      ),
      body: cart.cartItems.isEmpty
          ? const Center(child: Text("Keranjang masih kosong"))
          : ListView.builder(
              itemCount: cart.cartItems.length,
              itemBuilder: (context, index) {
                final item = cart.cartItems[index];
                String image = "";
                if (item is CoffeeProduct) image = item.image;
                if (item is FoodProduct) image = item.image;
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: Image.asset(image, width: 50, fit: BoxFit.cover),
                    title: Text(item.name),
                    subtitle: Text("Rp ${item.price.toInt()}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        cart.removeFromCart(item);
                      },
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: cart.cartItems.isEmpty
          ? null
          : Container(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Checkout berhasil!")),
                  );
                },
                child: Text("Checkout (Rp ${cart.totalPrice.toInt()})"),
              ),
            ),
    );
  }
}
