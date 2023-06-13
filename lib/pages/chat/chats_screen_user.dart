import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fortestpages/bloc/workerData/cubit.dart';
import '../../bloc/chat/chat_cubit.dart';
import '../../bloc/userData/cubit.dart';
import '../../models/persons.dart';
import 'components/chat_item_read.dart';
import 'components/chat_item_unread.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<userDataCubit, userDataStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = userDataCubit.get(context);
        return  Container(
          color: Colors.grey[250],
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
            Stack(
            alignment: AlignmentDirectional.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                  height: 117.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.0).r,
                    color: const Color.fromRGBO(217, 173, 48, 1),
                  ),
              ),

            ],
          ),

          Padding(
                          padding: EdgeInsets.only(
                            right: 10.0.r,
                            top: 10.0.r,
                          ),
                          child: Text(' الرسائل',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18.0.sp,
                              fontFamily: 'Tajawal',
                            ),
                          ),
                        ),

         (cubit.workersToChat == null)
            ? const Center(child: CircularProgressIndicator())
            : (cubit.workersToChat!.isEmpty)
                ? const Text("لا يوجد محادثات سابقه")
               : Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              // Create a new instance of the ChatCubit for each chat item
                              final chatCubit = ChatCubit();
                              chatCubit.getMessages(
                                senderId: cubit.userResponse![0].id,
                                receiverId: cubit.workersToChat![index].id,
                              );
                              return ChatListItem(
                                receiver: cubit.workersToChat![index],
                                senderId: cubit.userResponse![0].id,
                                senderName: cubit.userResponse![0].name,
                                chatcubit: chatCubit,
                              );
                            },
                            separatorBuilder: (context, index) =>
                                Divider(height: 15.h),
                            itemCount: cubit.workersToChat!.length,
                          ),
                        )


              ]
          ),
       
        );
      },
    );
  }

}


class ChatListItem extends StatefulWidget {
  final person receiver;
  final String senderId;
  final String senderName;
  final ChatCubit chatcubit;
  ChatListItem({
    required this.receiver,
    required this.senderId,
    required this.senderName,
    required this.chatcubit
  });

  @override
  _ChatListItemState createState() => _ChatListItemState();
}

class _ChatListItemState extends State<ChatListItem> {
  late ChatCubit cubit;
  bool isUnread = false;
  @override
  void initState() {
    super.initState();
    cubit = widget.chatcubit;
    cubit.getMessages(
      senderId: widget.senderId,
      receiverId: widget.receiver.id,
    );
  }
void changeState() {
    setState(() {
      isUnread = false;
    });
  }

  @override
  
@override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is GetMessagesSuccessfulState) {
          if (cubit.messages!.isNotEmpty) {
            if (cubit.lastUnreadMessage != null) {
              if (isUnread) {
                return ChatItem(
                  receiver: widget.receiver,
                  senderId: widget.senderId,
                  senderName: widget.senderName,
                  msg: cubit.lastReadMessage ?? '',
                  messages: cubit.messages!,
                  chatCubit: cubit,
                );
              } else {
                return GestureDetector(
                  onTap: () {
                   changeState();
                  },
                  child: ChatItemUnread(
                    receiver: widget.receiver,
                    senderId: widget.senderId,
                    senderName: widget.senderName,
                    msg: cubit.lastUnreadMessage!,
                    messages: cubit.messages!,
                    chatCubit: cubit,
                  ),
                );
              }
            } else if (cubit.lastUnreadMessage == null &&
                cubit.messages!.isNotEmpty) {
              return ChatItem(
                receiver: widget.receiver,
                senderId: widget.senderId,
                senderName: widget.senderName,
                msg: cubit.lastReadMessage!,
                messages: cubit.messages!,
                chatCubit: cubit,
              );
            }
          }
        }
        return ChatItem(
          receiver: widget.receiver,
          senderId: widget.senderId,
          senderName: widget.senderName,
          msg: cubit.lastReadMessage?? '',
          messages: cubit.messages,
          chatCubit: cubit,
        );
      },
    );
  }
}