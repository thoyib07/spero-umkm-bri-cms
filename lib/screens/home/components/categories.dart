import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../size_config.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/icons/Question mark.svg", "text": "Fashion"},
      {"icon": "assets/icons/Question mark.svg", "text": "Foods"},
      {"icon": "assets/icons/Question mark.svg", "text": "Snack"},
      {"icon": "assets/icons/Question mark.svg", "text": "Gift"},
      {"icon": "assets/icons/Question mark.svg", "text": "More"},
    ];
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          categories.length,
          (index) => CategoryCard(
            icon: categories[index]["icon"],
            text: categories[index]["text"],
            press: () {},
            id: null,
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
    this.value = "",
    this.id = "",
  }) : super(key: key);

  final String? icon, text, id, value;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(55),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                color: value == id
                    ? Color.fromARGB(255, 74, 155, 225)
                    : Color.fromARGB(255, 153, 214, 245),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(icon!,
                  color: value == id
                      ? Color.fromARGB(255, 255, 255, 255)
                      : Color.fromARGB(248, 255, 255, 255)),
            ),
            SizedBox(height: 5),
            Text(
              text!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10,
                  color: value == id
                      ? Color.fromARGB(255, 255, 144, 89)
                      : Color.fromARGB(248, 86, 86, 86)),
            )
          ],
        ),
      ),
    );
  }
}
