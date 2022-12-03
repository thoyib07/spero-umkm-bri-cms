import 'dart:developer';

import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:umkm_bri/models/ProductMap.dart';
import 'package:http/http.dart' as http;

class ProductService {
  Future<List<ProductMap>> fetchProductMaps() async {
    try {
      GetStorage box = GetStorage();

      final getProductById = Uri.parse('http://66.42.50.59/api/listProduct');
      http.Response response = await http.post(getProductById, headers: {
        "Accept": "application/json",
      }, body: {
        "id": "${box.read('id')}",
      });
      // log(response.body.toString());
      if (response.statusCode == 200) {
        return (json.decode(response.body)['data'] as List)
            .map((e) => ProductMap.fromJson(e))
            .toList();
      } else {
        throw Exception("Failed to load data!");
      }
    } catch (Exc) {
      log(Exc.toString());
      rethrow;
    }
  }

  Future<List<ProductMap>> fetchProductByKeywordMaps(String keyWord) async {
    try {
      GetStorage box = GetStorage();

      final getProductById =
          Uri.parse('http://66.42.50.59/api/searchProductByName');
      http.Response response = await http.post(getProductById, headers: {
        "Accept": "application/json",
      }, body: {
        "id": "${box.read('id')}",
        "name": "${keyWord}",
      });

      log(response.body.toString());

      if (response.statusCode == 200) {
        return (json.decode(response.body)['data'] as List)
            .map((e) => ProductMap.fromJson(e))
            .toList();
      } else {
        throw Exception("Failed to load test!");
      }
    } catch (Exc) {
      log(Exc.toString());
      rethrow;
    }
  }
}
