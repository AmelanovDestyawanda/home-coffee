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
        "color": Theme.of(context).colorScheme.primary, // Menggunakan primaryColor
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 1,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return InkWell( // Menggunakan InkWell untuk efek sentuhan
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
            borderRadius: BorderRadius.circular(25),
            child: Container(
              decoration: BoxDecoration(
                color: (category["color"] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    category["icon"] as IconData,
                    size: 65,
                    color: category["color"] as Color,
                  ),
                  const SizedBox(height: 15),
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
