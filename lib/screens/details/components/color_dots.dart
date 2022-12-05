import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:umkm_bri/components/rounded_icon_btn.dart';
import 'package:umkm_bri/models/ProductMap.dart';
import 'package:get_storage/get_storage.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class Picker extends StatefulWidget {
  Picker({
    Key? key,
    required this.product,
    int? counter,
  }) : super(key: key);

  final ProductMap product;

  @override
  State<Picker> createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  // late ProductMap product;
  GetStorage box = GetStorage();
  int counter = 0;
  void incrementCounter() {
    setState(() {
      if (widget.product.stock <= counter) {
      } else {
        counter++;
        box.write('counter', counter);
      }
    });
  }

  void subtractCounter() {
    setState(() {
      if (counter > 0) {
        counter--;
        box.write('counter', counter);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Now this is fixed and only for demo
    int selectedColor = 3;

    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Jumlah : "),
          SizedBox(width: getProportionateScreenWidth(10)),
          RoundedIconBtn(
            icon: Icons.remove,
            press: subtractCounter,
          ),
          SizedBox(width: getProportionateScreenWidth(20)),
          Text('$counter'),
          SizedBox(width: getProportionateScreenWidth(20)),
          RoundedIconBtn(
            icon: Icons.add,
            showShadow: true,
            press: incrementCounter,
          ),
        ],
      ),
    );
  }
}

class ColorDot extends StatelessWidget {
  const ColorDot({
    Key? key,
    required this.color,
    this.isSelected = false,
  }) : super(key: key);

  final Color color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 2),
      padding: EdgeInsets.all(getProportionateScreenWidth(8)),
      height: getProportionateScreenWidth(40),
      width: getProportionateScreenWidth(40),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border:
            Border.all(color: isSelected ? kPrimaryColor : Colors.transparent),
        shape: BoxShape.circle,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
