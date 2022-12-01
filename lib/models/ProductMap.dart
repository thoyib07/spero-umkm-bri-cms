import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

final oCcy = NumberFormat("#.##0", "en_US");

class ProductMap {
  int id, stock;
  String noProducts,
      name,
      nama,
      imgLocation,
      imgHash,
      title,
      description,
      price;
  final List<String> images;
  final List<Color> colors;
  final bool isFavourite, isPopular;
  final double width, aspectRetio;

  ProductMap(
      {required this.id,
      required this.name,
      required this.noProducts,
      required this.images,
      required this.colors,
      this.isFavourite = false,
      this.isPopular = true,
      required this.title,
      required this.price,
      required this.description,
      this.width = 140,
      this.aspectRetio = 1.02,
      this.imgHash = "",
      this.stock = 0,
      this.imgLocation = "",
      required this.nama});

  factory ProductMap.fromJson(Map<String, dynamic> json) {
    return ProductMap(
      id: json['id'],
      name: json['nama'],
      noProducts: json['no_products'],
      nama: json['nama'],
      stock: json['stock'],
      imgLocation: json['img_location'],
      imgHash: json['img_hash'],
      colors: [],
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      images: ["${json['img_location'] + json['img_hash']}"],
      price: '',
      title: json['nama'],
    );
  }
}
