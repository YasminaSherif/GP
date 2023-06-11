import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fortestpages/bloc/userData/cubit.dart';
import 'package:fortestpages/services/methods/navigation.dart';

import '../../../models/message.dart';
import '../../../models/persons.dart';
import '../messages_screen_user.dart';


class ChatItemUnread extends StatelessWidget {
 List<Message>? messages;
  person receiver;
  String senderId;
  String senderName;
  String msg;
  ChatItemUnread({Key? key, required this.receiver, required this.senderId,required this.senderName,required this.msg,required this.messages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<userDataCubit, userDataStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return InkWell(
          onTap: () {
            navigateWithBack(context, MessagesScreen(
            messages: messages,
             receiverId: receiver.id,
             receiverName: receiver.name,
             senderId: senderId,
             senderName: senderName,
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
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
                    children: [
                      Text(receiver.name, style: TextStyle(fontSize: 13.sp,fontFamily: 'Tajawal',fontWeight: FontWeight.bold),),
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
                  radius: 25.0,
                  backgroundImage:receiver.image != null
        ? MemoryImage(base64Decode(receiver.image!))
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