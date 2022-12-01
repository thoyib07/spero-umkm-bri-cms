import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:umkm_bri/screens/login_success/login_success_screen.dart';
import 'package:get_storage/get_storage.dart';

class HttpService {
  static final _client = http.Client();
  // final box = GetStorage();

  static final _loginUrl = Uri.parse('http://66.42.50.59/api/login');

  static final _registerUrl = Uri.parse('http://66.42.50.59/api/register');

  static login(email, password, context) async {
    http.Response response = await http.post(_loginUrl, headers: {
      "Accept": "application/json",
    }, body: {
      "email": email,
      "password": password,
    });

    print(response.statusCode);

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      var json = jsonDecode(response.body);

      // if (json[0] == 'success') {
      GetStorage box = GetStorage();

      box.write('email', json["data"]["email"]);
      box.write('name', json["data"]["name"]);
      box.write('id', json["data"]["id"]);
      await EasyLoading.showSuccess("Login success");
      await Navigator.push(context,
          MaterialPageRoute(builder: (context) => LoginSuccessScreen()));
      // } else {
      //   EasyLoading.showError(json[0]);
      // }
    } else {
      await EasyLoading.showError("Mohon periksa username atau password anda");
    }
  }

  static register(email, password, context) async {
    http.Response response = await _client.post(_registerUrl, body: {
      "email": email,
      "password": password,
    });

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (json[0] == 'username already exist') {
        await EasyLoading.showError(json[0]);
      } else {
        await EasyLoading.showSuccess(json[0]);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => LoginSuccessScreen()));
      }
    } else {
      await EasyLoading.showError(
          "Error Code : ${response.statusCode.toString()}");
    }
  }
}
