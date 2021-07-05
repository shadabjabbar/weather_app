import 'package:flutter/material.dart';
import './screens/loading_screen.dart';
import './utilities/location_style.dart';
import 'package:flutter/services.dart';
void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: kBackgroundColor,));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: kBackgroundColor,
        fontFamily: 'Raleway',
      ),
      home: LoadingScreen(),//CityScreen()
    );
  }
}
