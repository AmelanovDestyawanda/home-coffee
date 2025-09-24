import 'package:flutter/material.dart';
import '../data/product.dart';
import 'detail_screen.dart';

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
        backgroundColor: Colors.brown,
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final item = products[index];
          String image = "";
          if (item is CoffeeProduct) image = item.image;
          if (item is FoodProduct) image = item.image;

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Image.asset(image, width: 50, fit: BoxFit.cover),
              title: Text(item.name),
              subtitle: Text("Rp ${item.price.toInt()}"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailScreen(product: item),
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
