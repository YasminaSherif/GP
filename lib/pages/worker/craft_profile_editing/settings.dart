//import 'package:crafts/modules/user_profile/cubit/states.dart';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fortestpages/pages/user/user_requests.dart';
import 'package:fortestpages/services/methods/navigation.dart';
//import '../../models/userModel.dart';
//import '../bloc/userProfile/cubit.dart';

import '../../../../bloc/workerData/cubit.dart';
import '../../auth/SignIn.dart';
import '../../../bloc/editUser/cubit.dart';
import 'craft_personal_info.dart';
import 'craft_profile_editing.dart';
//import '../models/loginDataResponse.dart';

class CraftSetting extends StatelessWidget {
  const CraftSetting({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<workerDataCubit, workerDataStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = workerDataCubit.get(context);
        return
         Scaffold(
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
                            padding: EdgeInsets.all(5.0.r),
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
                    if (cubit.workerResponse == null)
                      const Center(child: CircularProgressIndicator())
                    else
                      Positioned(
                        left: 130.0.r,
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
                                        cubit.workerResponse![0].image != null
                                            ? MemoryImage(base64Decode(
                                                cubit.workerResponse![0].image!))
                                            : null,
                                    radius: 35.0.r,
                                    backgroundColor: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              cubit.workerResponse![0].username!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                            Text(
                              cubit.workerResponse![0].email!,
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
                        padding: EdgeInsets.symmetric(horizontal: 10.0.r),
                        child: MaterialButton(
                          onPressed: () {
                            cubit.GetRequests();
                            navigateWithBack(context, ImagePicker());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.navigate_before_outlined,
                                size: 30,
                                color: Colors.grey,
                              ),
                              const Spacer(),
                              Text(
                                'معلومات شخصيه',
                                style: TextStyle(
                                  fontSize: 13.0.sp,
                                  fontWeight: FontWeight.w900,
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
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                                  fontWeight: FontWeight.w900,
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
