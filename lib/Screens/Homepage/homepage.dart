import 'package:example_riverpod/Screens/Tabs/home_screen.dart';
import 'package:example_riverpod/Controllers/location/location_provider.dart';
import 'package:example_riverpod/Screens/Tabs/screen/screen2.dart';
import 'package:example_riverpod/utils/colors.dart';
import 'package:example_riverpod/utils/customButton.dart';
import 'package:example_riverpod/utils/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    Screen2(),
    Container(),
    Container(),
  ];

  @override
  void initState() {
    super.initState();
    // checkLocation();
  }

  // checkLocation() {
  //   ref.read(checkLocationProvider).checkLocationPermissions();
  //   Future.delayed(const Duration(seconds: 2), () {
  //     if (ref.watch(checkLocationProvider).hasLocationPermission &&
  //         ref.watch(checkLocationProvider).locationStatus) {
  //     } else {
  //       openAlertBox();
  //     }
  //   });
  // }

  openAlertBox() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: customText(text: "Enable service location"),
          actions: [
            customIconButton(
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: CustomColors.primary,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: CustomColors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8),
              child: GNav(
                // rippleColor: Color.fromARGB(255, 0, 0, 33)!,
                // hoverColor: Color.fromARGB(255, 0, 0, 33)!,
                gap: 8,
                activeColor: CustomColors.primary,
                iconSize: 24.r,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: CustomColors.secondary,
                tabs: const [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.favorite,
                    text: 'Likes',
                  ),
                  GButton(
                    icon: Icons.search,
                    text: 'Search',
                  ),
                  GButton(
                    icon: Icons.account_circle,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
