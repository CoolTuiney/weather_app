import 'package:flutter/cupertino.dart';
import 'package:weather_app/models/adress.dart';
import 'package:weather_app/repository/repository.dart';

class CurrentLocationProvider extends ChangeNotifier {
  Repository repository = Repository();
  Address? address;
  Address? get getAdress => address;

  Future<Address?> fetchLocation() async {
    address = await repository.getCurrentLocation();
    notifyListeners();
    return address;
  }
}
