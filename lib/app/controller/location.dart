import 'package:geolocator/geolocator.dart';

class Location {
  late double latitude = 0.0;
  late double longitude = 0.0;

  Future<void> getCurrentLocation() async {
    try {
      Position? position = await Geolocator.getLastKnownPosition();

      latitude = position!.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}
