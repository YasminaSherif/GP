import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fortestpages/bloc/userData/cubit.dart';
import 'package:fortestpages/services/methods/navigation.dart';
import '../../../models/loginDataResponse.dart';
import '../messages_screen_user.dart';
import '../styles/texts/app_text_styles.dart';

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
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage:worker.image != null
        ? MemoryImage(base64Decode(worker.image!))
        : null,
    backgroundColor: Colors.grey,
                ),
                SizedBox(
                  width: 10.h,
                ),
                Text(worker.name, style: AppTextStyle.title()),
              ],
            ),
          ),
        );
      },
    );
  }
}
