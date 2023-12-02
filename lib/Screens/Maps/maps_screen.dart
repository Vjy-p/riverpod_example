import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  final Completer<GoogleMapController> mapcontroller =
      Completer<GoogleMapController>();

  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(17.4893219, 78.3929148),
    zoom: 15.4746,
  );
  LatLng destination = LatLng(17.49284678903577, 78.40242695063353);
  Set<Marker> markers = {};

  bool locationStatus = false;
  bool hasLocationPermission = false;
  late LocationPermission permission;
  late StreamSubscription<Position> positionStream;

  Position? currentLocation;

  @override
  initState() {
    checkLocationPermissions();
    setCustomIcons();
    super.initState();
  }

  checkLocationPermissions() async {
    locationStatus = await Geolocator.isLocationServiceEnabled();
    debugPrint("\nLocation $locationStatus");

    if (locationStatus) {
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
          checkLocationPermissions();
        } else {
          hasLocationPermission = true;
        }
      } else {
        hasLocationPermission = true;
      }
      if (hasLocationPermission) {
        setState(() {});
        getLocation();
      }
    } else {
      debugPrint("\nGPS disabled");
      await Geolocator.openLocationSettings();
      checkLocationPermissions();
    }
  }

  getLocation() async {
    currentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    debugPrint("\ncurrent location $currentLocation");

    setState(() {});
    LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 10);
    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((pos) {
      currentLocation = pos;
      setState(() {});
      debugPrint("\ncurrent location $currentLocation");
      addMarker(
          id: "source",
          latLng: LatLng(currentLocation!.latitude, currentLocation!.longitude),
          icon: sourceIcon);
    });
  }

  void onMapCreated(GoogleMapController controller) {
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target:
            LatLng(currentLocation!.latitude, currentLocation!.longitude))));
  }

  addMarker(
      {required String id, required LatLng latLng, BitmapDescriptor? icon}) {
    markers.add(Marker(
        markerId: MarkerId(id),
        position: latLng,
        icon: icon ?? currentLocationIcon));

    setState(() {});
  }

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
  setCustomIcons() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "Assets/Images/source.png")
        .then((value) {
      sourceIcon = value;
    });
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "Assets/Images/destination.png")
        .then((value) {
      destinationIcon = value;
    });
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "Assets/Images/current.png")
        .then((value) {
      currentLocationIcon = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Maps"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: initialCameraPosition,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            markers: markers,
            onTap: (argument) {
              destination = argument;
              debugPrint("\nnew $argument");
              addMarker(
                  id: "destination", latLng: argument, icon: destinationIcon);
            },
          ),
        ],
      ),
    );
  }
}
