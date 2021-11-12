class Weather {
  String? weather;
  String? description;
  String? country;
  String? place;
  String? name;
  int? currentTemperature;
  int? minTemperature;
  int? maxTemperature;
  int? humidity;
  int? wind;
  int? feelsLike;
  int? timeZone;
  int? windDirection;

  Weather(
      {this.weather,
      this.description,
      this.currentTemperature,
      this.minTemperature,
      this.maxTemperature,
      this.humidity,
      this.wind,
      this.timeZone,
      this.country,
      this.name,
      this.place,
      this.windDirection,
      this.feelsLike});

  Weather.fromMap(Map<String, dynamic> jsonData) {
    double temp = jsonData['main']['temp'];
    double _mintemp = jsonData['main']['temp'];
    double _maxtemp = jsonData['main']['temp'];
    double _wind = jsonData['wind']['speed'];
    double _feelsLike = jsonData['main']['feels_like'];

    name = jsonData['name'];
    humidity = jsonData['main']['humidity'];
    windDirection = jsonData['wind']['deg'];
    description = jsonData['weather'][0]['description'];
    weather = jsonData['weather'][0]['main'];
    country = jsonData['sys']['country'];
    place = jsonData['name'];
    timeZone = jsonData['timezone'];
    currentTemperature = temp.round();
    minTemperature = _mintemp.round();
    maxTemperature = _maxtemp.round();
    feelsLike = _feelsLike.round();
    wind = _wind.floor();
  }
}
