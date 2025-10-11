import 'package:home/data/coffe_dummy.dart';
import 'package:home/data/food_dummy.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';
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
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.75,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final item = products[index];
          String image = "";
          if (item is CoffeeProduct) image = item.image;
          if (item is FoodProduct) image = item.image;

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailScreen(product: item),
                ),
              );
            },
            child: Hero(
              tag: item.id,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // 📸 Gambar kotak
                    Container(
                      width: double.infinity,
                      height: 120,
                      color: Colors.grey[200],
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // 📋 Info Produk
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Rp ${item.price.toInt()}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.brown,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
