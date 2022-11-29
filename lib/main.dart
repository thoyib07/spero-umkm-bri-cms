import 'package:flutter/material.dart';
import 'package:umkm_bri/routes.dart';
import 'package:umkm_bri/screens/profile/profile_screen.dart';
import 'package:umkm_bri/screens/splash/splash_screen.dart';
import 'package:umkm_bri/screens/starter/starter_screen.dart';
import 'package:umkm_bri/size_config.dart';
import 'package:umkm_bri/theme.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
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
      // initialRoute: SplashScreen.routeName,
      initialRoute: StarterScreen.routeName,
      routes: routes,
      builder: EasyLoading.init(),
    );
  }
}
