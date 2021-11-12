
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/repository/repository.dart';

class WeatherProvider extends ChangeNotifier {
  Weather? weather;
  final Repository _repository = Repository();
  Weather? get getWeather => weather;

  Future<Weather?> fetchWeather(String place, BuildContext context) async {
    var result = await _repository.getWeather(place);
  

    if (result != null && result is Weather) {
     
      weather = result;
      notifyListeners();
      return weather;
    } else if (result != null && result is String) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text('unable to load data please check internet connection..')));
    }
  }
}
