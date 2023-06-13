import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../bloc/chat/chat_cubit.dart';
import '../../models/persons.dart';
import '../../models/message.dart';
import 'components/received_message_item.dart';
import 'components/sent_message_item.dart';
import 'styles/colors/app_colors.dart';
import 'styles/texts/app_text_styles.dart';

class MessagesScreen extends StatefulWidget {
  final List<Message>? messages;
  final String receiverId;
  final String receiverName;
  final String senderName;
  final String senderId;
  final ChatCubit chatCubit;

  MessagesScreen({
    Key? key,
    required this.messages,
    required this.receiverId,
    required this.receiverName,
    required this.senderId,
    required this.senderName,
    required this.chatCubit,
  }) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  TextEditingController messageController = TextEditingController();

  @override
  void initState() { super.initState();
    // TODO: implement initState
    if (widget.messages!.isNotEmpty) {
      widget.chatCubit.markMessagesAsRead(
        widget.senderId,
        widget.receiverId,
        widget.messages!,
      );
    }
   
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: const Color.fromRGBO(217, 173, 48, 1),
      appBar: AppBar(
        title: Text(
          widget.receiverName,
          style: AppTextStyle.appBarText().copyWith(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        toolbarHeight: 80,
      ),
      body:BlocConsumer<ChatCubit, ChatState>(
          listener: ( context, state) {},
          builder: ( context, state){
          return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10) +
            const EdgeInsets.only(top: 30, bottom: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Expanded(
              child: (widget.messages == null)
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      reverse: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => (widget
                                  .chatCubit.messages![index].senderId ==
                              widget.senderId)
                          ? SentMessageItem(
                              message: widget.chatCubit.messages![index].message,
                              date: widget.chatCubit.messages![index].time,
                            )
                          : ReceivedMessageItem(
                              message: widget.chatCubit.messages![index].message,
                              date: widget.chatCubit.messages![index].time,
                              senderName:
                                  widget.chatCubit.messages![index].senderName),
                      itemCount: widget.chatCubit.messages!.length,
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
                          Message messageMe = Message(
                            senderName: widget.senderName,
                            time: Timestamp.now(),
                            message: messageController.text,
                            senderId: widget.senderId,
                            isRead: true,
                          );
                          Message messageHim = Message(
                            senderName: widget.senderName,
                            time: Timestamp.now(),
                            message: messageController.text,
                            senderId: widget.senderId,
                            isRead: false,
                          );
                          widget.chatCubit.sendMessage(
                            messageMe: messageMe,
                            messageHim: messageHim,
                            receiverId: widget.receiverId,
                          );

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
  }));
}}
     
  