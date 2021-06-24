import 'package:flutter/material.dart';
import 'package:pre_mon/src/bloc/provider.dart';
import 'package:pre_mon/src/pages/home_page.dart';
import 'package:pre_mon/src/pages/login_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {

  final primaryColor = const Color(0xff1a1a2e);
  final secundaryColor = const Color(0xff16213e);
  final terciaryColor = const Color(0xff0f3460);
  final cuaternaryColor = const Color(0xffe94560);

  @override
  Widget build(BuildContext context) {

    final app = MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login' : (BuildContext context) => LoginPage(),
        'home' : (BuildContext context) => HomePage(),
      },
      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: secundaryColor,
      ),
    );

    return Provider(child: app,);
  }
}