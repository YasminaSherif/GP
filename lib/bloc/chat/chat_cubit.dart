//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../models/loginDataResponse.dart';

import '../../models/message.dart';

part 'chat_state.dart';

// class ChatCubit extends Cubit<ChatState> {
//   ChatCubit() : super(ChatInitial());
//   static ChatCubit get(context) => BlocProvider.of(context);

//   List<userData>? users;
//   void getUsers() {
//     emit(GetUsersLoadingState());
//     //FirebaseFirestore.instance.collection('users').snapshots().listen((event)
//      {
//       users = List.from(event.docs)
//           .map((e) => userData.fromJson(e.data()))
//           .toList();
//       //users!.removeWhere((e) => e.uId == );
//       emit(GetUsersSuccessfulState());
//     }).onError((error) {
//       emit(GetUsersErrorState("حدث خطأ اثناء تحميل الاشخاص"));
//       print(error.toString());
//     });
//   }

//   List<Message>? messages;
//   void getMessages({required String senderId, required String receiverId}) {
//     messages = null;
//     emit(GetMessagesLoadingState());
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(senderId)
//         .collection('chats')
//         .doc(receiverId)
//         .collection('messages')
//         .orderBy('time', descending: true)
//         .snapshots()
//         .listen((event) {
//       messages = List.from(event.docs)
//           .map((e) => Message.fromCollection(e.data()))
//           .toList();
//       emit(GetMessagesSuccessfulState());
//     }).onError((error) {
//       emit(GetMessagesErrorState("حدث خطأ اثناء تحميل الرسائل"));
//       print(error.toString());
//     });
//   }

//   void sendMessage({required Message message, required String receiverId}) {
//     emit(SendMessageLoadingState());
//     // to my chats
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(message.senderId)
//         .collection('chats')
//         .doc(receiverId)
//         .collection('messages')
//         .add(message.toCollection())
//         .then((value) {
//       emit(SendMessageSuccessfulState());
//     }).catchError((error) {
//       if (error is FirebaseException) {
//         print(error.message);
//       }
//       emit(SendMessageErrorState("حدث خطأ اثناء الارسال"));
//     });

//     //to receiver chats
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(receiverId)
//         .collection('chats')
//         .doc(message.senderId)
//         .collection('messages')
//         .add(message.toCollection())
//         .then((value) {
//       emit(SendMessageSuccessfulState());
//     }).catchError((error) {
//       if (error is FirebaseException) {
//         print(error.message);
//       }
//       emit(SendMessageErrorState("حدث خطأ اثناء الارسال"));
//     });
//   }
// }
