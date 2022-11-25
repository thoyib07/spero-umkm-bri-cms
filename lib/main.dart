import 'package:flutter/material.dart';
import 'package:umkm_bri/routes.dart';
import 'package:umkm_bri/screens/profile/profile_screen.dart';
import 'package:umkm_bri/screens/splash/splash_screen.dart';
import 'package:umkm_bri/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UMKM BRI',
      theme: theme(),
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
