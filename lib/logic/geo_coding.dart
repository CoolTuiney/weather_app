import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/logic/location_position.dart';
import 'package:weather_app/models/adress.dart';

class GeoCoding {
  Future<Address?> getAddressFromLatAndLong() async {
    LocationPosition locationPosition = LocationPosition();
    Position? position = await locationPosition.getGeoLocationPosition();
    if (position != null) {
      List<Placemark> placemark =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Address address = Address.fromPlacemark(placemark[0]);
      return address;
    }
  }
}
