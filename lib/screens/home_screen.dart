import 'package:home/data/bestseller_dummy.dart';
import 'package:home/data/promos_dummy.dart';
import 'package:home/data/rekomendasi_dummy.dart';
import 'package:home/screens/home_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.brown,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Home Coffee",
          style: GoogleFonts.pacifico(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Bagian Promo Tanpa Carousel ---
            sectionTitle("Promo Spesial Untukmu"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: promos.map((promo) => promoCard(promo)).toList(),
              ),
            ),

            const SizedBox(height: 20),

            // --- Best Seller ---
            sectionTitle("Best Seller", onSeeAll: () {}),
            SizedBox(
              height: 240,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 8),
                itemCount: bestSeller.length,
                itemBuilder: (context, index) {
                  final item = bestSeller[index];
                  return menuCard(context, item);
                },
              ),
            ),

            // --- Rekomendasi ---
            sectionTitle("Rekomendasi untuk Kamu", onSeeAll: () {}),
            SizedBox(
              height: 240,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 8),
                itemCount: rekomendasi.length,
                itemBuilder: (context, index) {
                  final item = rekomendasi[index];
                  return menuCard(context, item);
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }


  // Widget untuk kartu promo
  Widget promoCard(Map<String, String> promo) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(promo["image"]!),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4),
              BlendMode.darken,
            ),
          ),
        ),
        child: Center(
          child: Text(
            promo["title"]!,
            style: GoogleFonts.lato(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  

  // Widget untuk judul section
  Widget sectionTitle(String title, {VoidCallback? onSeeAll}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          if (onSeeAll != null)
            TextButton(onPressed: onSeeAll, child: const Text("Lihat Semua")),
        ],
      ),
    );
  }

  // Widget untuk kartu menu
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
        width: 170,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.asset(
                  item["image"]!,
                  height: 140,
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
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Rp ${item["price"]}",
                      style: GoogleFonts.lato(
                        color: Colors.brown,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
