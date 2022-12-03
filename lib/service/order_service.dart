import 'dart:developer';

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:umkm_bri/screens/home/home_screen.dart';
import 'package:umkm_bri/screens/login_success/login_success_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:umkm_bri/screens/order_success/order_success_screen.dart';
import 'package:umkm_bri/models/ProductMap.dart';

class OrderService {
  static final _client = http.Client();
  static final _orderUrl = Uri.parse('http://66.42.50.59/api/order');

  static process(int idProduct, context) async {
    GetStorage box = GetStorage();
    var id = box.read('id');
    var counter = box.read('counter');

    http.Response response = await http.post(_orderUrl, headers: {
      "Accept": "application/json",
    }, body: {
      "id_admin": "$id",
      "id_product": "$idProduct",
      "jmlh": "$counter"
    });

    log(id);
    log(idProduct.toString());
    log(counter);
    log(response.body);

    if (response.statusCode == 200) {
      log(jsonDecode(response.body));
      var json = jsonDecode(response.body);

      await EasyLoading.showSuccess("Pemesanan berhasil");
      await Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => OrderSuccessScreen()));
    } else {
      await EasyLoading.showError("Pemesanan gagal");
    }
  }
}
