import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fortestpages/bloc/userData/cubit.dart';
import 'package:fortestpages/services/methods/navigation.dart';

import '../../../bloc/chat/chat_cubit.dart';
import '../../../models/message.dart';
import '../../../models/persons.dart';
import '../messages_screen.dart';

class ChatItemUnread extends StatelessWidget {
  final List<Message>? messages;
  final person receiver;
  final String senderId;
  final String senderName;
  final String msg;
  final ChatCubit chatCubit;

  const ChatItemUnread({
    Key? key,
    required this.receiver,
    required this.senderId,
    required this.senderName,
    required this.msg,
    required this.messages,
    required this.chatCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<userDataCubit, userDataStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return InkWell(
          onTap: () {
            navigateWithBack(
              context,
              MessagesScreen(
                messages: messages!,
                receiverId: receiver.id,
                receiverName: receiver.name,
                senderId: senderId,
                senderName: senderName,
                chatCubit: chatCubit,
              ),
            );
          },
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 40.r),
                    child: const CircleAvatar(
                      radius: 4,
                      backgroundColor: Colors.redAccent,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          receiver.name,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: 'Tajawal',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          msg,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontFamily: 'Tajawal',
                          ),
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
                    backgroundImage: receiver.image != null
                        ? MemoryImage(base64Decode(receiver.image!))
                        : null,
                    backgroundColor: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}