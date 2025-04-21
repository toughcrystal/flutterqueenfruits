// import 'package:flutter/material.dart';

class Category{
  final String image;
  final String title;

  Category({required this.image, required this.title});
   @override
  String toString() {
    return title;
  }
}

List<Category> categories = [
  Category(image: "assets/buah kiloan.jpg", title: "Buah Kiloan"),
  Category(image: "assets/buah potong.jpg", title: "Buah Potong"),
  Category(image: "assets/buah olahan.jpg", title: "Buah Olahan"),
  Category(image: "assets/parcel.jpg", title: "Parcel Buah"),
];
// import 'package:flutter/material.dart';

// class CategoryList extends StatelessWidget {
//   const CategoryList({super.key});

//   final List<Map<String, String>> categories = const [
//     {"image": "assets/buah kiloan.jpg", "title": "Buah Kiloan"},
//     {"image": "assets/buah potong.jpg", "title": "Buah Potong"},
//     {"image": "assets/buah olahan.jpg", "title": "Buah Olahan"},
//     {"image": "assets/parcel.jpg", "title": "Parcel Buah"},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10),
//       child: SizedBox(
//         height: 140, // Atur tinggi kategori sesuai kebutuhan
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal, // Scroll ke samping
//           itemCount: categories.length,
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: const EdgeInsets.only(right: 10),
//               child: CategoryCard(
//                 image: categories[index]["image"]!,
//                 title: categories[index]["title"]!,
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class CategoryCard extends StatelessWidget {
//   final String image;
//   final String title;

//   const CategoryCard({
//     required this.image,
//     required this.title,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 150,
//       padding: const EdgeInsets.only(bottom: 10), // Atur lebar agar muat dalam satu baris horizontal
//       decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(16),
//       boxShadow: [
//         BoxShadow(
//         color: Colors.black.withOpacity(0.1),
//         blurRadius: 3,
//         spreadRadius: 2,
//         offset: const Offset(0, 2),
//         ),
//       ],
//       ),
//       child: ClipRRect(
//       borderRadius: BorderRadius.circular(16),
//       child: Column(
//         children: [
//         Expanded(
//           child: Container(
//           width: double.infinity,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//             image: AssetImage(image),
//             fit: BoxFit.cover,
//             ),
//           ),
//           ),
//         ),
//         Container(
//           width: double.infinity,
//           padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
//           color: Colors.white,
//           child: Center(
//           child: Text(
//             title,
//             style: const TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 12,
//             color: Color(0xFF1B5953),
//             ),
//             textAlign: TextAlign.center,
//             overflow: TextOverflow.ellipsis, // Tambahkan ini
//             maxLines: 1, // Batas 1 baris
//           ),
//           ),
//         ),
//         ],
//       ),
//       ),
//     );
//   }
// }
