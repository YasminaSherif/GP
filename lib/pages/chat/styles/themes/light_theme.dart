import 'package:flutter/material.dart';

import '../colors/app_colors.dart';
import '../texts/app_text_styles.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.lightBackGroundColor,
  backgroundColor: AppColors.primaryColor,
  primarySwatch: AppColors.primarySwatchColor,
  iconTheme: const IconThemeData(
    color: Colors.grey,
  ),
  appBarTheme: AppBarTheme(
    centerTitle: true,
    titleTextStyle: AppTextStyle.appBarText(),
    elevation: 0,
    color: AppColors.lightBackGroundColor,
    iconTheme: const IconThemeData(
      color: Colors.grey,
    ),
    // systemOverlayStyle:  SystemUiOverlayStyle(
    //   //statusBarColor: AppColors.lightBackGroundColor,
    //   statusBarIconBrightness: Brightness.dark,
    // ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: AppColors.primaryColor,
    elevation: 20.0,
    unselectedItemColor: Colors.grey,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    //backgroundColor: AppColors.whitBackGroundColor,
  ),
  drawerTheme: DrawerThemeData(backgroundColor: AppColors.lightBackGroundColor),
  dividerTheme: DividerThemeData(
    thickness: 1.1,
    color: Colors.grey.shade300,
  ),
  fontFamily: "jannah",
);
