import 'package:example_riverpod/utils/colors.dart';
import 'package:example_riverpod/utils/customButton.dart';
import 'package:example_riverpod/utils/custom_loading.dart';
import 'package:example_riverpod/utils/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget verticalTile(
    {required String img,
    required String title,
    required String price,
    required Function() onTap}) {
  return Card(
    margin: EdgeInsets.all(5.w),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
    child: Column(
      children: [
        Expanded(
          flex: 1,
          child: img.isEmpty
              ? Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.image,
                    size: 80.r,
                    color: CustomColors.bgColor2,
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(5.r),
                  child: CachedNetworkImage(
                    imageUrl: img,
                    width: ScreenUtil().screenWidth * 1,
                    fit: BoxFit.fill,
                    placeholder: (context, url) {
                      return CustomLoading().circularLoading();
                    },
                    errorWidget: (context, url, error) {
                      return Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.image,
                          size: 80.r,
                          color: CustomColors.bgColor2,
                        ),
                      );
                    },
                  ),
                ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(5.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText(
                  text: title,
                  fontSize: 14.sp,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.h),
                  child: customText(
                    text: price,
                    fontSize: 12.sp,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton(
                    style: ButtonStyle(
                        minimumSize: MaterialStatePropertyAll(Size(50.w, 20.h)),
                        maximumSize:
                            MaterialStatePropertyAll(Size(100.w, 30.h)),
                        backgroundColor:
                            MaterialStatePropertyAll(CustomColors.buttonColor),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.r),
                            side: BorderSide(color: CustomColors.buttonColor))),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                    onPressed: onTap,
                    child: customText(
                      text: "Add",
                      fontSize: 13.sp,
                      color: CustomColors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
