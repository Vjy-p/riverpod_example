import 'package:example_riverpod/main.dart';
import 'package:example_riverpod/utils/colors.dart';
import 'package:example_riverpod/utils/custom_text.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar(
    {required String text,
    Color? bgColor,
    Color? textColor,
    List<Widget>? actionWidget,
    bool leading = false}) {
  return AppBar(
    backgroundColor: bgColor,
    automaticallyImplyLeading: leading,
    centerTitle: true,
    title: customText(
      text: text,
      color: textColor,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    ),
    leading: leading
        ? IconButton(
            onPressed: () {
              Navigator.pop(navigatorKey.currentContext!);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: CustomColors.black.withOpacity(0.5),
              size: 20,
            ),
          )
        : null,
    actions: actionWidget,
  );
}
