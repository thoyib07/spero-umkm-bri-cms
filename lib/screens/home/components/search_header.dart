import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../size_config.dart';
import '../../../constants.dart';
import 'package:get_storage/get_storage.dart';

class Search extends StatefulWidget {
  final String? keyword;
  final Function? onchange;
  const Search({
    Key? key,
    this.keyword,
    this.onchange,
  }) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  GetStorage box = GetStorage();
  String? keyWord;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.89,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        textInputAction: TextInputAction.go,
        onSubmitted: (String value) {
          setState(() {
            box.write('search', value);
            log(box.read('search').toString());
          });
          widget.onchange!(value);
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
              vertical: getProportionateScreenWidth(20)),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          hintText: "Cari Tenant / Product",
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
