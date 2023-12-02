import 'package:example_riverpod/utils/colors.dart';
import 'package:example_riverpod/utils/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

customToast({required context, required String text, double? margin}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: margin ?? 10.h),
      padding: EdgeInsets.all(10.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
      duration: const Duration(seconds: 2),
      content: customText(text: text, textAlign: TextAlign.center),
      backgroundColor: CustomColors.buttonColor,
      behavior: SnackBarBehavior.floating,
    ),
  );
}
