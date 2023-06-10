import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fortestpages/bloc/userData/cubit.dart';
import 'package:fortestpages/services/methods/navigation.dart';

import '../../../models/persons.dart';
import '../messages_screen_user.dart';


class ChatItem extends StatelessWidget {
  workerData worker;

  ChatItem({Key? key, required this.worker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<userDataCubit, userDataStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = userDataCubit.get(context);
        return InkWell(
          onTap: () {
            navigateWithBack(context, MessagesScreen(
                receiverId: worker.id,
                receiverName: worker.name,
                user: cubit.userResponse![0],
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.r),
            child: Row(
              children: [
                 Expanded(
                   child: Column(
                    children: [
                      Text(worker.name,  style: TextStyle(fontSize: 10.sp,fontFamily: 'Tajawal'),),
                       Text('رجاء متي موعد تنفيذ الطلب  تحديداتحديداتحديداتحديداتحديدا',
                       style: TextStyle(fontSize: 10.sp,fontFamily: 'Tajawal'),
                         textDirection: TextDirection.rtl,
                         maxLines: 1,
                         overflow: TextOverflow.ellipsis,
                      ),
                    ],
                                 ),
                 ),

                 SizedBox(
                  width: 10.h,
                ),

               
                CircleAvatar(
                  radius: 25.0.r,
                  backgroundImage:worker.image != null
        ? MemoryImage(base64Decode(worker.image!))
        : null,
    backgroundColor: Colors.grey,
                ),

               
               
                
                 
              ],
            ),
          ),
        );
      },
    );
  }
}
