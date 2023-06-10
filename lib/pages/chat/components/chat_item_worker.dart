import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fortestpages/bloc/userData/cubit.dart';
import 'package:fortestpages/services/methods/navigation.dart';
// import 'package:social_app/bloc/main/main_cubit.dart';

// import '../../../core/styles/texts/app_text_styles.dart';

import '../../../bloc/workerData/cubit.dart';
import '../../../models/persons.dart';
import '../messages_screen_worker.dart';
import '../styles/texts/app_text_styles.dart';

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
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25.0,
                  backgroundImage:user.image != null
        ? MemoryImage(base64Decode(user.image!))
        : null,
    backgroundColor: Colors.grey,
                ),
                SizedBox(
                  width: 10.h,
                ),
                Text(user.name, style: AppTextStyle.title()),
              ],
            ),
          ),
        );
      },
    );
  }
}
