import 'package:example_riverpod/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:example_riverpod/Screens/Auth/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey(debugLabel: "Main Navigator");

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      ensureScreenSize: true,
      builder: (context, child) {
        return ProviderScope(
          child: MaterialApp(
              title: Constants.appName,
              navigatorKey: navigatorKey,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                    seedColor: Color.fromARGB(255, 27, 26, 57)),
                useMaterial3: true,
              ),
              debugShowCheckedModeBanner: false,
              home: child),
        );
      },
      child: const SplashScreen(),
    );
  }
}
