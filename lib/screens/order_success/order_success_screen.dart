import 'package:flutter/material.dart';

import 'components/body.dart';

class OrderSuccessScreen extends StatelessWidget {
  static String routeName = "/login_success";
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            leading: SizedBox(),
            title: Text("Order Berhasil"),
          ),
          body: Body(),
        ));
  }
}
