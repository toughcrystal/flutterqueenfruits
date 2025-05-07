import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutScreen> {
  int subtotal = 82000;
  int ongkir = 2000;
  int diskon = 0;
  String kupon = '';
  final TextEditingController _kuponController = TextEditingController();

  int get total => subtotal + ongkir - diskon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.teal),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman keranjang
          },
        ),
        title: const Text(
          "Checkout",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Alamat
                const Text("Alamat",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.location_on, color: Colors.teal),
                  title: Text("Syarifah"),
                  subtitle: Text("Jl. Manggis VII No.49"),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                ),
                const SizedBox(height: 10),

                // Pesanan
                const Text("Pesanan",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                buildItem("assets/buah_mangga.jpg", "Mangga", 32000, 2),
                buildItem(
                    "assets/buah olahan.jpg", "Salad Buah 200ml", 50000, 5),
                const SizedBox(height: 10),

                // Pembayaran
                const Text("Pembayaran",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(Icons.payment, color: Colors.teal),
                  title: Text("Metode Pembayaran"),
                  subtitle: Text("COD"),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                ),
                const SizedBox(height: 10),

                // Kupon
                const Text("Kupon",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                TextField(
                  controller: _kuponController,
                  decoration: InputDecoration(
                    hintText: "Masukkan Kode",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.check),
                      onPressed: () {
                        setState(() {
                          kupon = _kuponController.text;
                          if (kupon.toLowerCase() == "queenfruit") {
                            diskon = 5000;
                          } else {
                            diskon = 0;
                          }
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Rincian Pembayaran
                const Text("Rincian Pembayaran",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                buildPriceRow("Subtotal", subtotal),
                buildPriceRow("Ongkos Kirim", ongkir),
                buildPriceRow("Kupon", -diskon),
                const Divider(),
                buildPriceRow("Total", total, isTotal: true),
                const SizedBox(height: 20),

                // Tombol Checkout
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Checkout berhasil! 🎉')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Checkout",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        ],
      ),
    );
  }

  Widget buildItem(String imagePath, String title, int price, int quantity) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(imagePath, height: 50, width: 50, fit: BoxFit.cover),
      ),
      title: Text(title),
      subtitle: Text("Rp. ${price.toString()}"),
      trailing: Text("${quantity}x"),
    );
  }

  Widget buildPriceRow(String label, int amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: isTotal
                  ? const TextStyle(fontWeight: FontWeight.bold)
                  : null),
          Text(
            (amount < 0 ? "- " : "") + "Rp. ${amount.abs()}",
            style: isTotal
                ? const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.teal)
                : const TextStyle(),
          ),
        ],
      ),
    );
  }
}
