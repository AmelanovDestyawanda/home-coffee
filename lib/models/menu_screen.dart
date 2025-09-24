import 'package:flutter/material.dart';
import '../data/product.dart';
import 'menu_list_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu"),
        backgroundColor: Colors.brown,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.coffee, color: Colors.brown),
            title: const Text("Coffee"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MenuListScreen(
                    title: "Coffee",
                    products: coffeeMenu,
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.fastfood, color: Colors.orange),
            title: const Text("Food"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MenuListScreen(
                    title: "Food",
                    products: foodMenu,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
