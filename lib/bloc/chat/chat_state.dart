part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class SendMessageLoadingState extends ChatState {}

class SendMessageSuccessfulState extends ChatState {}

class SendMessageErrorState extends ChatState {
  final String message;
  SendMessageErrorState(this.message);
}

class GetMessagesLoadingState extends ChatState {}

class GetMessagesSuccessfulState extends ChatState {}

class GetMessagesErrorState extends ChatState {
  final String message;
  GetMessagesErrorState(this.message);
}

class GetUsersLoadingState extends ChatState {}

class GetUsersSuccessfulState extends ChatState {}

class GetUsersErrorState extends ChatState {
  final String message;
  GetUsersErrorState(this.message);
}
