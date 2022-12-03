import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:umkm_bri/models/Product.dart';
import 'package:umkm_bri/models/ProductMap.dart';

import '../service/product_service.dart';

class ProductProviders with ChangeNotifier {
  List<ProductMap> _productMap = [];

  List<ProductMap> get products => _productMap;

  set products(List<ProductMap> products) {
    _productMap = products;
    notifyListeners();
  }

  Future<void> getProducts() async {
    try {
      List<ProductMap> products = await ProductService().fetchProductMaps();
      _productMap = products;
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> getProductsByKeyword(String keyword) async {
    log('tes');
    try {
      List<ProductMap> products =
          await ProductService().fetchProductByKeywordMaps(keyword);
      _productMap = products;
      log(_productMap.toString());
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }
}
