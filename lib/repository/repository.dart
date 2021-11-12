
import 'package:weather_app/logic/geo_coding.dart';
import 'package:weather_app/logic/weather_api.dart';
import 'package:weather_app/models/adress.dart';
import 'package:weather_app/models/weather.dart';

class Repository {
  final WeatherApi _weatherApi = WeatherApi();
  final GeoCoding _geoCoding = GeoCoding();
  Future<dynamic> getWeather(String place) async {
   
    Map<String, dynamic>? result = await _weatherApi.getWeather(place);
    if (result != null && result.containsValue('city not found')) {
      return 'City not found';
    }
    if (result != null) {
     
      Weather weather = Weather.fromMap(result);
     
      return weather;
    }
   
    return null;
  }

  Future<Address?> getCurrentLocation() async {
    Address? result = await _geoCoding.getAddressFromLatAndLong();
    return result;
  }
}
