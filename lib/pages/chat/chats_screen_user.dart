import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fortestpages/bloc/workerData/cubit.dart';
import '../../bloc/chat/chat_cubit.dart';
import '../../bloc/userData/cubit.dart';
import '../../models/persons.dart';
import 'components/chat_item_user.dart';
import 'components/chat_item_user_unread.dart';

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
                : ListView.separated(
                    
                    itemBuilder: (context, index) =>
                        ChatListItem(receiver: cubit.workersToChat![index], senderId:cubit.userResponse![0].id, senderName: cubit.userResponse![0].name ,),
                        separatorBuilder: (context, index) =>
                                             Divider(height: 15.h),
                    itemCount: cubit.workersToChat!.length)


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
  ChatListItem({
    required this.receiver,
    required this.senderId,
    required this.senderName,
  });

  @override
  _ChatListItemState createState() => _ChatListItemState();
}

class _ChatListItemState extends State<ChatListItem> {
  late ChatCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = ChatCubit.get(context);
    cubit.getMessages(
      senderId: widget.senderId,
      receiverId: widget.receiver.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is GetMessagesSuccessfulState) {
          if (cubit.messages != null) {
            if (cubit.lastUnreadMessage != null) {
              return ChatItemUnread(
                receiver: widget.receiver,
                senderId: widget.senderId,
                senderName: widget.senderName,
                msg: cubit.lastUnreadMessage!,
                messages: cubit.messages!,
              );
            } else if (cubit.lastReadMessage != null ||
                cubit.messages!.isNotEmpty) {
              return ChatItem(
                receiver: widget.receiver,
                senderId: widget.senderId,
                senderName: widget.senderName,
                msg: cubit.lastReadMessage!,
                messages: cubit.messages!,
              );
            }
          }
        }
        return ChatItem(
          receiver: widget.receiver,
          senderId: widget.senderId,
          senderName: widget.senderName,
          msg: '',
          messages: [],
        );
      },
    );
  }

}