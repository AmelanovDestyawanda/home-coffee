import 'package:flutter/material.dart';
import 'package:home/data/coffe_dummy.dart';
import 'package:home/data/food_dummy.dart';
import 'package:home/models/product.dart';
import 'package:home/screens/menu_list_screen.dart'; 

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data untuk kategori
    final categories = [
      {
        "title": "Coffee",
        "icon": Icons.coffee,
        "color": Theme.of(context).colorScheme.primary,
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
        title: const Text("Pilih Kategori Menu"),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Theme.of(context).colorScheme.primary,
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
            // Desain kartu kategori
            child: Container(
              decoration: BoxDecoration(
                color: (category["color"] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    category["icon"] as IconData,
                    size: 50,
                    color: category["color"] as Color,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    category["title"] as String,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
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