import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:umkm_bri/models/HistoryTrans.dart';
import 'package:umkm_bri/providers/product_providers.dart';
import 'package:umkm_bri/screens/home/components/drawer_card.dart';
import 'package:umkm_bri/screens/home/components/icon_btn_with_counter.dart';
import 'package:umkm_bri/screens/profile/profile_screen.dart';
// import 'package:umkm_bri/screens/profile/profile_screen.dart';
import '../../../size_config.dart';
import 'components/categories.dart';
import 'components/search_header.dart';
import 'components/section_title.dart';
import 'package:umkm_bri/components/product_card.dart';
// import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GetStorage box = GetStorage();
  late ProductProviders productProviders;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  String? Categories;
  int? trigCategories;
  @override
  void initState() {
    super.initState();
    Categories = "";
    trigCategories = 0;
    // productProviders.getProducts();
  }

  // Timer mytimer = Timer.periodic(const Duration(seconds: 5), (timer) {});

  @override
  void didChangeDependencies() {
    productProviders = Provider.of<ProductProviders>(context);
    if (box.read('search') == "") {
      productProviders.getProducts();
    }
    super.didChangeDependencies();
  }

  void changeFunction(dataSearch) async {
    if (box.read('search') != "") {
      await productProviders.getProductsByKeyword(dataSearch);
    } else {
      log("tedt");
      productProviders.getProducts();
    }
  }

  void selectCategories(dataCategory) async {
    if (dataCategory != "") {
      await productProviders.getProductsByCategories(dataCategory);
    } else {
      productProviders.getProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {
        "icon": "assets/icons/man-belt-icon.svg",
        "text": "Accessories",
        "id": "1"
      },
      {
        "icon": "assets/icons/interior-icon.svg",
        "text": "Home Decor & Craft",
        "id": "2"
      },
      {
        "icon": "assets/icons/food-and-drink-icon.svg",
        "text": "Food & Beverages",
        "id": "3"
      },
      {
        "icon": "assets/icons/girl-dress-icon.svg",
        "text": "Fashion",
        "id": "4"
      },
      {
        "icon": "assets/icons/power-cord-icon.svg",
        "text": "Electronics",
        "id": "5"
      },
    ];
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
            key: _key,
            endDrawer: const Drawer(child: DrawerCard()),
            body: SafeArea(
                maintainBottomViewPadding: false,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: getProportionateScreenWidth(20)),
                      Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(20)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 50.0,
                                    child: Image.asset(
                                        "assets/images/Bri-logo.png"),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconBtnWithCounter(
                                        svgSrc: "assets/icons/Bell.svg",
                                        numOfitem: box.read("notif"),
                                        press: () {
                                          _key.currentState!.openEndDrawer();
                                        },
                                      ),
                                      const SizedBox(width: 10),
                                      IconBtnWithCounter(
                                        svgSrc:
                                            "assets/icons/logout-svgrepo-com.svg",
                                        press: () {
                                          SystemNavigator.pop();
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              )),
                        ],
                      ),
                      SizedBox(height: getProportionateScreenWidth(20)),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(20)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Search(
                                    onchange: (data) => changeFunction(data)),
                              ])),
                      Padding(
                        padding:
                            EdgeInsets.all(getProportionateScreenWidth(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            categories.length,
                            (index) => CategoryCard(
                              icon: categories[index]["icon"],
                              text: categories[index]["text"],
                              value: Categories,
                              id: categories[index]["id"].toString(),
                              press: () {
                                if (Categories == categories[index]["id"]) {
                                  setState(() {
                                    Categories = "";
                                  });
                                  productProviders.getProducts();
                                } else {
                                  setState(() {
                                    Categories = categories[index]["id"];
                                  });
                                  selectCategories(categories[index]["id"]);
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenWidth(10)),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getProportionateScreenWidth(20)),
                            child: SectionTitle(
                                title: "Semua Product", press: () {}),
                          ),
                        ],
                      ),
                      if (productProviders.products.isEmpty)
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          height: 500,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("No Data",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: getProportionateScreenWidth(20))),
                          ),
                        ),
                      GridView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        padding: const EdgeInsets.all(5),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 190,
                          childAspectRatio: 1.15,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 10,
                        ),
                        children: [
                          ...productProviders.products
                              .map((product) => ProductCard(product: product))
                              .toList()
                        ],
                      )
                    ],
                  ),
                ))));
  }
}
