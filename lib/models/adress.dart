import 'package:geocoding/geocoding.dart';

class Address {
  String? country;
  String? locality;
  String? subLocality;
  String? state;
  String? postalCode;

  Address({
    this.country,
    this.locality,
    this.subLocality,
    this.state,
    this.postalCode,
  });

  Address.fromPlacemark(Placemark placemark) {
    country = placemark.country;
    locality = placemark.locality;
    subLocality = placemark.subLocality;
    state = placemark.administrativeArea;
    postalCode = placemark.postalCode;
  }
}
