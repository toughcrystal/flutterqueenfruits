import 'package:flutter/material.dart';
import 'package:queenfruits/Models/kategori_list.dart';
class AppModel {
  final Category categories;
  final String image, title, description;
  final int price, id, berat, review;
  final List<Color> fcolor;
  final List<int> priceOptions; // Tambahkan properti ini
  final bool isCheck;

  AppModel({
    required this.categories,
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.description,
    required this.berat,
    required this.review,
    required this.fcolor,
    required this.priceOptions, // Tambahkan properti ini
    required this.isCheck,
  });

  static where(bool Function(dynamic item) param0) {}
}

final List<AppModel> products = [
  AppModel(
    id: 1,
    title: "Mangga Manalagi",
    price: 10000,
    description: "Mangga manalagi segar dan manis.",
    categories: categories[0],
    image: "assets/parcel.jpg",
    berat: 1,
    review: 5,
    fcolor: [Colors.red, Colors.green, Colors.yellow],
    priceOptions: [10000, 15000, 20000], // Harga untuk ukuran S, M, L
    isCheck: false,
  ),
  AppModel(
    id: 2,
    title: "Pisang Ambon",
    price: 15000,
    description: "Pisang ambon segar dan manis.",
    categories: categories[1],
    image: "assets/buah kiloan.jpg",
    berat: 1,
    review: 4,
    fcolor: [Colors.yellow],
    priceOptions: [15000, 20000, 25000], // Harga untuk ukuran S, M, L
    isCheck: false,
  ),
  AppModel(
    id: 3,
    title: "Apel Fuji",
    price: 20000,
    description: "Apel Fuji segar dan renyah.",
    categories: categories[2],
    image: "assets/buah potong.jpg",
    berat: 1,
    review: 5,
    fcolor: [Colors.red],
    priceOptions: [20000, 25000, 30000], // Harga untuk ukuran S, M, L
    isCheck: false,
  ),
  AppModel(
    id: 4,
    title: "Jeruk Sunkist",
    price: 18000,
    description: "Jeruk Sunkist segar dan kaya vitamin C.",
    categories: categories[3],
    image: "assets/buah olahan.jpg",
    berat: 1,
    review: 4,
    fcolor: [Colors.orange],
    priceOptions: [18000, 22000, 26000], // Harga untuk ukuran S, M, L
    isCheck: false,
  ),
  AppModel(
    id: 5,
    title: "Anggur Merah",
    price: 25000,
    description: "Anggur merah segar dan manis.",
    categories: categories[0],
    image: "assets/buah kiloan.jpg",
    berat: 1,
    review: 5,
    fcolor: [Colors.purple],
    priceOptions: [25000, 30000, 35000], // Harga untuk ukuran S, M, L
    isCheck: false,
  ),
  AppModel(
    id: 6,
    title: "Semangka Tanpa Biji",
    price: 12000,
    description: "Semangka tanpa biji segar dan manis.",
    categories: categories[1],
    image: "assets/parcel.jpg",
    berat: 1,
    review: 4,
    fcolor: [Colors.green],
    priceOptions: [12000, 15000, 18000], // Harga untuk ukuran S, M, L
    isCheck: false,
  ),
  AppModel(
    id: 7,
    title: "Kiwi Hijau",
    price: 30000,
    description: "Kiwi hijau segar dan kaya nutrisi.",
    categories: categories[2],
    image: "assets/banner.jpg",
    berat: 1,
    review: 5,
    fcolor: [Colors.green],
    priceOptions: [30000, 35000, 40000], // Harga untuk ukuran S, M, L
    isCheck: false,
  ),
  AppModel(
    id: 8,
    title: "Stroberi",
    price: 28000,
    description: "Stroberi segar dan manis.",
    categories: categories[3],
    image: "assets/buah potong.jpg",
    berat: 1,
    review: 5,
    fcolor: [Colors.red],
    priceOptions: [28000, 32000, 36000], // Harga untuk ukuran S, M, L
    isCheck: false,
  ),
  AppModel(
    id: 9,
    title: "Melon Hijau",
    price: 15000,
    description: "Melon hijau segar dan manis.",
    categories: categories[0],
    image: "assets/buah olahan.jpg",
    berat: 1,
    review: 4,
    fcolor: [Colors.green],
    priceOptions: [15000, 20000, 25000], // Harga untuk ukuran S, M, L
    isCheck: false,
  ),
  AppModel(
    id: 10,
    title: "Nanas Madu",
    price: 17000,
    description: "Nanas madu segar dan manis.",
    categories: categories[1],
    image: "assets/banner.jpg",
    berat: 1,
    review: 4,
    fcolor: [Colors.yellow],
    priceOptions: [17000, 22000, 27000], // Harga untuk ukuran S, M, L
    isCheck: false,
  ),
];