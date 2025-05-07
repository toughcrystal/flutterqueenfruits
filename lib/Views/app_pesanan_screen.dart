import 'package:flutter/material.dart';

class AppPesananScreen extends StatefulWidget {
  const AppPesananScreen({super.key});

  @override
  State<AppPesananScreen> createState() => _AppPesananScreenState();
}

class _AppPesananScreenState extends State<AppPesananScreen> {
  int _selectedTab = 0;
  final List<String> _tabs = ['Konfirmasi', 'Proses', 'Dikirim', 'Selesai'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset("assets/logo.jpg", height: 50),
              const Text(
                "Pesanan",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B5953),
                ),
              ),
              const SizedBox(width: 50),
            ],
          ),
        ),
        body: Column(
          children: [
          // Tab Filter (Konfirmasi, Proses, Dikirim)
            Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_tabs.length, (index) {
                return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                  backgroundColor: _selectedTab == index ? Colors.orange : Colors.white,
                  side: const BorderSide(color: Colors.orange),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  ),
                  onPressed: () {
                  setState(() {
                    _selectedTab = index;
                  });
                  },
                  child: Text(
                  _tabs[index],
                  style: TextStyle(
                    color: _selectedTab == index ? Colors.white : Colors.orange,
                    fontWeight: FontWeight.w600,
                  ),
                  ),
                ),
                );
              }),
              ),
            ),
            ),

          // Card Pesanan
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tanggal dan ID
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              '27 Februari 2025',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '30 menit',
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Produk dan gambar
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                'assets/buah_mangga.jpg', // Ganti sesuai path image kamu
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('Mangga'),
                                  Text('Salad Buah 200ml'),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: const [
                                Text('2x'),
                                Text('5x'),
                              ],
                            ),
                          ],
                        ),
                        const Divider(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Total',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Rp. 82.000',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
