part of 'cubit.dart';
abstract class workerDataStates {}
class workerInitialState extends workerDataStates {}

class GetworkerDataLoading extends workerDataStates {}
class GetworkerDataSuccessful extends workerDataStates {}
class GetworkerDataError extends workerDataStates {}

class UpdateProfileLoading extends workerDataStates {}
class UpdateProfileSuccessful extends workerDataStates {}
class UpdateProfileError extends workerDataStates {}


class getRequestLoadingsState extends workerDataStates{}
class getRequestSuccessState extends workerDataStates{}
class getRequestFaillState extends workerDataStates{}


class GetUserDataLoading extends workerDataStates {}
class GetUserDataSuccessful extends workerDataStates {}
class GetUserDataError extends workerDataStates {}

class declineRequestLoadingsState extends workerDataStates{}
class declineRequestSuccessState extends workerDataStates{}
class declineRequestFaillState extends workerDataStates{}

class acceptedRequestLoadingsState extends workerDataStates{}
class acceptedRequestSuccessState extends workerDataStates{}
class acceptedRequestFaillState extends workerDataStates{}