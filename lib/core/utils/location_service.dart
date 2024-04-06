import 'package:location/location.dart';

class LocationService {
  Location location = Location();
  Future<void> checkandRequestLocationService() async {
    var isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
      if (!isServiceEnabled) {
        throw LocationServiceException();
      }
    }
  }

  Future<void> checkandRequestLocationPermission() async {
    var isPermissionGranted = await location.hasPermission();
    if (isPermissionGranted == PermissionStatus.deniedForever) {
      throw LocationPermissionException();
    }
    if (isPermissionGranted == PermissionStatus.denied) {
      isPermissionGranted = await location.requestPermission();
      if (isPermissionGranted != PermissionStatus.granted) {
        throw LocationPermissionException();
      }
    }
  }

  void getRealTimeLocation({void Function(LocationData)? onData}) async {
    // location.changeSettings(distanceFilter: 2);
    await checkandRequestLocationService();
    await checkandRequestLocationPermission();
    location.onLocationChanged.listen(onData);
  }

  Future<LocationData> getLocation() async {
    await checkandRequestLocationService();
    await checkandRequestLocationPermission();
    return await location.getLocation();
  }
}

class LocationServiceException implements Exception {}

class LocationPermissionException implements Exception {}
