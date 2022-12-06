import 'package:flutter/material.dart';
import 'package:umkm_bri/components/default_button.dart';
import 'package:umkm_bri/screens/home/home_screen.dart';
import 'package:umkm_bri/service/send_notif.dart';
import 'package:umkm_bri/size_config.dart';
import 'package:umkm_bri/service/order_service.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.04),
        Image.asset(
          "assets/images/success.png",
          height: SizeConfig.screenHeight * 0.4, //40%
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.08),
        Text(
          "Order Success",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(30),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth * 0.6,
          child: DefaultButton(
              text: "Home",
              // press: () {
              //   Navigator.pushReplacement(context,
              //       MaterialPageRoute(builder: (context) => HomeScreen()));
              //   ;
              // },
              press: () async {
                await SendNotif.process(context);
              }),
        ),
        Spacer(),
      ],
    );
  }
}
