import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/user_provider.dart';
import 'package:home/data/bestseller_dummy.dart';
import 'package:home/data/coffe_dummy.dart';
import 'package:home/data/food_dummy.dart';
import 'package:home/data/promos_dummy.dart';
import 'package:home/data/rekomendasi_dummy.dart';
import 'package:home/screens/home_detail_screen.dart';
import 'package:home/screens/menu_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (!mounted) return;
      _currentPage = (_currentPage + 1) % promos.length;
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Mengganti AppBar dengan body langsung agar lebih leluasa
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // --- HEADER BARU YANG LEBIH BAIK ---
              _buildWelcomeHeader(context),
              const SizedBox(height: 24),
              
              // --- SEARCH BAR ---
              _buildSearchBar(context),
              const SizedBox(height: 32),

              // --- PROMO SLIDER ---
              _buildPromoSlider(),
              const SizedBox(height: 32),

              // --- BEST SELLER ---
              _buildSectionTitle(context, "Best Seller", () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => MenuListScreen(title: "Best Seller", products: [...coffeeMenu, ...foodMenu]..shuffle())));
              }),
              _buildHorizontalProductList(bestSeller),
              const SizedBox(height: 24),

              // --- REKOMENDASI ---
              _buildSectionTitle(context, "Rekomendasi", () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => MenuListScreen(title: "Rekomendasi", products: [...coffeeMenu, ...foodMenu]..shuffle())));
              }),
              _buildHorizontalProductList(rekomendasi),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  // WIDGET UNTUK HEADER SELAMAT DATANG
  Widget _buildWelcomeHeader(BuildContext context) {
    final userName = Provider.of<UserProvider>(context).userName;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Halo, $userName",
                style: GoogleFonts.pacifico(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
              ),
              Text(
                "Selamat menikmati harimu!",
                style: GoogleFonts.lato(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  // WIDGET UNTUK SEARCH BAR
  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Cari kopi favoritmu...",
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // WIDGET UNTUK SLIDER PROMO
  Widget _buildPromoSlider() {
    return SizedBox(
      height: 180,
      child: PageView.builder(
        controller: _pageController,
        itemCount: promos.length,
        itemBuilder: (context, index) {
          final promo = promos[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(promo["image"]!),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    promo["title"]!,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // WIDGET UNTUK JUDUL SECTION
  Widget _buildSectionTitle(BuildContext context, String title, VoidCallback onSeeAll) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          TextButton(
            onPressed: onSeeAll,
            child: const Text("Lihat Semua"),
          ),
        ],
      ),
    );
  }

  // WIDGET UNTUK DAFTAR PRODUK HORIZONTAL
  Widget _buildHorizontalProductList(List<Map<String, dynamic>> products) {
    return SizedBox(
      height: 260,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final item = products[index];
          final heroTag = '${item["name"]}_${item["id"] ?? UniqueKey()}';
          return _buildProductCard(context, item, heroTag);
        },
      ),
    );
  }

  // WIDGET UNTUK KARTU PRODUK
  Widget _buildProductCard(BuildContext context, Map<String, dynamic> item, Object heroTag) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HomeDetailScreen(
              name: item["name"] as String,
              price: item["price"] as int,
              image: item["image"] as String,
              heroTag: heroTag,
            ),
          ),
        );
      },
      child: Container(
        width: 180,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hero(
                tag: heroTag,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  child: Image.asset(
                    item["image"]!,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item["name"]!,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Rp ${item["price"]}",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
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