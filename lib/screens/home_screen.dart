import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../provider/user_provider.dart';
import '../data/bestseller_dummy.dart';
import '../data/coffe_dummy.dart';
import '../data/food_dummy.dart';
import '../data/promos_dummy.dart';
import '../data/rekomendasi_dummy.dart';
import 'home_detail_screen.dart';
import 'menu_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  final TextEditingController _searchController = TextEditingController();
  List<Product> _searchResults = [];
  Timer? _timer;
  int _currentPage = 0;

  final List<Product> _allProducts = [...coffeeMenu, ...foodMenu];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (!mounted || _searchController.text.isNotEmpty) return;
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
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _searchResults = [];
      } else {
        _searchResults = _allProducts
            .where((product) => product.name.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  // ===== PERBAIKAN UTAMA DI SINI =====
  // Menggunakan struktur Column -> Expanded -> ListView
  @override
  Widget build(BuildContext context) {
    bool isSearching = _searchController.text.isNotEmpty;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bagian atas yang tidak bisa di-scroll
          const SizedBox(height: 20),
          _buildWelcomeHeader(context),
          const SizedBox(height: 24),
          _buildSearchBar(context),
          const SizedBox(height: 32),

          // Bagian bawah yang bisa di-scroll
          Expanded(
            child: isSearching
                ? _buildSearchResults()
                : _buildDefaultHomeContent(),
          ),
        ],
      ),
    );
  }

  // Konten utama sekarang dibungkus ListView agar bisa scroll
  Widget _buildDefaultHomeContent() {
    return ListView(
      padding: EdgeInsets.zero, // Hapus padding default
      children: [
        _buildPromoSlider(),
        const SizedBox(height: 32),
        _buildSectionTitle(context, "Best Seller", () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MenuListScreen(
                title: "Best Seller",
                products: _allProducts..shuffle(),
              ),
            ),
          );
        }),
        _buildHorizontalProductList(bestSeller),
        const SizedBox(height: 24),
        _buildSectionTitle(context, "Rekomendasi", () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MenuListScreen(
                title: "Rekomendasi",
                products: _allProducts..shuffle(),
              ),
            ),
          );
        }),
        _buildHorizontalProductList(rekomendasi),
        const SizedBox(height: 24),
      ],
    );
  }

  // Hasil pencarian sekarang menggunakan ListView yang bisa di-scroll
  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return const Center(
        child: Text(
          "Menu tidak ditemukan.",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final product = _searchResults[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                product.image,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(product.name),
            subtitle: Text("Rp ${product.price.toInt()}"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => HomeDetailScreen(
                    name: product.name,
                    price: product.price.toInt(),
                    image: product.image,
                    heroTag: 'search_${product.id}',
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // Widget-widget lainnya tidak ada perubahan signifikan
  Widget _buildHorizontalProductList(List<Map<String, dynamic>> productData) {
    return SizedBox(
      height: 260,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: productData.length,
        itemBuilder: (context, index) {
          final product = Product.fromMap(productData[index]);
          return _buildProductCard(context, product);
        },
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Product item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HomeDetailScreen(
              name: item.name,
              price: item.price.toInt(),
              image: item.image,
              heroTag: item.id,
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
                tag: item.id,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  child: Image.asset(
                    item.image,
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
                    item.name,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Rp ${item.price.toInt()}",
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

  Widget _buildWelcomeHeader(BuildContext context) {
    final userName = Provider.of<UserProvider>(context).userName;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
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
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: "Cari kopi favoritmu...",
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey),
                  onPressed: () => _searchController.clear(),
                )
              : null,
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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(promo["image"]!, fit: BoxFit.cover),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Text(
                      promo["title"]!,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
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

  Widget _buildSectionTitle(
    BuildContext context,
    String title,
    VoidCallback onSeeAll,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          TextButton(onPressed: onSeeAll, child: const Text("Lihat Semua")),
        ],
      ),
    );
  }
}
