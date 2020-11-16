import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:schoolapp/Screens/ClassChat.dart';

import 'package:schoolapp/Screens/DrawerPage.dart';
import 'package:schoolapp/Screens/HomePage.dart';
import 'package:schoolapp/Screens/LoginPage.dart';
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
     
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
     // home:ClassChat(),
      home: MyPage(),
    );
  }
}


class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
    final _drawerController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return  ZoomDrawer(
      controller: _drawerController,
      menuScreen: MyDrawer(drawerController: _drawerController,),
      mainScreen: HomePage(),
      borderRadius: 22.0,
      showShadow: false,
      slideWidth: MediaQuery.of(context).size.width*.6,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.easeInCubic,
    );
  }
}