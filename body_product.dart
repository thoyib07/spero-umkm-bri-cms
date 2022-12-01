import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:umkm_bri/models/Product.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../../size_config.dart';
import 'categories.dart';
// import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'product_second.dart';
import 'section_title.dart';

final oCcy = NumberFormat("#.##0", "en_US");

class Product {
  String fact;

  Product({
    required this.id,
    required this.images,
    required this.colors,
    this.stock = 0,
    this.fact = "",
    this.length = 0,
    // this.idUser = "0",
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.description,
  });

  final int id, price, length;
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final int stock;
  final bool isFavourite, isPopular;

  factory Product.fromJson(Map json) {
    return Product(
      id: json['data'][0]["id"],
      length: json['data'][0]["length"],
      images: [],
      title: json['data'][0]["nama"],
      colors: [],
      stock: json['data'][0]["stock"],
      description: "",
      price: json['data'][0]["price"],
    );
  }
}

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Future<Product> futureProduct;
  // GetStorage box = GetStorage();
  // String idUser = "";

  @override
  void initState() {
    super.initState();
    // idUser = ;
    // print(idUser);
    futureProduct = fetchProduct();
  }

  Future<Product> fetchProduct() async {
    final getProductById =
        Uri.parse('http://192.168.100.43:8000/api/listProduct');
    http.Response response = await http.post(getProductById, headers: {
      "Accept": "application/json",
    }, body: {
      "id": "13",
    });

    print(response.statusCode);

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load cat fact!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenWidth(20)),
            HomeHeader(),
            Categories(),
            SizedBox(height: getProportionateScreenWidth(10)),

            // Column(
            //   children: [
            //     Padding(
            //       padding: EdgeInsets.symmetric(
            //           horizontal: getProportionateScreenWidth(20)),
            //       child: SectionTitle(title: "Foods", press: () {}),
            //     ),
            //     SizedBox(height: getProportionateScreenWidth(20)),
            //     SingleChildScrollView(
            //       scrollDirection: Axis.horizontal,
            //       child: Row(
            //         children: [
            //           FutureBuilder<Product>(
            //             future: futureProduct,
            //             builder: (context, snapshot) {
            //               if (snapshot.hasData) {
            //                 return ListView.builder(
            //                   itemCount: snapshot.data!.length,
            //                   itemBuilder: (_, index) => Container(
            //                     child: Container(
            //                       margin: EdgeInsets.symmetric(
            //                           horizontal: 10, vertical: 5),
            //                       padding: EdgeInsets.all(20.0),
            //                       decoration: BoxDecoration(
            //                         color: Color(0xff97FFFF),
            //                         borderRadius: BorderRadius.circular(15.0),
            //                       ),
            //                       child: Column(
            //                         mainAxisAlignment: MainAxisAlignment.start,
            //                         crossAxisAlignment:
            //                             CrossAxisAlignment.start,
            //                         children: [
            //                           Text(
            //                             "${snapshot.data!.title}",
            //                             style: TextStyle(
            //                               fontSize: 18.0,
            //                               fontWeight: FontWeight.bold,
            //                             ),
            //                           ),
            //                           SizedBox(height: 10),
            //                           Text("${snapshot.data!.title}"),
            //                         ],
            //                       ),
            //                     ),
            //                   ),
            //                 );
            //               } else if (snapshot.hasError) {
            //                 return Text('error ${snapshot}');
            //               }

            //               return const CircularProgressIndicator();
            //             },
            //           ),
            //           SizedBox(width: getProportionateScreenWidth(20)),
            //         ],
            //       ),
            //     )
            //   ],
            // ),

            SizedBox(height: getProportionateScreenWidth(30)),
            // ProductSecond(),
          ],
        ),
      ),
    );
  }
}
