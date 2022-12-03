import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DrawerCard extends StatelessWidget {
  const DrawerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(color: Colors.grey.shade500),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg'),
                radius: 40.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Tom Cruise',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 25.0),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'tomcruise@gmail.com',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 14.0),
                  ),
                ],
              )
            ],
          ),
        ),

        //Here you place your menu items
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Home Page', style: TextStyle(fontSize: 18)),
          onTap: () {
            // Here you can give your route to navigate
          },
        ),
        Divider(height: 3.0),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings', style: TextStyle(fontSize: 18)),
          onTap: () {
            // Here you can give your route to navigate
          },
        ),
        ListTile(
          leading: Icon(Icons.close),
          title: Text('Close Drawer', style: TextStyle(fontSize: 18)),
          onTap: () {
            // Here you can give your route to navigate
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
