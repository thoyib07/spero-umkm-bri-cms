import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:umkm_bri/models/ProductMap.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../../../size_config.dart';
import 'categories.dart';
// import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'product_second.dart';
import 'section_title.dart';

final oCcy = NumberFormat("#.##0", "en_US");

class ProductMapDefine {
  int id;
  String name;
  String noProducts;
  String desc;

  ProductMapDefine(
      {required this.id,
      required this.name,
      required this.noProducts,
      required this.desc});

  factory ProductMapDefine.fromJson(Map<String, dynamic> json) {
    return ProductMapDefine(
        id: json['id'],
        name: json['name'],
        noProducts: json['no_products'],
        desc: json['desc']);
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // late Future<Product> futureProduct;
  // GetStorage box = GetStorage();
  // String idUser = "";

  @override
  void initState() {
    super.initState();
  }

  Future fetchProduct() async {
    // GetData dataJson;
    final getProductById = Uri.parse('http://66.42.50.59/api/listProduct');
    http.Response response = await http.post(getProductById, headers: {
      "Accept": "application/json",
    }, body: {
      "id": "13",
    });

    if (response.statusCode == 200) {
      return (json.decode(response.body)['data'] as List)
          .map((e) => ProductMapDefine.fromJson(e))
          .toList();
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
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: SectionTitle(title: "Foods", press: () {}),
                ),
                SizedBox(height: getProportionateScreenWidth(20)),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FutureBuilder(
                        future: fetchProduct(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Text("${snapshot}");
                            // return Center(
                            //     child: Container(
                            //   child: Text("successfully connected"),
                            // ));
                          } else {
                            return Center(
                              child: Text(snapshot.error.toString()),
                            );
                          }
                        },
                      ),
                      SizedBox(width: getProportionateScreenWidth(20)),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: getProportionateScreenWidth(30)),
            // ProductSecond(),
          ],
        ),
      ),
    );
  }
}
