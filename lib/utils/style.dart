// ignore_for_file: camel_case_types

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_letter/utils/color.dart';

abstract class ThemeText {
  static TextStyle textBoldStyle = TextStyle(
    fontWeight: FontWeight.w600,
    color: ColorTheme.greyColor,
  );

  static TextStyle textHintStyle = TextStyle(
    color: ColorTheme.greyColor,
  );

  static TextStyle textBold17Black = TextStyle(
      fontSize: 17.sp, fontWeight: FontWeight.bold, color: Colors.black);

  static TextStyle textBold18Black = TextStyle(
      fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.black);

  static TextStyle textBold18White = TextStyle(
      fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.black);
  static TextStyle textBoldBlack = TextStyle(
      fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.black);

  static TextStyle textnormalBlack = const TextStyle(color: Colors.black);

  static TextStyle datestyle = const TextStyle(color: Colors.blue);
}
