import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class WeatherApi {
  Future<Map<String, dynamic>?> getWeather(String place) async {
    String baseUrl = 'http://api.openweathermap.org/data/2.5/';
    final uri = Uri.parse('$baseUrl/weather').replace(queryParameters: {
      'q': place,
      'appid': 'a9ac2412c5e561001505af06e0023e2e',
      'units': 'metric'
    });
    try {
      final response = await http.get(uri);
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      debugPrint('$jsonData');
      return jsonData;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
