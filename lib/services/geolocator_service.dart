import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GeoLocatorService {
  Future<String> getCurrentCoordination({
    required BuildContext context,
    LocationAccuracy locationAccuracy = LocationAccuracy.best,
  }) async {
    String positionCoordination = '';
    try {
      await Geolocator.requestPermission();
      positionCoordination =
          await Geolocator.getCurrentPosition(desiredAccuracy: locationAccuracy)
              .then((position) =>
                  'lat=${position.latitude}&lon=${position.longitude}');
    } catch (e) {
      print('សេវាប្រាប់ទិសតំបន់ត្រូវបានបិទ! $e');
    }
    return positionCoordination;
  }
}
