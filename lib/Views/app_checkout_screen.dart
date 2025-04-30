import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  final List<Map<String, dynamic>> selectedItems;
  final int totalPrice;

  const CheckoutScreen({
    super.key,
    required this.selectedItems,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        backgroundColor: const Color(0xFF1B5953),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: selectedItems.length,
                itemBuilder: (context, index) {
                  final item = selectedItems[index];
                  return ListTile(
                    leading: Image.asset(item['image'], width: 50, height: 50),
                    title: Text(item['title']),
                    subtitle: Text('Rp. ${item['price']} x ${item['quantity']}'),
                    trailing: Text('Rp. ${item['price'] * item['quantity']}'),
                  );
                },
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total:', style: TextStyle(fontSize: 16)),
                Text('Rp. $totalPrice',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B5953))),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // proses pemesanan
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pesanan dikonfirmasi!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1B5953),
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text('Konfirmasi Pesanan'),
            ),
          ],
        ),
      ),
    );
  }
}
