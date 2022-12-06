import 'dart:developer';

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:umkm_bri/screens/home/home_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:umkm_bri/screens/order_success/order_success_screen.dart';

class SendNotif {
  static final _client = http.Client();
  static final _orderUrl = Uri.parse('http://66.42.50.59/sendNotif');

  static process(context) async {
    GetStorage box = GetStorage();
    var id = box.read('id');
    var counter = box.read('counter');

    http.Response response = await http.post(_orderUrl, body: {});

    // if (response.statusCode == 200) {
    // log(jsonDecode(response.body));
    // var json = jsonDecode(response.body);
    await EasyLoading.showError("Send Notif gudang Berhasil");
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
    // } else {
    // await EasyLoading.showError("Send Notif gudang Gagal");
    // }
  }
}
