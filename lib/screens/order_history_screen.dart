import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/order_provider.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Pesanan"),
      ),
      body: orderData.orders.isEmpty
          ? const Center(child: Text("Belum ada pesanan."))
          : ListView.builder(
              itemCount: orderData.orders.length,
              itemBuilder: (ctx, i) {
                final order = orderData.orders[i];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ExpansionTile(
                    title: Text("Total: Rp ${order.total.toInt()}"),
                    subtitle: Text("Tanggal: ${order.date}"),
                    children: order.items.map((prod) {
                      return ListTile(
                        title: Text(prod.product.name),
                        trailing: Text("${prod.quantity}x"),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
    );
  }
}