// ignore_for_file: must_be_immutable, camel_case_types
import 'package:auto_size_text/auto_size_text.dart';
import 'package:example_riverpod/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class customText extends StatelessWidget {
  customText({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textDecoration,
    this.textAlign,
    this.overflow,
  });
  String text;
  double? fontSize;
  FontWeight? fontWeight;
  Color? color;
  TextDecoration? textDecoration;
  TextAlign? textAlign;
  TextOverflow? overflow;
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: GoogleFonts.robotoFlex(
        color: color ?? CustomColors.tColor,
        fontSize: fontSize ?? 16.sp,
        fontWeight: fontWeight ?? FontWeight.w600,
        decoration: textDecoration,
        decorationColor: color ?? CustomColors.tColor,
      ),
      textAlign: textAlign,
      overflow: overflow,
    );
  }
}

TextStyle customTextStyle({
  double? fontSize,
  FontWeight? fontWeight,
  Color? color,
  TextDecoration? textDecoration,
}) {
  return GoogleFonts.robotoFlex(
    color: color ?? CustomColors.tColor,
    fontSize: fontSize ?? 16.sp,
    fontWeight: fontWeight ?? FontWeight.w600,
    decoration: textDecoration,
  );
}
