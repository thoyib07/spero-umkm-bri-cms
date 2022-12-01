import 'package:flutter/material.dart';
import 'package:umkm_bri/screens/home/home_screen.dart';

import '../../models/ProductMap.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';
import 'package:get_storage/get_storage.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";
  @override
  Widget build(BuildContext context) {
    GetStorage box = GetStorage();
    box.write('counter', 0);
    final ProductDetailsArguments agrs =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: CustomAppBar(stock: agrs.product.stock),
      ),
      body: Body(product: agrs.product),
    );
  }
}

class ProductDetailsArguments {
  final ProductMap product;

  ProductDetailsArguments({required this.product});
}
