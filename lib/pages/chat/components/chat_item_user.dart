import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fortestpages/bloc/userData/cubit.dart';
import 'package:fortestpages/services/methods/navigation.dart';

import '../../../bloc/chat/chat_cubit.dart';
import '../../../models/message.dart';
import '../../../models/persons.dart';
import '../messages_screen_user.dart';


class ChatItem extends StatelessWidget {
  List<Message>? messages;
  person receiver;
  String senderId;
  String senderName;
  String msg;
  ChatItem({Key? key, required this.receiver, required this.senderId,required this.senderName,required this.msg,required this.messages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<userDataCubit, userDataStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
       
        return InkWell(
          onTap: () {
            navigateWithBack(context, MessagesScreen
            (messages: messages,
             receiverId: receiver.id,
             receiverName: receiver.name,
             senderId: senderId,
             senderName: senderName),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.r),
            child: Row(
              children: [
                 Expanded(
                   child: Column(
                    children: [
                      Text(receiver.name,  style: TextStyle(fontSize: 10.sp,fontFamily: 'Tajawal'),),
                       Text(msg,
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
