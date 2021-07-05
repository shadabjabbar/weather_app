import '../services/location.dart';
import '../services/network.dart';
class WeatherModel {
  String apikey = '8429f53e3bacd0730198333255737d7d';
  Future<dynamic> getWeatherByCity(String city)async
  {
    String url='https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apikey';
    NetworkHelper networkHelper = NetworkHelper(url);
    var decodeJsonData = await networkHelper.getData();
    return decodeJsonData;
  }
  Future<dynamic> network()async
  {
    Location location = Location();
    await location.getLocation(); //calling function from location.dart
    String url =
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apikey';
    NetworkHelper networkHelper = NetworkHelper(url);
    var decodeJsonData = await networkHelper.getData();
    return decodeJsonData;
  }
}