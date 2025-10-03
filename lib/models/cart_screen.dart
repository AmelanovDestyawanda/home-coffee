import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../provider/cart_provider.dart';
import '../data/product.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String deviceInfo = "";
  String? lastCheckout;

  @override
  void initState() {
    super.initState();
    _loadDeviceInfo();
    _loadLastCheckout();
  }

  Future<void> _loadDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final androidInfo = await deviceInfoPlugin.androidInfo;
    setState(() {
      deviceInfo = androidInfo.model; // contoh: "Redmi Note 10"
    });
  }

  Future<void> _loadLastCheckout() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      lastCheckout = prefs.getString("lastCheckout");
    });
  }

  Future<void> _saveCheckout(String total) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("lastCheckout", total);
    setState(() {
      lastCheckout = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final formatter = NumberFormat.currency(locale: 'id', symbol: 'Rp');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Keranjang"),
        backgroundColor: Colors.brown,
      ),
      body: cart.cartItems.isEmpty
          ? const Center(child: Text("Keranjang masih kosong"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
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
                          leading: Image.asset(
                            image,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(item.name),
                          subtitle: Text(formatter.format(item.price)),
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
                ),

                // ✅ Info Device + Last Checkout
                if (deviceInfo.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Device: $deviceInfo",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                if (lastCheckout != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Checkout terakhir: $lastCheckout",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
              ],
            ),
      bottomNavigationBar: cart.cartItems.isEmpty
          ? null
          : Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ✅ Checkout pakai GetWidget
                  GFButton(
                    onPressed: () {
                      final total = formatter.format(cart.totalPrice);
                      _saveCheckout(total);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Checkout berhasil: $total")),
                      );
                    },
                    text: "Checkout (${formatter.format(cart.totalPrice)})",
                    color: Colors.green,
                    fullWidthButton: true,
                    size: GFSize.LARGE,
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    height: 200,
                    child: WebViewWidget(
                      controller: WebViewController()
                        ..setJavaScriptMode(JavaScriptMode.unrestricted)
                        ..loadRequest(Uri.parse("https://kopi.kenangan.com")),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
