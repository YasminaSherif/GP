part of 'cubit.dart';
abstract class userDataStates {}

class UserInitialState extends userDataStates {}

// class UserChangeState extends userDataStates {}


class GetUserDataLoading extends userDataStates {}
class GetUserDataSuccessful extends userDataStates {}
class GetUserDataError extends userDataStates {}

class UpdateProfileLoading extends userDataStates {}
class UpdateProfileSuccessful extends userDataStates {}
class UpdateProfileError extends userDataStates {}

class sendRequestLoadingsState extends userDataStates{}
class sendRequestSuccessState extends userDataStates{}
class sendRequestFaillState extends userDataStates{}

class changePasswordLoadingState extends userDataStates{}
class changePasswordSuccessfulState extends userDataStates{}
class changePasswordFailState extends userDataStates{}

class sendReviewLoadingsState extends userDataStates{}
class sendReviewSuccessState extends userDataStates{}
class sendReviewFaillState extends userDataStates{}

class getRequestLoadingsState extends userDataStates{}
class getRequestSuccessState extends userDataStates{}
class getRequestFaillState extends userDataStates{}

class getWorkerLoadingsState extends userDataStates{}
class getWorkerSuccessState extends userDataStates{}
class getWorkerFaillState extends userDataStates{}

class getWorkerDataForRequestLoadingsState extends userDataStates{}
class getWorkerDataForRequestSuccessState extends userDataStates{}
class getWorkerDataForRequestFaillState extends userDataStates{}

class deleteRequestLoadingsState extends userDataStates{}
class deleteRequestSuccessState extends userDataStates{}
class deleteRequestFaillState extends userDataStates{}


class getWorkersLoadingsState extends userDataStates{}
class getWorkersSuccessState extends userDataStates{}
class getWorkersFaillState extends userDataStates{}

class searchLoadingsState extends userDataStates{}
class searchSuccessState extends userDataStates{}
class searchFaillState extends userDataStates{}