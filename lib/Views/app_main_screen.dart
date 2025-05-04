import 'package:flutter/material.dart';
import 'package:queenfruits/Views/app_home_screen.dart';
import 'package:queenfruits/Views/app_keranjang_screen.dart';
import 'package:queenfruits/Views/app_pesanan_screen.dart';
import 'package:queenfruits/Views/app_settings_screen.dart';

class AppMainScreen extends StatefulWidget {
  const AppMainScreen({super.key});

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  int selectedIndex = 0;
  final List pages = [
    const AppHomeScreen(),
    const AppPesananScreen(),
    const AppKeranjangScreen(),
    const AppSettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Color(0xFF1B5953),
        selectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        elevation: 0,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Pesanan"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), label: "Keranjang"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Pengaturan"),
        ],
      ),
      body: pages[selectedIndex],
    );
  }
}
