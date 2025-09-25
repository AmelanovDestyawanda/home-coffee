import 'package:brew_verse/models/home_detail_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final promos = [
      {"title": "Diskon 20% Semua Kopi", "image": "assets/images/latte.jpg"},
      {
        "title": "Buy 1 Get 1 Cappuccino",
        "image": "assets/images/cappucino.jpg",
      },
      {"title": "Gratis Brownies", "image": "assets/images/brownis.jpg"},
    ];

    final bestSeller = [
      {"name": "Latte", "price": 28000, "image": "assets/images/latte.jpg"},
      {
        "name": "Cappuccino",
        "price": 25000,
        "image": "assets/images/cappucino.jpg",
      },
      {
        "name": "Americano",
        "price": 22000,
        "image": "assets/images/amer.jpg",
      },
    ];

    final rekomendasi = [
      {
        "name": "Espresso Panas",
        "price": 20000,
        "image": "assets/images/espresso.jpg",
      },
      {
        "name": "Iced Coffee",
        "price": 23000,
        "image": "assets/images/icedcoffe.jpg",
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.brown,
        elevation: 0,
        centerTitle: true,
        title: const Text("Home Coffee", style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔥 Banner Promo (Carousel)
            SizedBox(
              height: 200,
              child: PageView.builder(
                itemCount: promos.length,
                controller: PageController(viewportFraction: 0.9),
                itemBuilder: (context, index) {
                  final promo = promos[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: AssetImage(promo["image"]!),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                    
                          // ignore: deprecated_member_use
                          Colors.black.withOpacity(0.3),
                          BlendMode.darken,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        promo["title"]!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ),

            // 🔥 Best Seller
            sectionTitle("Best Seller", onSeeAll: () {}),
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: bestSeller.length,
                itemBuilder: (context, index) {
                  final item = bestSeller[index];
                  return menuCard(context, item);
                },
              ),
            ),

            // 🔥 Rekomendasi untuk Kamu
            sectionTitle("Rekomendasi untuk Kamu", onSeeAll: () {}),
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: rekomendasi.length,
                itemBuilder: (context, index) {
                  final item = rekomendasi[index];
                  return menuCard(context, item);
                },
              ),
            ),

            // 🔥 Loyalty Card
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.brown[200],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Loyalty Card",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Beli 9 Gratis 1 Kopi!",
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 16),
                    LinearProgressIndicator(
                      value: 0.6, // contoh progress 6/10
                      color: Colors.brown[800],
                      backgroundColor: Colors.brown[100],
                      minHeight: 10,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "6 / 10 Kopi",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Widget section title
  Widget sectionTitle(String title, {VoidCallback? onSeeAll}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          if (onSeeAll != null)
            TextButton(onPressed: onSeeAll, child: const Text("Lihat Semua")),
        ],
      ),
    );
  }

  // 🔹 Widget menu card
  Widget menuCard(BuildContext context, Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HomeDetailScreen(
              name: item["name"] as String,
              price: item["price"] as int,
              image: item["image"] as String,
            ),
          ),
        );
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Image.asset(
                item["image"]!,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item["name"]!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Rp ${item["price"]}",
                    style: const TextStyle(color: Colors.brown),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
