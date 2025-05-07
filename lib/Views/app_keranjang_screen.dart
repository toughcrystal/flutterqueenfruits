import 'package:flutter/material.dart';
import 'package:queenfruits/Views/app_checkout_screen.dart';

// Simulasi data produk dari menu detail
class CartItem {
  final String image;
  final String title;
  final int price;
  int quantity;
  bool isChecked;

  CartItem({
    required this.image,
    required this.title,
    required this.price,
    this.quantity = 1,
    this.isChecked = true,
  });
}

class AppKeranjangScreen extends StatefulWidget {
  const AppKeranjangScreen({super.key});

  @override
  State<AppKeranjangScreen> createState() => _AppKeranjangScreenState();
}

class _AppKeranjangScreenState extends State<AppKeranjangScreen> {
  List<CartItem> cartItems = [
    CartItem(
      image: 'assets/buah_mangga.jpg',
      title: 'Mangga',
      price: 32000,
      quantity: 2,
    ),
    CartItem(
      image: 'assets/buah olahan.jpg',
      title: 'Salad Buah 200ml',
      price: 50000,
      quantity: 5,
    ),
  ];

  int get totalHarga {
    return cartItems
        .where((item) => item.isChecked)
        .map((item) => item.price * item.quantity)
        .fold(0, (a, b) => a + b);
  }

  void _goToCheckout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CheckoutScreen()),
    );
  }

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
                  const SizedBox(width: 50),
                ],
              ),
            ),

            // List Keranjang
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return _buildCartItem(item);
                },
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
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        'Rp. $totalHarga',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1B5953),
                        ),
                      ),
                    ],
                  ),
                    ElevatedButton(
                    onPressed: totalHarga > 0
                      ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder: (context) => const CheckoutScreen(),
                          ),
                        );
                        }
                      : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1B5953),
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 12),
                    ),
                    child: const Text(
                      'Checkout',
                      style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      ),
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

  Widget _buildCartItem(CartItem item) {
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
            value: item.isChecked,
            onChanged: (value) {
              setState(() {
                item.isChecked = value ?? false;
              });
            },
            activeColor: const Color(0xFF1B5953),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              item.image,
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
                Text(item.title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                Text('Rp. ${item.price}',
                    style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline,
                    color: Color(0xFF1B5953)),
                onPressed: () {
                  setState(() {
                    if (item.quantity > 1) item.quantity--;
                  });
                },
              ),
              Text('${item.quantity}'),
              IconButton(
                icon: const Icon(Icons.add_circle_outline,
                    color: Color(0xFF1B5953)),
                onPressed: () {
                  setState(() {
                    item.quantity++;
                  });
                },
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.grey),
            onPressed: () {
              setState(() {
                cartItems.remove(item);
              });
            },
          ),
        ],
      ),
    );
  }
}

// Simulasi halaman Checkout
// class CheckoutScreen extends StatelessWidget {
//   const CheckoutScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Checkout"),
//         backgroundColor: const Color(0xFF1B5953),
//       ),
//       body: const Center(
//         child: Text("Halaman Checkout"),
//       ),
//     );
//   }
// }
