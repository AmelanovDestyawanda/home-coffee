import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';
import '../provider/order_provider.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (ctx, i) {
                final item = cart.cartItems.values.toList()[i];
                return ListTile(
                  title: Text(item.product.name),
                  subtitle: Text("Jumlah: ${item.quantity}"),
                  trailing: Text("Rp ${(item.product.price * item.quantity).toInt()}"),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total:", style: TextStyle(fontSize: 20)),
                Text("Rp ${cart.totalPrice.toInt()}",
                    style: const TextStyle(fontSize: 20)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Provider.of<OrderProvider>(context, listen: false).addOrder(
                  cart.cartItems.values.toList(),
                  cart.totalPrice,
                );
                cart.clearCart();
                Navigator.of(context).pop(); // Kembali ke halaman troli
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Pesanan berhasil dibuat!")),
                );
              },
              child: const Text("Konfirmasi Pesanan"),
            ),
          ),
        ],
      ),
    );
  }
}