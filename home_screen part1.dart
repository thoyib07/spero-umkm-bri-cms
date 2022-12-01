import 'dart:developer';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umkm_bri/components/coustom_bottom_nav_bar.dart';
import 'package:umkm_bri/enums.dart';
import 'package:http/http.dart' as http;

// import 'components/body.dart';
import '../../../size_config.dart';
import '../../constants.dart';
import 'components/categories.dart';
import 'components/home_header.dart';
// import 'package:umkm_bri/components/product_card_second.dart';
import 'components/section_title.dart';

class ProductMap {
  int id, stock;
  String name;
  String noProducts;
  String nama, imgLocation, imgHash;
  final double width, aspectRetio;

  ProductMap(
      {required this.id,
      required this.name,
      required this.noProducts,
      this.width = 140,
      this.aspectRetio = 1.02,
      this.imgHash = "",
      this.stock = 0,
      this.imgLocation = "",
      required this.nama});

  factory ProductMap.fromJson(Map<String, dynamic> json) {
    return ProductMap(
      id: json['id'],
      name: json['nama'],
      noProducts: json['no_products'],
      nama: json['nama'],
      stock: json['stock'],
      imgLocation: json['img_location'],
      imgHash: json['img_hash'],
    );
  }
}

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     // body: Body(),
    //     // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    //     );
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
      SizedBox(height: getProportionateScreenWidth(20)),
      HomeHeader(),
      Categories(),
      SizedBox(height: getProportionateScreenWidth(10)),
      Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SectionTitle(title: "Fashion", press: () {}),
          ),
          SizedBox(height: getProportionateScreenWidth(20)),
          SingleChildScrollView(
              physics: ScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  FutureBuilder<List<ProductMap>>(
                      future: fetchProductMaps(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<ProductMap> product =
                              snapshot.data as List<ProductMap>;
                          return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: product.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      left: getProportionateScreenWidth(20)),
                                  child: SizedBox(
                                    width: getProportionateScreenWidth(
                                        product[index].width),
                                    child: GestureDetector(
                                      // onTap: () => Navigator.pushNamed(
                                      //   context,
                                      //   DetailsScreen.routeName,
                                      //   arguments: ProductDetailsArguments(
                                      //       product: product),
                                      // ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AspectRatio(
                                            aspectRatio: 1.02,
                                            child: Container(
                                              padding: EdgeInsets.all(
                                                  getProportionateScreenWidth(
                                                      20)),
                                              decoration: BoxDecoration(
                                                color: kSecondaryColor
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Hero(
                                                tag: product[index]
                                                    .id
                                                    .toString(),
                                                child: FadeInImage.assetNetwork(
                                                  fit: BoxFit.fill,
                                                  placeholder:
                                                      "assets/loading.gif",
                                                  image:
                                                      "${product[index].imgLocation}${product[index].imgHash}",
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            product[index].nama,
                                            style:
                                                TextStyle(color: Colors.black),
                                            maxLines: 2,
                                          ),
                                          SizedBox(
                                              height:
                                                  getProportionateScreenWidth(
                                                      5)),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              product[index].stock > 1
                                                  ? Text(
                                                      // "Stock : ${product.stock}",
                                                      "Tersedia",
                                                      style: TextStyle(
                                                        fontSize:
                                                            getProportionateScreenWidth(
                                                                16),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Color.fromARGB(
                                                            255, 130, 250, 112),
                                                      ),
                                                    )
                                                  : Text(
                                                      // "Stock : ${product.stock}",
                                                      "Habis",
                                                      style: TextStyle(
                                                        fontSize:
                                                            getProportionateScreenWidth(
                                                                16),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0xFFF6625E),
                                                      ),
                                                    ),
                                              InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                onTap: () {},
                                                child: Container(
                                                    padding: EdgeInsets.all(
                                                        getProportionateScreenWidth(
                                                            4)),
                                                    // height: getProportionateScreenWidth(18),
                                                    // width: getProportionateScreenWidth(60),
                                                    decoration: BoxDecoration(
                                                      // color: Color.fromARGB(255, 255, 255, 255),
                                                      shape: BoxShape.rectangle,
                                                    ),
                                                    child: Text(
                                                        "Stock : ${product[index].stock}",
                                                        style: TextStyle(
                                                            fontSize:
                                                                getProportionateScreenWidth(
                                                                    12)))),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        } else {
                          print("test2");
                          return SizedBox();
                        }
                      })
                ],
              )),
        ],
      )
    ]))
            // child: FutureBuilder<List<ProductMap>>(
            //   future: fetchProductMaps(),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       List<ProductMap> users = snapshot.data as List<ProductMap>;
            //       return ListView.builder(
            //           itemCount: users.length,
            //           itemBuilder: (context, index) {
            //             return Container(
            //               margin: EdgeInsets.all(8),
            //               padding: EdgeInsets.all(8),
            //               color: Colors.white,
            //               child: Column(
            //                 children: [
            //                   Text(users[index].name),
            //                   Text(users[index].noProducts),
            //                   Text(users[index].nama!),
            //                 ],
            //               ),
            //             );
            //           });
            //     }
            //     if (snapshot.hasError) {
            //       print(snapshot.error.toString());
            //       return Text('error');
            //     }
            //     return CircularProgressIndicator();
            //   },
            // ),
            ));
  }

  Future<List<ProductMap>> fetchProductMaps() async {
    final getProductById =
        Uri.parse('http://192.168.100.43:8000/api/listProduct');
    http.Response response = await http.post(getProductById, headers: {
      "Accept": "application/json",
    }, body: {
      "id": "13",
    });

    if (response.statusCode == 200) {
      return (json.decode(response.body)['data'] as List)
          .map((e) => ProductMap.fromJson(e))
          .toList();
    } else {
      throw Exception("Failed to load cat fact!");
    }
  }
}
