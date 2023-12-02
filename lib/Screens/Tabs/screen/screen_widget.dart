import 'dart:math';

import 'package:example_riverpod/Controllers/screen_controller.dart';
import 'package:example_riverpod/utils/colors.dart';
import 'package:example_riverpod/utils/custom_loading.dart';
import 'package:example_riverpod/utils/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget listTile() {
  return Consumer(builder: (context, ref, child) {
    var provider = ref.watch(screenProvider);
    return SizedBox(
      height: 130.h,
      width: ScreenUtil().screenWidth * 1,
      child: provider.isLoading
          ? CustomLoading().circularLoading()
          : GridView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: (ScreenUtil().screenWidth * 1 - 30.w) / 9,
              ),
              itemCount: 27,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    // if (provider.openNumbers
                    //     .contains(provider.fullList[index])) {
                    //   provider.markNumber(number: provider.fullList[index]);
                    // } else {
                    //   debugPrint("\n nothing");
                    // }
                    if (provider.fullList[index] != -1) {
                      provider.markNumber(number: provider.fullList[index]);
                    } else {
                      debugPrint("\n nothing");
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: provider.userMarkedList
                                .contains(provider.fullList[index])
                            ? CustomColors.bgColor2
                            : CustomColors.bgColor,
                        border: Border.all(color: CustomColors.black)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    alignment: Alignment.center,
                    child: provider.fullList[index] == -1
                        ? const SizedBox()
                        : customText(
                            text: "${provider.fullList[index]}",
                            color: provider.userMarkedList
                                    .contains(provider.fullList[index])
                                ? CustomColors.white
                                : CustomColors.tColor,
                          ),
                  ),
                );
              },
            ),
    );
  });
}
