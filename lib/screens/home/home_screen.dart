import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:umkm_bri/providers/product_providers.dart';
import 'package:umkm_bri/screens/home/components/drawer_card.dart';
import 'package:umkm_bri/screens/home/components/icon_btn_with_counter.dart';
import 'package:umkm_bri/screens/profile/profile_screen.dart';
import '../../../size_config.dart';
import 'components/categories.dart';
import 'components/search_header.dart';
import 'components/section_title.dart';
import 'package:umkm_bri/components/product_card.dart';
import 'package:intl/intl.dart';

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
      productProviders.getProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
            key: _key,
            endDrawer: const Drawer(
              child: DrawerCard(),
            ),
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
                                        svgSrc: "assets/icons/User.svg",
                                        press: () => Navigator.pushNamed(
                                            context, ProfileScreen.routeName),
                                      ),
                                      const SizedBox(width: 10),
                                      IconBtnWithCounter(
                                        svgSrc: "assets/icons/Bell.svg",
                                        numOfitem: 5,
                                        press: () {
                                          _key.currentState!.openEndDrawer();
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
                      Categories(),
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
