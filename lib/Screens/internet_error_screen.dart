import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:example_riverpod/Screens/Homepage/homepage.dart';
import 'package:example_riverpod/utils/customButton.dart';
import 'package:example_riverpod/utils/customToast.dart';
import 'package:example_riverpod/utils/custom_text.dart';
import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InternetErrorScreen extends StatefulWidget {
  const InternetErrorScreen({super.key});

  @override
  _InternetErrorScreen createState() => _InternetErrorScreen();
}

class _InternetErrorScreen extends State<InternetErrorScreen> {
  bool internetON = false;

  @override
  initState() {
    internetCheck();
    super.initState();
  }

  internetCheck() async {
    var result = await Connectivity().checkConnectivity();

    if (result != ConnectivityResult.mobile &&
        result != ConnectivityResult.wifi) {
      internetON = false;
      customToast(
          context: context, text: "Turn on wifi or mobile data to proceed");
      debugPrint("\ninternet $result");
    } else {
      internetON = true;
      debugPrint("\ninternet $result");

      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Homepage()));
      }
    }
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => internetON,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: customText(text: "No Internet Connection", fontSize: 18.sp),
            leading: backButton(),
          ),
          body: Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 40.h),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  imageWidget(),
                  textWidget(),
                  customButton(
                      text: "Try Again",
                      onTap: () {
                        internetCheck();
                      }),
                ]),
          )),
    );
  }

  Widget imageWidget() {
    return Image.asset(
      "Assets/Images/internet_check.png",
      height: ScreenUtil().screenHeight * 0.3,
      fit: BoxFit.contain,
    );
  }

  Widget textWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: Column(
        children: [
          customText(
            text: "Oops, No Internet Connection",
            fontSize: 21.sp,
            textAlign: TextAlign.center,
          ),
          customText(
            text:
                "Make sure wifi or cellular data is turned on and then try again.",
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget backButton() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 5.w),
        child: IconButton(
            onPressed: () {
              internetCheck();
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
    );
  }
}
