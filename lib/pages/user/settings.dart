//import 'package:crafts/modules/user_profile/cubit/states.dart';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fortestpages/pages/user/previous_requests.dart';
import 'package:fortestpages/pages/user/user_requests.dart';
import 'package:fortestpages/services/methods/navigation.dart';
//import '../../models/userModel.dart';
//import '../bloc/userProfile/cubit.dart';

import '../../bloc/userData/cubit.dart';
import '../auth/SignIn.dart';
import 'editUser.dart';
//import '../models/loginDataResponse.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<userDataCubit, userDataStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = userDataCubit.get(context);
        return Scaffold( 
          body: Container(
          color: Colors.grey[250],
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.0).r,
                      color: const Color.fromRGBO(217, 173, 48, 1),
                    ),
                    height: 117.0.h,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0).w,
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.arrow_back_sharp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (cubit.userResponse == null)
                    const Center(child: CircularProgressIndicator(color: Color(0xffD9AD30),))
                  else
                    Positioned(
                      left: 95.0.r,
                      right: 95.0.r,
                      top: 85.0.r,
                      child: Column(
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 35.0.r,
                                child: CircleAvatar(
                                  backgroundImage:
                                      cubit.userResponse![0].image != null
                                          ? MemoryImage(base64Decode(
                                              cubit.userResponse![0].image!))
                                          : null,
                                  radius: 35.0.r,
                                  backgroundColor: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            cubit.userResponse![0].username!,
                            style: TextStyle(
                              fontSize: 14.0.sp,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Tajawal',
                            ),
                          ),
                          Text(
                            cubit.userResponse![0].email!,
                            style: TextStyle(
                              color: Colors.grey,
                              height: 1.0.h,
                              fontSize: 12.0.sp,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Tajawal',
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 90.r),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0).w,
                      child: MaterialButton(
                        onPressed: () {
                          navigateWithBack(context, ImagePicker());
                        },
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.navigate_before_outlined,
                              size: 30,
                              color: Colors.grey,
                            ),
                            const Spacer(),
                            Text(
                              'معلومات شخصية',
                              style: TextStyle(
                                fontSize: 13.0.sp,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            const Icon(
                              Icons.person_3_outlined,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0.r),
                      child: MaterialButton(
                        onPressed: () {
                          cubit.GetRequests();
                          navigateWithBack(context, const UserRequests());
                        },
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.navigate_before_outlined,
                              size: 30,
                              color: Colors.grey,
                            ),
                            const Spacer(),
                            Text(
                              'الطلبات الجاريه',
                              style: TextStyle(
                                fontSize: 13.0.sp,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            const Icon(
                              Icons.account_box_outlined,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                     Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0).w,
                      child: MaterialButton(
                        onPressed: () {
                          cubit.GetRequests();
                          navigateWithBack(context, const PreviousRequests());
                        },
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.navigate_before_outlined,
                              size: 30,
                              color: Colors.grey,
                            ),
                            const Spacer(),
                            Text(
                              'الطلبات السابقه',
                              style: TextStyle(
                                fontSize: 13.0.sp,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            const Icon(
                              Icons.account_box_outlined,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0.r),
                      child: MaterialButton(
                        onPressed: () {
                          cubit.logout();
                          navigateAndNotBack(context, SignIn());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'تسجيل خروج',
                              style: TextStyle(
                                fontSize: 13.0.sp,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            const Icon(
                              Icons.login_outlined,
                              size: 18,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          ),
        );
      },
    );
  }
}
