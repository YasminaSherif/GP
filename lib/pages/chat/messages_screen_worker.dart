import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../bloc/chat/chat_cubit.dart';

import '../../models/loginDataResponse.dart';
import '../../models/message.dart';

import 'components/received_message_item.dart';
import 'components/sent_message_item.dart';
import 'styles/colors/app_colors.dart';
import 'styles/texts/app_text_styles.dart';

class MessagesScreen extends StatefulWidget {
  String receiverId;
  String receiverName;
  workerData worker;

  MessagesScreen(
      {Key? key,
      required this.receiverId,
      required this.receiverName,
      required this.worker})
      : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ChatCubit.get(context).getMessages(
        senderId: widget.worker.id, receiverId: widget.receiverId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: Text(widget.receiverName,style: AppTextStyle.appBarText().copyWith(color: Colors.white),),
        backgroundColor: Colors.transparent,
        toolbarHeight: 80,
      ),
      body: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = ChatCubit.get(context);
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10) +
                const EdgeInsets.only(top: 30, bottom: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r)),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Expanded(
                  child: (cubit.messages == null)
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          reverse: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) =>
                              (cubit.messages![index].senderId ==
                                      widget.worker.id)
                                  ? SentMessageItem(
                                      message: cubit.messages![index].message,
                                      date: cubit.messages![index].time,
                                    )
                                  : ReceivedMessageItem(
                                      message: cubit.messages![index].message,
                                      date: cubit.messages![index].time,
                                      senderName:
                                          cubit.messages![index].senderName),
                          itemCount: cubit.messages!.length,
                        ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(
                      30.r,
                    ),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                          ),
                          child: TextFormField(
                            controller: messageController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'أكتب رسالتك..',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: InkWell(
                          onTap: () {
                            if (messageController.text.isNotEmpty) {
                              Message message = Message(
                                  senderName: widget.worker.name,
                                  time: Timestamp.now(),
                                  message: messageController.text,
                                  senderId: widget.worker.id);
                              cubit.sendMessage(
                                  message: message,
                                  receiverId: widget.receiverId);
                              messageController.text = "";
                            }
                          },
                          child: CircleAvatar(
                            minRadius: 20.r,
                            child: const Icon(
                              Icons.send,
                              size: 25.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
