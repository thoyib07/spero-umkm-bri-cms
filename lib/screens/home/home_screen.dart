import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:umkm_bri/components/coustom_bottom_nav_bar.dart';
// import 'package:umkm_bri/enums.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:umkm_bri/models/ProductMap.dart';
import '../../../size_config.dart';
import 'components/categories.dart';
import 'components/home_header.dart';
// import 'components/popular_product.dart';
// import 'components/product_second.dart';
import 'components/section_title.dart';
import 'package:umkm_bri/components/product_card.dart';
import '../../constants.dart';
// import '../../size_config.dart';
import 'package:umkm_bri/screens/details/details_screen.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GetStorage box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            maintainBottomViewPadding: false,
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
                        child:
                            SectionTitle(title: "Semua Product", press: () {}),
                      ),
                    ],
                  ),
                  FutureBuilder<List<ProductMap>>(
                    future: fetchProductMaps(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<ProductMap> products =
                            snapshot.data as List<ProductMap>;
                        return GridView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: products.length,
                            padding: const EdgeInsets.all(5),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 190,
                              childAspectRatio: 3 / 2,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) {
                              print(products[index].isPopular);
                              if (products[index].isPopular) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      left: getProportionateScreenWidth(5),
                                      right: getProportionateScreenWidth(5)),
                                  child: SizedBox(
                                    width: getProportionateScreenWidth(60),
                                    child: GestureDetector(
                                      onTap: () => Navigator.pushNamed(
                                        context,
                                        DetailsScreen.routeName,
                                        arguments: ProductDetailsArguments(
                                            product: products[index]),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AspectRatio(
                                            aspectRatio: 2,
                                            child: Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  10, 10, 10, 5),
                                              padding: EdgeInsets.all(
                                                  getProportionateScreenWidth(
                                                      5)),
                                              decoration: BoxDecoration(
                                                color: kSecondaryColor
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Hero(
                                                tag: products[index]
                                                    .id
                                                    .toString(),
                                                // tag: generateRandomString,
                                                child: FadeInImage.assetNetwork(
                                                  fit: BoxFit.contain,
                                                  placeholder: '',
                                                  // "assets/loading.gif",
                                                  image: products[index]
                                                          .imgLocation +
                                                      products[index].imgHash,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "${products[index].title}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize:
                                                          getProportionateScreenWidth(
                                                              12)),
                                                  maxLines: 2,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                              height:
                                                  getProportionateScreenWidth(
                                                      2)),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              products[index].stock > 1
                                                  ? Text(
                                                      // "Stock : ${product.stock}",
                                                      "Tersedia",
                                                      style: TextStyle(
                                                        fontSize:
                                                            getProportionateScreenWidth(
                                                                14),
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
                                                                14),
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
                                                        "Stock : ${products[index].stock}",
                                                        style: TextStyle(
                                                            fontSize:
                                                                getProportionateScreenWidth(
                                                                    10)))),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return SizedBox.shrink();
                            });
                      } else {
                        // print("test");
                        return Text('');
                      }
                      if (snapshot.hasError) {
                        // print(snapshot.error.toString());
                        return Text('');
                        // SizedBox();
                      }
                    },
                  )
                ],
              ),
            )));
  }

  Future<List<ProductMap>> fetchProductMaps() async {
    try {
      final getProductById = Uri.parse('http://66.42.50.59/api/listProduct');
      http.Response response = await http.post(getProductById, headers: {
        "Accept": "application/json",
      }, body: {
        "id": "${box.read('id')}",
      });

      if (response.statusCode == 200) {
        return (json.decode(response.body)['data'] as List)
            .map((e) => ProductMap.fromJson(e))
            .toList();
      } else {
        throw Exception("Failed to load cat fact!");
      }
    } catch (Exc) {
      print(Exc);
      rethrow;
    }
  }
}
