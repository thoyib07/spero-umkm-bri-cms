import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:umkm_bri/models/Product.dart';
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
    String generateRandomString(int len) {
      var r = Random();
      return String.fromCharCodes(
          List.generate(len, (index) => r.nextInt(33) + 89));
    }

    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: SizedBox(
        width: getProportionateScreenWidth(width),
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
                aspectRatio: 1.02,
                child: Container(
                  padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                  decoration: BoxDecoration(
                    color: kSecondaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Hero(
                    // tag: product.id.toString(),
                    tag: generateRandomString,
                    child: Image.asset(product.images[0]),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                product.title,
                style: TextStyle(color: Colors.black),
                maxLines: 2,
              ),
              SizedBox(height: getProportionateScreenWidth(5)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  product.stock > 1
                      ? Text(
                          // "Stock : ${product.stock}",
                          "Tersedia",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(16),
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 130, 250, 112),
                          ),
                        )
                      : Text(
                          // "Stock : ${product.stock}",
                          "Habis",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(16),
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFF6625E),
                          ),
                        ),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {},
                    child: Container(
                        padding: EdgeInsets.all(getProportionateScreenWidth(4)),
                        // height: getProportionateScreenWidth(18),
                        // width: getProportionateScreenWidth(60),
                        decoration: BoxDecoration(
                          // color: Color.fromARGB(255, 255, 255, 255),
                          shape: BoxShape.rectangle,
                        ),
                        child: Text("Stock : ${product.stock}",
                            style: TextStyle(
                                fontSize: getProportionateScreenWidth(12)))),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
