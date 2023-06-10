import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'package:fortestpages/services/methods/navigation.dart';

import '../../bloc/userData/cubit.dart';
import '../../models/persons.dart';
import 'craft_profile/craft_profile.dart';


class workerOfCate extends StatelessWidget {
  workerOfCate({Key? key, required this.worker}) : super(key: key);
  workerData worker;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocConsumer<userDataCubit, userDataStates>(
      listener: (context, state) {
        // if (state is getWorkerSuccessState){
        //   navigateWithBack(context, CraftProfile());
        // }
        
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit=userDataCubit.get(context);
        return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10.r),
    child: Container(
      height: 72.0.h,
      color: Colors.white,
      child: Row(
        children:  [
           SizedBox(
            width: 15.0.w,
          ),
          IconButton(
            
            icon:const Icon(
              Icons.navigate_before_outlined,
              size: 30,
              color: Colors.grey,

            ),
            onPressed: () {
              cubit.getWorkerData(worker.id);
              navigateWithBack(context, CraftProfile());
            },
          ),
          
           SizedBox(
            width: 40.0.w,
          ),
          Expanded(
            child: Container(
              
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0).r,
              ),

              child: Padding(
                padding: EdgeInsets.only(top: 10.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                     Text(worker.firstName +" "+worker.lastName,
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 15.0.sp,
                          height: 1.0.h,
                          fontFamily: 'Tajawal',
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:  [
                        const Icon(Icons.star_rate,
                          color: Colors.amber,
                          size:16.0 ,
                        ),
                        
                        Text(worker.rating.toString(),
                          style: TextStyle(
                            fontSize: 12.0.sp,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                      ],
                    ),

                     Text(worker.cate!.name!,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11.0.sp,
                          fontWeight: FontWeight.w700,
                          height: 1.5.h,
                          fontFamily: 'Tajawal',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
           Padding(
            padding: EdgeInsets.only(right: 15.r),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 28.0.r,
              child: CircleAvatar(
                backgroundImage: worker.image != null
        ? MemoryImage(base64Decode(worker.image!))
        : null,
    radius: 35.0.r,
    backgroundColor: Colors.grey,

              ),
            ),
          ),
        ],
      ),
    ),
  );
  },
    );
  }
}