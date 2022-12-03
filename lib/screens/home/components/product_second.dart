// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:umkm_bri/components/product_card.dart';
// import 'package:umkm_bri/models/Product.dart';
// import 'package:get_storage/get_storage.dart';
// // import 'package:flutter/src/widgets/framework.dart';
// import '../../../size_config.dart';
// import 'section_title.dart';

// class ProductSecond extends StatefulWidget {
//   final List<Product>? listProduct;

//   const ProductSecond({super.key, this.listProduct});

//   @override
//   State<ProductSecond> createState() => _ProductSecondState();
// }

// class _ProductSecondState extends State<ProductSecond> {
//   late Future<List<Product>> dataProduct;

//   @override
//   void initState() {
//     super.initState();
//     GetStorage box = GetStorage();
//     final idUser = int.parse(box.read('id'));
//     log(idUser.toString());
//     dataProduct = funcGetProduct(idUser);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding:
//               EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
//           child: SectionTitle(title: "Fashion", press: () {}),
//         ),
//         SizedBox(height: getProportionateScreenWidth(20)),
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: [
//               FutureBuilder<List<Product>>(
//                   future: dataProduct,
//                   builder: (context, snapshot) {
//                     if (snapshot.hasData) {
//                       if (snapshot.data!.isNotEmpty) {
//                         log("te");
//                         return snapshot.data!
//                             .map((e) => ProductCard(product: e)) as Widget;
//                       } else {
//                         log("test");
//                         return SizedBox();
//                       }
//                     } else {
//                       log("test2");
//                       return SizedBox();
//                     }
//                   }),
//               //     if (snapshot.hasData) {)
//               // ...List.generate(
//               //   demoProducts.length,
//               //   (index) {
//               //     if (demoProducts[index].isPopular)
//               //       return ProductCard(product: demoProducts[index]);

//               //     return SizedBox
//               //         .shrink(); // here by default width and height is 0
//               //   },
//               // ),

//               SizedBox(width: getProportionateScreenWidth(20)),
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }
