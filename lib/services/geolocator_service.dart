import 'package:geolocator/geolocator.dart';

class GeoLocatorService {
  Future<String> getCurrentCoordination() async {
    String positionCoordination = '';
    try {
      await Geolocator.requestPermission();
      positionCoordination = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best)
          .then((position) =>
              'lat=${position.latitude}&lon=${position.longitude}');
    } catch (e) {
      print('សេវាប្រាប់ទិសតំបន់ត្រូវបានបិទ! $e');
    }
    return positionCoordination;
  }
}
