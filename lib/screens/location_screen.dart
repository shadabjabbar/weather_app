import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:intl/intl.dart';
import '../utilities/location_style.dart';
import '../reused_components/general_info.dart';
import '../services/weather.dart';
import './city_screen.dart';

class LocationScreen extends StatefulWidget {
  final weatherData;

  LocationScreen(this.weatherData);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  String city = '',
      country = '',
      temperature = '',
      weatherInfo = '',
      wind = '',
      humidity = '',
      feelsLike = '',
      pressure = '',
      day = '',
      msg = '';
  int id = 0;

  void initState() {
    super.initState();
    updateData(widget.weatherData);
  }

  void updateData(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        city = 'Error';
        country = 'Error';
        temperature = '0';
        weatherInfo = 'Not Loaded';
        wind = '0';
        humidity = '0';
        feelsLike = '0';
        pressure = '0';
        id = 0;
        day = '';
      }
      city = weatherData['name'];
      if (weatherData['sys']['country'] == 'IN') country = 'India';
      temperature = (weatherData['main']['temp'] - 273.15).toStringAsFixed(1);
      weatherInfo = weatherData['weather'][0]['main'];
      wind = (weatherData['wind']['speed']).toStringAsFixed(1); //wind.speed
      humidity = weatherData['main']['humidity'].toStringAsFixed(1);
      feelsLike =
          (weatherData['main']['feels_like'] - 273.15).toStringAsFixed(1);
      pressure = (weatherData['main']['pressure']).toStringAsFixed(1);
      id = weatherData['weather'][0]['id']; //weather[0].id
      day = (weatherData['weather'][0]['icon']).substring(2, 3);
      msg = getMessage().get(double.parse(temperature));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      color: kCardColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //Location Goes Here
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 20.0,
                                top: 40,
                              ),
                              child: Row(
                                children: [
                                  Icon(LineIcons.alternateMapMarker,
                                      color: kIconColor),
                                  Row(
                                    children: [
                                      Text(city,
                                          style: TextStyle(color: kTextColor)),
                                      Text(' / $country',
                                          style: TextStyle(
                                              color: kTextSecondaryColor)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //Cloud goes here
                                Expanded(
                                  flex: 2,
                                  child:
                                      WeatherIconChanger(id, day).changeIcon(),
                                ),
                                //Temperature goes here
                                Expanded(
                                  flex: 2,
                                  child: Text('$temperature°', style: kresult),
                                ),
                                //Weather Conditions goes here
                                Expanded(
                                  child: Text(
                                    weatherInfo,
                                    style: kWeatherConditions,
                                  ),
                                ),
                                //Date goes here
                                Expanded(
                                  child: Text(
                                      '${DateFormat().add_MMMMEEEEd().format(DateTime.now())}',
                                      style: kDateStyle),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 20,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      String cityName = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return CityScreen();
                                          },
                                        ),
                                      );
                                      if (cityName != null) {
                                        print(cityName);
                                        var searchData = await weather
                                            .getWeatherByCity(cityName);
                                        updateData(searchData);
                                      }
                                    },
                                    icon: Icon(LineIcons.city),
                                    color: Colors.white),
                                IconButton(
                                  onPressed: () async {
                                    var weatherRefreshData =
                                        await weather.network();
                                    print(weatherRefreshData);
                                    updateData(weatherRefreshData);
                                  },
                                  icon: Icon(LineIcons.alternateRedo),
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          //SizedBox(height: 25,),
                          ReusedIcon(LineIcons.wind, 'WIND', '$wind m/s'),
                          ReusedIcon(LineIcons.flask, 'HUMIDITY', humidity),
                          ReusedIcon(LineIcons.thermometer34Full, 'FEELS LIKE',
                              feelsLike + "°"),
                          ReusedIcon(
                              LineIcons.lineChart, 'PRESSURE', '$pressure hpa'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  child: Text('$msg in $city', style: kColumn2TextStyle),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherIconChanger {
  int id = 0;
  String day = '';

  WeatherIconChanger(this.id, this.day);

  @override
  Widget changeIcon() {
    IconData? ico;
    if (day == 'n') {
      if (id == 0) ico = LineIcons.alternateSync;
      if (id > 800)
        ico = LineIcons.cloudWithMoon;
      else if (id == 800)
        ico = LineIcons.moon;
      else if (id >= 700)
        ico = LineIcons.cloudversify;
      else if (id >= 600)
        ico = LineIcons.snowflake;
      else if (id >= 500)
        ico = LineIcons.cloudWithMoonAndRain;
      else if (id >= 300)
        ico = LineIcons.cloudWithRain;
      else
        ico = LineIcons.cloudWithHeavyShowers;
    } else if (day == 'd') {
      if (id > 800)
        ico = LineIcons.cloudWithSun;
      else if (id == 800)
        ico = LineIcons.sun;
      else if (id >= 700)
        ico = LineIcons.cloudversify;
      else if (id >= 600)
        ico = LineIcons.snowflake;
      else if (id >= 500)
        ico = LineIcons.cloudWithSunAndRain;
      else if (id >= 300)
        ico = LineIcons.cloudWithRain;
      else
        ico = LineIcons.cloudWithHeavyShowers;
    }
    return Icon(
      ico,
      size: 130,
      color: Colors.white,
    );
  }
}

class getMessage {
  String get(double temp) {
    if (temp > 35) {
      return 'It\'s a really hot day';
    } else if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp > 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
