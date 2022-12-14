import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

final oCcy = NumberFormat("#.##0", "en_US");

class Product {
  Product({
    required this.id,
    required this.images,
    required this.colors,
    this.stock = 0,
    // this.idUser = "0",
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.description,
  });

  final int id;
  final String title, description, price;
  final List<String> images;
  final List<Color> colors;
  final int stock;
  final bool isFavourite, isPopular;

  factory Product.fromJson(Map json) {
    return Product(
      id: json["id"],
      images: [],
      title: json["nama"],
      colors: [],
      stock: json["stock"],
      description: "",
      price: json["price"],
    );
  }

  // static List<Product> fromJsonList(List json) {
  //   return json.map((e) => Product.fromJson(e as Map)).toList();
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'images': [],
  //     'title': title,
  //     'colors': [],
  //     'stock': stock,
  //     'description': description,
  //     'price': price,
  //   };
  // }

  // static List<Map<String, dynamic>> toJsonList(List<Product> list) {
  //   return list.map((e) => e.toJson()).toList();
  // }

}

Future<List<Product>> funcGetProduct(int idUser) async {
  final _client = http.Client();

  final _getProductById = Uri.parse('http://66.42.50.59/api/listProduct');
  http.Response response = await http.post(_getProductById, headers: {
    "Accept": "application/json",
  }, body: {
    "id": idUser,
  });
  List<Product> dataProducts = List<Product>.empty();
  if (response.statusCode == 200) {
    log(jsonDecode(response.body));
    var json = jsonDecode(response.body)['data'];
    dynamic notesJson = json;
    for (dynamic noteJson in notesJson) {
      /// here the issue
      dataProducts.add(
        Product(
            id: noteJson['id'],
            colors: [],
            description:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
            images: ["${noteJson['img_location']}${noteJson['img_hash']}"],
            price: '${oCcy.format(noteJson['price'])}',
            title: '${noteJson['nama']}',
            stock: noteJson['stock']),
      );
    }
    log(dataProducts.toString());
    return dataProducts;
  } else {
    await EasyLoading.showError(
        "Error Code : ${response.statusCode.toString()}");
    return [];
  }
}

// List<Product> demoProducts = funcGetProduct() as List<Product>;

const String description =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
