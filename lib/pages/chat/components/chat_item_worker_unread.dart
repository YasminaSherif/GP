import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fortestpages/bloc/userData/cubit.dart';
import 'package:fortestpages/services/methods/navigation.dart';
import '../../../bloc/workerData/cubit.dart';
import '../../../models/persons.dart';
import '../messages_screen_worker.dart';


class ChatItem extends StatelessWidget {
  userData user;

  ChatItem({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<workerDataCubit, workerDataStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = workerDataCubit.get(context);
        return InkWell(
          onTap: () {
            navigateWithBack(context, MessagesScreen(
                receiverId: user.id,
                receiverName: user.name,
                worker: cubit.workerResponse![0],
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(10.0.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

               Padding(
                    padding: EdgeInsets.only(bottom: 40.r),
                    child: const CircleAvatar(
                      radius: 7,
                      backgroundColor: Colors.redAccent,
                    ),
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(user.name, style: TextStyle(fontSize: 13.sp,fontFamily: 'Tajawal',fontWeight: FontWeight.bold),),
                     
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
                  backgroundImage:user.image != null
        ? MemoryImage(base64Decode(user.image!))
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