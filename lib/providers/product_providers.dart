import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:umkm_bri/models/HistoryTrans.dart';
import 'package:umkm_bri/models/Product.dart';
import 'package:umkm_bri/models/ProductMap.dart';

import '../service/product_service.dart';

class ProductProviders with ChangeNotifier {
  List<ProductMap> _productMap = [];
  List<HistoryTrans> _historyTrans = [];
  // int? countNotif = 0;

  List<ProductMap> get products => _productMap;
  List<HistoryTrans> get historyTrans => _historyTrans;

  set products(List<ProductMap> products) {
    _productMap = products;
    _historyTrans = historyTrans;
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
    log(keyword.toString());
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

  Future<void> getProductsByCategories(String category) async {
    log(category.toString());
    try {
      List<ProductMap> products =
          await ProductService().fetchProductByCategoriesMaps(category);
      _productMap = products;
      log(_productMap.toString());
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }

  fetchHistoryTrans() async {
    try {
      List<HistoryTrans> historyTrans =
          await ProductService().fetchHistoryTrans();
      _historyTrans = historyTrans;
      log(_historyTrans.toString());
      notifyListeners();
    } catch (e) {
      log(e.toString());
    }
  }
}
