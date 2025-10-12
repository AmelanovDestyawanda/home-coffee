import 'package:home/data/coffe_dummy.dart';
import 'package:home/data/food_dummy.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';
import 'menu_list_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        "title": "Coffee",
        "icon": Icons.coffee,
        "color": Colors.brown,
        "products": coffeeMenu,
      },
      {
        "title": "Food",
        "icon": Icons.fastfood,
        "color": Colors.orange,
        "products": foodMenu,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Coffee Menu"),
        backgroundColor: Colors.brown,
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MenuListScreen(
                    title: category["title"] as String,
                    products: category["products"] as List<Product>,
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: (category["color"] as Color).withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    category["icon"] as IconData,
                    size: 60,
                    color: category["color"] as Color,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    category["title"] as String,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
