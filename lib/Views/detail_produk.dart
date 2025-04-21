import 'package:flutter/material.dart';
import 'package:queenfruits/Models/model.dart';

class DetailProduct extends StatefulWidget {
  final AppModel products;
  const DetailProduct({super.key, required this.products});

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  int currentIndex = 0;
  int selectedsize = 0; // Menyimpan indeks ukuran yang dipilih
  int productCount = 0; // Menyimpan jumlah produk yang dipilih

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Detail Produk",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B5953),
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF1B5953)),
      ),
      body: 
      ListView(
        children: [
          // Gambar Produk dengan PageView
          Container(
            color: Colors.white,
            height: size.height * 0.46,
            width: size.width,
            child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              itemCount: 3, // Jumlah gambar
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Image.asset(
                      widget.products.image,
                      height: size.height * 0.4,
                      width: size.width,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.only(right: 4),
                          width: 7,
                          height: 7,
                          decoration: BoxDecoration(
                            color: currentIndex == index
                                ? const Color(0xFF1B5953)
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          // Detail Produk
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Kategori dan Rating
                Row(
                  children: [
                    Text(
                      widget.products.categories.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 17,
                    ),
                    Text(
                      widget.products.review.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      " (${widget.products.review})",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.favorite_border,
                      color: Color(0xFF1B5953),
                      size: 25,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                // Judul Produk
                Text(
                  widget.products.title,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF1B5953),
                  ),
                ),
                const SizedBox(height: 5),
                // Harga Produk
                Text(
                  "Rp. ${widget.products.price}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.red,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                // Deskripsi Produk
                const Text(
                  "Deskripsi",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF1B5953),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.products.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                // Opsi Harga
                const Text(
                  "Pilih Harga",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF1B5953),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: widget.products.priceOptions
                      .asMap()
                      .entries
                      .map((entry) {
                    final int index = entry.key;
                    final int price = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedsize = index;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: selectedsize == index
                                ? const Color(0xFF1B5953)
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Text(
                            "Rp. $price",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: selectedsize == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                // Jumlah Produk
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Tombol Kurangi Jumlah Produk
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (productCount > 0) {
                            productCount--;
                          }
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1B5953),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Jumlah Produk
                    Text(
                      "$productCount",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Tombol Tambah
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          productCount++;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1B5953),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: Colors.white,
        elevation: 0,
        label: SizedBox(
          width: size.width * 0.9,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF1B5953),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.shopping_cart_outlined,
                          color: Color(0xFF1B5953)),
                      SizedBox(width: 5),
                      Text(
                        "Tambah ke Keranjang",
                        style: TextStyle(
                          color: Color(0xFF1B5953),
                          fontWeight: FontWeight.bold,
                          letterSpacing: -1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: const Color(0xFF1B5953),
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFF1B5953),
                  ),
                  child: const Center(
                    child: Text(
                      "Beli Sekarang",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}