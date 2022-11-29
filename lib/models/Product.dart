import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

final oCcy = NumberFormat("#.##0", "en_US");

class Product {
  final int id;
  final String title, description, price;
  final List<String> images;
  final List<Color> colors;
  final int stock;
  final bool isFavourite, isPopular;

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
}

Future funcGetProduct() async {
  final _client = http.Client();
  // GetStorage box = GetStorage();
  final idUser = () => GetStorage('id');

  final _getProductById = Uri.parse('http://66.42.50.59/api/listProduct');
  http.Response response = await http.post(_getProductById, headers: {
    "Accept": "application/json",
  }, body: {
    "id": idUser,
  });
  List<Product> dataProducts = List<Product>.empty();
  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
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
    return dataProducts;
  } else {
    await EasyLoading.showError(
        "Error Code : ${response.statusCode.toString()}");
    return [];
  }
}

List<Product> demoProducts = [
  Product(
    id: 1,
    images: [
      "assets/images/ps4_console_white_1.png",
      "assets/images/ps4_console_white_2.png",
      "assets/images/ps4_console_white_3.png",
      "assets/images/ps4_console_white_4.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Wireless Controller for PS4™",
    price: "64.000",
    description: description,
    stock: 0,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: 2,
    images: [
      "assets/images/Image Popular Product 2.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Nike Sport White - Man Pant",
    price: "50.000",
    description: description,
    stock: 100,
    isPopular: true,
  ),
  Product(
    id: 3,
    images: [
      "assets/images/glap.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Gloves XC Omega - Polygon",
    price: "36.000",
    description: description,
    stock: 100,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: 4,
    images: [
      "assets/images/wireless headset.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Logitech Head",
    price: "20.000",
    description: description,
    stock: 100,
    isFavourite: true,
  ),
];

const String description =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
