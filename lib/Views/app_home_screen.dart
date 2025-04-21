import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:queenfruits/Views/Widgets/banner.dart';
import 'package:queenfruits/Models/model.dart';
import 'package:queenfruits/Models/kategori_list.dart';
import 'package:queenfruits/Views/all_produk.dart';
import 'Widgets/produk.dart';
import 'package:queenfruits/Views/detail_produk.dart';



class AppHomeScreen extends StatefulWidget {
  const AppHomeScreen({super.key});

  @override
  State<AppHomeScreen> createState() => _AppHomeScreenState();
}

class _AppHomeScreenState extends State<AppHomeScreen> {
  final List<Map<String, String>> categories = const [
    {"image": "assets/buah kiloan.jpg", "title": "Buah Kiloan"},
    {"image": "assets/buah potong.jpg", "title": "Buah Potong"},
    {"image": "assets/buah olahan.jpg", "title": "Buah Olahan"},
    {"image": "assets/parcel.jpg", "title": "Parcel Buah"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // APPBAR KUSTOM
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/logo.jpg", height: 50),
                  const Text(
                    "Dashboard",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1B5953),
                    ),
                  ),
                  SizedBox(width: 50),
                ],
              ),
            ),
            // SEARCH BAR
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Cari Produk",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    border: InputBorder.none,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(Icons.search, color: Color(0xFF1B5953)),
                    ),
                  ),
                ),
              ),
            ),
            const CustomBanner(),
            // Kategori Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Kategori Produk",
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 0,
                      color: Color(0xFF1B5953),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Kategori List (langsung di sini)
            Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(categories.length, (index) {
                    return InkWell(
                      onTap: () {
                        final filterItems = products
                            .where((item) =>
                                item.categories.toString().toLowerCase() ==
                                categories[index]["title"]!.toLowerCase())
                            .toList();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Kategori(
                              categories: Category(
                                title: categories[index]["title"]!,
                                image: categories[index]["image"]!,
                              ),
                              items: filterItems,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: MediaQuery.of(context).size.width *
                            0.3, // Flexible width
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                              child: Image.asset(
                                categories[index]["image"]!,
                                height: MediaQuery.of(context).size.width *
                                    0.2, // Flexible height
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                categories[index]["title"]!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1B5953),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),

            // Rekomendasi Produk
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Rekomendasi Produk",
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: 0,
                      color: Color(0xFF1B5953),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      print("See All ditekan");
                    },
                    icon: const Icon(
                      CupertinoIcons.chevron_right,
                      color: Color(0xFF1B5953),
                      size: 20,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
            // Produk List
            Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Ubah dari center
                  children: List.generate(products.length, (index) {
                    final eCommerceItems = products[index];
                    return Padding(
                      padding: index == 0
                          ? const EdgeInsets.only(right: 10)
                          : const EdgeInsets.only(right: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailProduct(products: eCommerceItems),
                            ),
                          );
                        },
                        child: Produk(
                          products: eCommerceItems,
                          size: MediaQuery.of(context).size,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Center(child: Text("Konten Dashboard")),
            ),
          ],
        ),
      ),
    );
  }
}
