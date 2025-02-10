import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:os_basecode/os_basecode.dart';

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    await Geolocator.openLocationSettings();

    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );
  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition(
    locationSettings: locationSettings,
  );
}

Future<bool> checkIsOnLocation() async {
  bool serviceEnabled;
  LocationPermission permission;
  SharedPreferences pref = await SharedPreferences.getInstance();
  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    await Geolocator.openLocationSettings();

    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );
  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  var currentLocation = await Geolocator.getCurrentPosition(
    locationSettings: locationSettings,
  );
  var buildingLatitude = pref.getDouble("storeLatitude") ?? -6.909682;
  var buildingLongitude = pref.getDouble("storeLongitude") ?? 107.723175;
  if (buildingLatitude == 0 && buildingLongitude == 0) {
    log("Building Location not set correctly, please set it manually", name: "GEOLOCATOR");
    return Future.error("Building Location not set correctly, please set it manually");
  }
  var distanceBetweenResult = Geolocator.distanceBetween(
      currentLocation.latitude, currentLocation.longitude, buildingLatitude, buildingLongitude);
  log("Distance : ${distanceBetweenResult.toString()}", name: "GEOLOCATOR");
  return distanceBetweenResult < 50;
}
