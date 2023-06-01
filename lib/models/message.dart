//import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  late final String senderId;
  late final String message;
  //late final Timestamp time;
  late final String senderName;

  Message({
    required this.senderId,
    //required this.time,
    required this.message,
    required this.senderName,
  });

  Message.fromCollection(Map<String, dynamic> collection) {
    senderId = collection['senderID'] ?? "";
    message = collection['message'] ?? "";
    //time = collection['time'];
    senderName = collection['senderName'] ?? "";
  }

  Map<String, dynamic> toCollection() {
    return {
      'senderID': senderId,
      'message': message,
      //'time': time,
      'senderName': senderName,
    };
  }
}
