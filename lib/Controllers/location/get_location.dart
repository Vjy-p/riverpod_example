import 'package:example_riverpod/Controllers/location/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class GetLocation extends ChangeNotifier {
  Position? currentLocation;
  location() async {
    currentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    notifyListeners();
    List<Placemark> addresses = await placemarkFromCoordinates(
        currentLocation!.latitude, currentLocation!.longitude);
    debugPrint("\ncurrent location $currentLocation");
    debugPrint("\nAddress ${addresses.first}");
    // LocationSettings locationSettings = const LocationSettings(
    //     accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 10);
    // positionStream =
    //     Geolocator.getPositionStream(locationSettings: locationSettings)
    //         .listen((pos) {
    //   currentLocation = pos;

    //   debugPrint("\ncurrent location $currentLocation");
    // addMarker(
    //     id: "source",
    //     latLng: LatLng(currentLocation!.latitude, currentLocation!.longitude),
    //     icon: sourceIcon);
    // });
  }
}

final locationProvider = ChangeNotifierProvider((ref) => GetLocation());
