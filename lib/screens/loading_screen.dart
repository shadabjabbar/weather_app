import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import './location_screen.dart';

import '../services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  double? longitude, latitude;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  void getLocation() async {
    var decodeJsonData = await WeatherModel().network();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){return LocationScreen(decodeJsonData);},),);
  }

  @override
  Widget build(BuildContext context) {
    print('Inside Build Method');
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         SpinKitDoubleBounce(
            color: Colors.white,
            size: 100.0,
          ),
          SizedBox(height:20),
          Text('T-Clima is Loading',style: TextStyle(color: Colors.white,fontSize: 25,fontFamily: 'Pacifico'),),
        ],
      ),
    );
  }
}
