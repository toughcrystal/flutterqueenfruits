import 'package:flutter/material.dart';



class CustomBanner extends StatefulWidget {
  const CustomBanner({super.key});

  @override
  State<CustomBanner> createState() => _CustomBannerState();
}

class _CustomBannerState extends State<CustomBanner> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.15, // 15% dari tinggi layar
      width: size.width * 0.95, // Lebar penuh
      decoration: BoxDecoration(
        color: Colors.white, // Warna hijau tua sesuai permintaan
        borderRadius: BorderRadius.circular(10),
        boxShadow: [ // Menambahkan shadow agar terlihat lebih menonjol
          BoxShadow(
            color: Colors.black.withOpacity(0.3), // Shadow transparan
            blurRadius: 5, // Efek blur bayangan
            offset: const Offset(0, 5), // Posisi shadow ke bawah
          ),
        ],
      ),
      child: Center(
        child: Text(
          "Banner",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1B5953), // Warna hijau tua sesuai permintaan
          ),
        ),
      ),
    );
  }
}