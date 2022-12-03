import 'dart:math';

import 'package:flutter/material.dart';
import 'package:umkm_bri/models/ProductMap.dart';
import 'package:umkm_bri/screens/details/details_screen.dart';

import '../constants.dart';
import '../size_config.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
  }) : super(key: key);

  final double width, aspectRetio;
  final ProductMap product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: getProportionateScreenWidth(5),
          right: getProportionateScreenWidth(5)),
      child: SizedBox(
        width: getProportionateScreenWidth(80),
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            DetailsScreen.routeName,
            arguments: ProductDetailsArguments(product: product),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.8,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  padding: EdgeInsets.all(getProportionateScreenWidth(5)),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4)),
                  ),
                  child: Hero(
                    tag: product.id.toString(),
                    // tag: generateRandomString,
                    child: FadeInImage.assetNetwork(
                      fit: BoxFit.contain,
                      placeholder: "assets/loading.gif",
                      image: product.imgLocation + product.imgHash,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 252, 252, 252),
                  border: Border(
                    top: BorderSide(
                        color: Color.fromARGB(51, 89, 89, 89),
                        width: 1.0,
                        style: BorderStyle.solid),
                    bottom: BorderSide(
                        color: Color.fromARGB(51, 89, 89, 89),
                        width: 1.0,
                        style: BorderStyle.solid),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            product.title,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: getProportionateScreenWidth(12)),
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: getProportionateScreenWidth(5)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        product.stock > 1
                            ? Text(
                                // "Stock : ${product.stock}",
                                "Tersedia",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(13),
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 79, 184, 63),
                                ),
                              )
                            : Text(
                                // "Stock : ${product.stock}",
                                "Habis",
                                style: TextStyle(
                                  fontSize: getProportionateScreenWidth(13),
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFFF6625E),
                                ),
                              ),
                        InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () {},
                          child: Container(
                              padding: EdgeInsets.all(
                                  getProportionateScreenWidth(4)),
                              decoration: const BoxDecoration(
                                shape: BoxShape.rectangle,
                              ),
                              child: Text("Stock : ${product.stock}",
                                  style: TextStyle(
                                      fontSize:
                                          getProportionateScreenWidth(10)))),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
