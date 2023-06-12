//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:meta/meta.dart';
import '../../models/persons.dart';

import '../../models/message.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  static ChatCubit get(context) => BlocProvider.of(context);

  List<Message>? messages;
  String? lastUnreadMessage;
  String? lastReadMessage='';
  void getMessages({required String senderId, required String receiverId}) {
    messages = null;
    lastUnreadMessage=null;
    lastReadMessage=null;
    emit(GetMessagesLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(senderId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('time', descending: true)
        .snapshots()
        .listen((event) {
      messages = List.from(event.docs)
          .map((e) => Message.fromCollection(e.data()))
          .toList();
    if (messages!.isNotEmpty) {
       bool hasUnreadMessages = messages!.any((message) => !message.isRead);
          if (hasUnreadMessages) {
    String? lastUnread = messages!
        .firstWhere((message) => !message.isRead).message;
    lastUnreadMessage = lastUnread;
  } else {
    String? lastRead = messages!
        .firstWhere((message) => message.isRead).message;
    lastReadMessage = lastRead;
  }
}
      emit(GetMessagesSuccessfulState());
    }).onError((error) {
      emit(GetMessagesErrorState("حدث خطأ اثناء تحميل الرسائل"));
      print(error.toString());
    });
  }

  void deleteLastUnreadMessage(List<Message>? msgs){
    msgs!.where((message) => message.isRead == false)
      .forEach((message){
        message.isRead==true;});
      }



   

void markMessagesAsRead(String senderId, String receiverId, List<Message>? msgs) {
  msgs!
      .where((message) => message.isRead==false)
      .forEach((message) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(senderId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .where('message', isEqualTo: message.message)
        .where('time', isEqualTo: message.time)
        .get();

    for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
      await documentSnapshot.reference.update({'isRead': true});
    }
    message.isRead = true;
    
  }
  );
  lastUnreadMessage=null;
}


  void sendMessage(
      {required Message messageMe,
      required Message messageHim,
      required String receiverId}) {
    emit(SendMessageLoadingState());

    // to my chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(messageMe.senderId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageMe.toCollection())
        .then((value) {
      if (messages != null) {
        messages!.add(messageMe);
      }
      emit(SendMessageSuccessfulState());
    }).catchError((error) {
      if (error is FirebaseException) {
        print(error.message);
      }
      emit(SendMessageErrorState("حدث خطأ اثناء الارسال"));
    });

    //to receiver chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(messageHim.senderId)
        .collection('messages')
        .add(messageHim.toCollection())
        .then((value) {
      emit(SendMessageSuccessfulState());
    }).catchError((error) {
      if (error is FirebaseException) {
        print(error.message);
      }
      emit(SendMessageErrorState("حدث خطأ اثناء الارسال"));
    });
  }
}