import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

_fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode? nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}

Widget textFieldWidget({
  BuildContext? context,
  Widget? prefixIcon,
  Widget? suffixIcon,
  bool showCursor = true,
  bool readOnly = false,
  bool onlyHint = false,
  required String hint,
  List<String?>? holder,
  TextEditingController? controller,
  FocusNode? currentFocus,
  FocusNode? nextFocus,
  Color? borderColor,
  bool isEmail = false,
  bool enabled = true,
  bool validation = true,
  TextAlign? textAlign,
  double borderRadius = 10,
  double? fontsize,
  Color? textColor,
  int maxLines = 1,
  void Function(String)? onChanged,
  int minLines = 1,
  TextInputAction? textInputAction,
  TextCapitalization textCapitalization = TextCapitalization.none,
  // Function? onTap,
}) {
  return Container(
    alignment: Alignment.center,
    // width: SizeConfig.blockSizeHorizontal! * 80,
    // height: SizeConfig.blockSizeVertical ! * 6,
    child: TextFormField(
      // onTap: onTap!(),
      maxLines: maxLines,
      textCapitalization: textCapitalization,
      minLines: minLines,
      textAlign: textAlign ?? TextAlign.start,
      readOnly: readOnly,
      showCursor: showCursor,
      controller: controller,
      enabled: enabled,
      textInputAction: textInputAction != null
          ? textInputAction
          : nextFocus == null
              ? TextInputAction.done
              : TextInputAction.next,
      // style: textFieldTextStyle(color: textColor ?? primary),

      textAlignVertical: TextAlignVertical.center,
      validator: (String? value) {
        // if (validation == true) {
        //   if (value!.isEmpty) {
        //     return 'Enter $hint';
        //   } else if (isEmail && !Constants().regex.hasMatch(value)) {
        //     return 'Enter valid $hint';
        //   } else {
        //     return null;
        //   }
        // } else {
        //   return null;
        // }
      },
      onSaved: (value) {
        holder![0] = value;
      },
      focusNode: currentFocus,
      onFieldSubmitted: (v) {
        _fieldFocusChange(context!, currentFocus!, nextFocus);
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        // fillColor: white,
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        isDense: true,
        hintText: onlyHint ? hint : 'Enter ' + hint,
        // hintStyle: textFieldTextStyle(
        //   color: textColor ?? primaryLight,
        // ),
        prefixIcon: prefixIcon ?? null,
        suffix: suffixIcon ?? null,
        border: outlineBorder(borderColor, borderRadius),
        enabledBorder: outlineBorder(borderColor, borderRadius),
        focusedBorder: outlineBorder(borderColor, borderRadius),
        errorBorder: outlineBorder(borderColor, borderRadius),
        disabledBorder: outlineBorder(borderColor, borderRadius),
        focusedErrorBorder: outlineBorder(borderColor, borderRadius),
      ),
    ),
  );
}

outlineBorder(Color? borderColor, double? borderRadius) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 10)),
    borderSide: BorderSide(color: borderColor ?? Colors.grey),
  );
}

Widget NumbertextFieldWidget(
    {BuildContext? context,
    Widget? prefixIcon,
    required String hint,
    List<String?>? holder,
    TextEditingController? controller,
    FocusNode? currentFocus,
    FocusNode? nextFocus,
    void Function(String)? onChanged,
    bool isPhoneNumber = false,
    int validationLength = 10,
    bool enabled = true,
    List<TextInputFormatter>? inputFormatters,
    Color? borderColor,
    TextAlign? textAlign,
    bool validation = true,
    double? borderRadius,
    Color? textColor}) {
  return Container(
    alignment: Alignment.center,
    // color: Colors.red,
    // width: SizeConfig.blockSizeHorizontal! * 80,
    // height: SizeConfig.blockSizeVertical ! * 6,
    child: TextFormField(
      enabled: enabled,
      textAlign: textAlign ?? TextAlign.start,
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: inputFormatters,
      maxLength: 10,
      textInputAction:
          nextFocus == null ? TextInputAction.done : TextInputAction.next,
      // style: textFieldTextStyle(color: textColor ?? primary),
      textAlignVertical: TextAlignVertical.center,
      validator: (String? value) {
        if (validation == true) {
          if (value!.isEmpty) {
            return 'Enter $hint';
          } else if (isPhoneNumber == true &&
              value.length != validationLength) {
            return 'Invalid Number';
          } else {
            return null;
          }
        } else {
          return null;
        }
      },
      onChanged: onChanged,
      onSaved: (value) {
        holder![0] = value;
      },
      focusNode: currentFocus,
      onFieldSubmitted: (v) {
        _fieldFocusChange(context!, currentFocus!, nextFocus);
      },
      decoration: InputDecoration(
        // fillColor: white,
        filled: true,
        isDense: true,
        counterText: "",
        hintText: 'Enter ' + hint,
        // hintStyle: textFieldTextStyle(color: textColor ?? primaryLight),
        prefixIcon: prefixIcon ?? null,
        border: outlineBorder(borderColor, borderRadius),
        enabledBorder: outlineBorder(borderColor, borderRadius),
        focusedBorder: outlineBorder(borderColor, borderRadius),
        errorBorder: outlineBorder(borderColor, borderRadius),
        disabledBorder: outlineBorder(borderColor, borderRadius),
        focusedErrorBorder: outlineBorder(borderColor, borderRadius),
      ),
    ),
  );
}
