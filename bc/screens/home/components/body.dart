import 'package:flutter/material.dart';
import 'package:umkm_bri/models/Product.dart';

import '../../../size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'product_second.dart';
import 'special_offers.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(height: getProportionateScreenHeight(20)),
            // SpecialOffers(),
            // SizedBox(height: getProportionateScreenWidth(10)),
            // DiscountBanner(),
            SizedBox(height: getProportionateScreenWidth(20)),
            HomeHeader(),
            Categories(),
            SizedBox(height: getProportionateScreenWidth(10)),
            PopularProducts(),
            SizedBox(height: getProportionateScreenWidth(30)),
            ProductSecond(),
            // SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
