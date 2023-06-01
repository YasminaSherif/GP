import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyle {
  static TextStyle headLine() => TextStyle(
        fontSize: 20.0.sp,
        fontWeight: FontWeight.w700,
        color: Colors.black,
        fontFamily: "jannah",
      );

  static TextStyle appBarText() => TextStyle(
        color: Colors.black,
        fontSize: 20.0.sp,
        fontWeight: FontWeight.bold,
        fontFamily: "jannah",
      );
  static TextStyle title() => TextStyle(
        fontSize: 16.0.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black,
        fontFamily: "jannah",
        height: 1.2.h,
      );
  static TextStyle bodyText() => TextStyle(
        fontSize: 14.0.sp,
        fontWeight: FontWeight.normal,
        color: Colors.black,
        fontFamily: "jannah",
      );
  static TextStyle subTitle() => TextStyle(
        fontSize: 12.0.sp,
        color: Colors.grey,
        height: 1.1.h,
        fontFamily: "jannah",
      );
  static TextStyle caption() => TextStyle(
        fontSize: 12.0.sp,
        color: Colors.grey.shade600,
        height: 1.1.h,
        fontFamily: "jannah",
      );
  static TextStyle date() => TextStyle(
        fontSize: 11.0.sp,
        color: Colors.grey.shade500,
        height: 1.1.h,
        fontWeight: FontWeight.w100,
        fontFamily: "jannah",
      );
}
