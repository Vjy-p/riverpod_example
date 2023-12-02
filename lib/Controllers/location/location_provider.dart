import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

class CheckLocation extends ChangeNotifier {
  // bool locationPermission = false;
  bool locationStatus = false;
  bool hasLocationPermission = false;
  late LocationPermission permission;

  checkLocationPermissions() async {
    locationStatus = await Geolocator.isLocationServiceEnabled();
    notifyListeners();
    debugPrint("\nLocation $locationStatus");

    // if (locationStatus) {
    //   permission = await Geolocator.checkPermission();
    //   debugPrint("\nGPS $permission");
    //   if (permission == LocationPermission.denied) {
    //     permission = await Geolocator.requestPermission();
    //     if (permission == LocationPermission.denied) {
    //       debugPrint("\npermission denied");
    //       checkLocationPermissions();
    //     } else if (permission == LocationPermission.deniedForever) {
    //       debugPrint("\npermission denied forever");
    //       // await Geolocator.openAppSettings();
    //       // checkLocationPermissions();
    //     } else {
    //       hasLocationPermission = true;
    //       notifyListeners();
    //     }
    //   } else {
    //     hasLocationPermission = true;
    //     notifyListeners();
    //   }
    // } else {
    //   debugPrint("\nGPS disabled");
    //   // await Geolocator.openLocationSettings();
    //   // checkLocationPermissions();
    // }
    permission = await Geolocator.checkPermission();
    debugPrint("\nGPS $permission");
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint("\npermission denied");
        checkLocationPermissions();
      } else if (permission == LocationPermission.deniedForever) {
        debugPrint("\npermission denied forever");
        await Geolocator.openAppSettings();
        // checkLocationPermissions();
      } else {
        hasLocationPermission = true;
        notifyListeners();
      }
    } else {
      hasLocationPermission = true;
      notifyListeners();
    }

    if (hasLocationPermission) {
      if (!locationStatus) {
        await Geolocator.openLocationSettings();
        notifyListeners();
      }
    }
  }
}

final checkLocationProvider =
    ChangeNotifierProvider<CheckLocation>((ref) => CheckLocation());
