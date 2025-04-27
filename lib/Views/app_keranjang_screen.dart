import 'package:flutter/material.dart';

class AppKeranjangScreen extends StatelessWidget {
  const AppKeranjangScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset("assets/logo.jpg", height: 50),
                  const Text(
                    "Keranjang",
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

            // List Keranjang
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildCartItem(
                    context,
                    image: 'assets/buah_mangga.jpg',
                    title: 'Mangga',
                    price: 32000,
                    quantity: 2,
                    isChecked: true,
                  ),
                  _buildCartItem(
                    context,
                    image: 'assets/buah olahan.jpg',
                    title: 'Salad Buah 200ml',
                    price: 50000,
                    quantity: 5,
                    isChecked: true,
                  ),
                  // _buildCartItem(
                  //   context,
                  //   image: 'assets/buah naga.png',
                  //   title: 'Buah Naga Potong',
                  //   price: 28000,
                  //   quantity: 1,
                  //   isChecked: false,
                  // ),
                ],
              ),
            ),

            // Total dan Checkout
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey, width: 0.5),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'Rp. 82.000',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1B5953),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1B5953),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                    child: const Text('Checkout'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(BuildContext context,
      {required String image,
      required String title,
      required int price,
      required int quantity,
      required bool isChecked}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF1B5953)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Checkbox(
            value: isChecked,
            onChanged: (value) {},
            activeColor: Color(0xFF1B5953),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              image,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Rp. ${price.toString()}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Row(
            children: [
              const Icon(Icons.remove_circle_outline, color: Color(0xFF1B5953)),
              const SizedBox(width: 4),
              Text('$quantity'),
              const SizedBox(width: 4),
              const Icon(Icons.add_circle_outline, color: Color(0xFF1B5953)),
            ],
          ),
          const SizedBox(width: 8),
          const Icon(Icons.delete_outline, color: Colors.grey),
        ],
      ),
    );
  }
}
