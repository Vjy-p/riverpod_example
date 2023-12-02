import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:example_riverpod/Screens/Homepage/homepage.dart';
import 'package:example_riverpod/Screens/internet_error_screen.dart';
import 'package:example_riverpod/Controllers/location/location_provider.dart';
import 'package:example_riverpod/Controllers/location/get_location.dart';
import 'package:example_riverpod/utils/customButton.dart';
import 'package:example_riverpod/utils/custom_loading.dart';
import 'package:example_riverpod/utils/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool isLodaing = false;

  @override
  void initState() {
    super.initState();
    checkNet();
  }

  checkNet() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result != ConnectivityResult.wifi &&
          result != ConnectivityResult.mobile) {
        debugPrint("\ninternet on $result");
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => InternetErrorScreen()));
      } else {
        // checkLocation();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Homepage()));
      }
    });
  }

  // checkLocation() {
  //   setState(() {
  //     isLodaing = true;
  //   });
  //   ref.read(checkLocationProvider).checkLocationPermissions();
  //   var permissions = ref.watch(checkLocationProvider.notifier);

  //   debugPrint(
  //       "\n11111 ${permissions.hasLocationPermission} ${permissions.locationStatus}");
  //   if (ref.watch(checkLocationProvider).hasLocationPermission &&
  //       ref.watch(checkLocationProvider).locationStatus) {
  //     setState(() {
  //       isLodaing = false;
  //     });
  //     ref.read(locationProvider).location();
  //     var val = ref.watch(locationProvider);
  //     debugPrint("\nlatlong $val");
  //     Navigator.of(context)
  //         .push(MaterialPageRoute(builder: (context) => const Homepage()));
  //   } else {
  //     setState(() {
  //       isLodaing = false;
  //     });
  //     openAlertBox();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          width: 40,
          height: 40,
          child: CircularProgressIndicator.adaptive(),
        ),
      ),
    );
  }

  openAlertBox() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: customText(
              text:
                  "Go to settings and enable service location,to proceed forward"),
          actions: [
            isLodaing
                ? CustomLoading().circularLoading()
                : customIconButton(
                    text: "Retry",
                    icon: const Icon(Icons.location_on),
                    onTap: () {
                      // checkLocation();
                    })
          ],
        );
      },
    );
  }
}
