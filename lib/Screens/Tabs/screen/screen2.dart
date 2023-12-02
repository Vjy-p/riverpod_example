import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:example_riverpod/Controllers/screen_controller.dart';
import 'package:example_riverpod/Screens/Tabs/screen/screen_widget.dart';
import 'package:example_riverpod/utils/colors.dart';
import 'package:example_riverpod/utils/customButton.dart';
import 'package:example_riverpod/utils/custom_loading.dart';
import 'package:example_riverpod/utils/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Screen2 extends ConsumerStatefulWidget {
  const Screen2({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _Screen2State();
}

class _Screen2State extends ConsumerState<Screen2> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(screenProvider.notifier).setData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
            child: Column(
              children: [
                topRow(),
                recentNumberWidget(),
                numbersWidget(),
                buttonsWidget(),
                listTile(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget topRow() {
    return Column(
      children: [scoreWidget(), buildTimer()],
    );
  }

  Widget recentNumberWidget() {
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customText(text: "Recent Numbers"),
          Container(
            height: 40.h,
            width: ScreenUtil().screenWidth * 1,
            padding: EdgeInsets.only(top: 5.h, bottom: 0.h),
            child: Consumer(
              builder: (context, ref, child) {
                List<int> recentlist =
                    ref.watch(screenProvider).recentNumbersList;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: recentlist.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 4.h),
                      child: CircleAvatar(
                        child: customText(
                          text: "${recentlist[index]}",
                          fontSize: 8.sp,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget scoreWidget() {
    return Consumer(
      builder: (context, ref, child) {
        var score = ref.watch(screenProvider).totalPoints;
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 15.h),
          child: customText(
            text: "Score : $score",
            fontSize: 18.sp,
          ),
        );
      },
    );
  }

  Widget numbersWidget() {
    return Consumer(builder: (context, ref, child) {
      var provider = ref.watch(screenProvider).openNumbersList;
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: SizedBox(
          height: 160.h,
          width: ScreenUtil().screenWidth * 1,
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
            ),
            itemCount: 90,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(2.w),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: provider.contains(index + 1) == true
                        ? CustomColors.green
                        : CustomColors.bgColor,
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(1.w),
                  child: customText(
                    text: "${index + 1}",
                    fontSize: 8.sp,
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }

  Widget buttonsWidget() {
    return Consumer(
      builder: (context, ref, child) {
        var provider = ref.read(screenProvider.notifier);
        return Padding(
          padding: EdgeInsets.only(bottom: 15.h),
          child: Wrap(
            spacing: 5.w,
            runSpacing: 5.w,
            children: [
              customButton(
                  width: 100.w,
                  height: 40.h,
                  text: "Quick 5",
                  onTap: () {
                    provider.quickFiveValidate();
                  }),
              customButton(
                  width: 100.w,
                  height: 40.h,
                  text: "Top Row",
                  onTap: () {
                    provider.rowValidate(row: 0);
                  }),
              customButton(
                  width: 100.w,
                  height: 40.h,
                  text: "Middle Row",
                  onTap: () {
                    provider.rowValidate(row: 1);
                  }),
              customButton(
                  width: 100.w,
                  height: 40.h,
                  text: "Bottom Row",
                  onTap: () {
                    provider.rowValidate(row: 2);
                  }),
              customButton(
                  width: 100.w,
                  height: 40.h,
                  text: "Full House",
                  onTap: () {
                    provider.fullHouseValidate();
                  }),
            ],
          ),
        );
      },
    );
  }

  Widget buildTimer() {
    return Consumer(builder: (context, ref, child) {
      var provider = ref.watch(screenProvider);
      return Stack(
        alignment: Alignment.center,
        children: [
          CircularCountDownTimer(
            duration: 5,
            width: 50.w,
            height: 50.w,
            controller: provider.countDownController,
            isReverseAnimation: true,
            autoStart: false,
            fillColor: const Color(0XFFEFE690),
            ringColor: const Color(0XFFF55700),
            backgroundColor: const Color(0XFFEFE690),
            textStyle: const TextStyle(color: Color(0XFFF55700)),
            isTimerTextShown: false,
            onStart: () {
              if (provider.openNumbersList.length >= 1 &&
                  provider.openNumbersList.length <= 90 &&
                  provider.start) {
                ref.read(screenProvider).openNumber();
              }
            },
            onComplete: () {
              ref.read(screenProvider).check();
            },
          ),
          InkWell(
            onTap: () {
              if (provider.openedNumber == 0) {
                ref.read(screenProvider.notifier).startGame();
              }
            },
            child: Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: CustomColors.blue,
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              alignment: Alignment.center,
              padding: EdgeInsets.all(8.w),
              child: provider.openedNumber == 0
                  ? customText(
                      text: "start",
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w800,
                      color: CustomColors.white,
                    )
                  : customText(
                      text: "${provider.openedNumber}",
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w800,
                      color: CustomColors.white,
                    ),
            ),
          ),
        ],
      );
    });
  }
}
