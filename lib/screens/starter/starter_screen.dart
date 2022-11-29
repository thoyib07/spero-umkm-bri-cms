import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:umkm_bri/screens/home/home_screen.dart';
import 'package:umkm_bri/screens/splash/splash_screen.dart';
import 'package:umkm_bri/size_config.dart';

class StarterScreen extends StatefulWidget {
  static String routeName = "/starter";

  const StarterScreen({super.key});

  @override
  State<StarterScreen> createState() => _StarterScreenState();
}

class _StarterScreenState extends State<StarterScreen> {
  void checkingData() async {
    final prefs = await SharedPreferences.getInstance();
    Future.delayed(const Duration(milliseconds: 1000), () {
      var data = prefs.getBool('loggedIn');
      // if (data == true) {
      //   Navigator.pushNamed(context, HomeScreen.routeName);
      // } else {
      Navigator.pushNamed(context, SplashScreen.routeName);
      // }
    });
  }

  @override
  void initState() {
    checkingData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
