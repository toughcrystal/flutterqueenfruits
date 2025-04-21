import 'package:flutter/material.dart';
import 'package:queenfruits/Models/model.dart';

class Produk extends StatelessWidget {
  final AppModel products;
  final Size size;
  const Produk({super.key, required this.products, required this.size});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Untuk rata kiri
      children: [
        // Gambar Produk
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage(products.image),
              fit: BoxFit.cover,
            ),
          ),
          height: size.height * 0.25,
          width: size.width * 0.5,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Align(
              alignment: Alignment.topRight,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                child: const Icon(
                  Icons.favorite_border,
                  color: Color(0xFF1B5953),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 7),
        // Nama Toko dan Rating
        Row(
          children: [
            Text(
              products.categories.toString(), // Nama kategori/toko
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
              products.review.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            Text(
              " (${products.review})",
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        // Judul Produk
        Text(
          products.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Color(0xFF1B5953),
          ),
        ),
        const SizedBox(height: 5),
        // Harga Produk
        Text(
          "\$${products.price}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}