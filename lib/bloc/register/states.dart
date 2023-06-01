part of 'cubit.dart';

class RegisterState {
  final int speciality;
  final int userType;

  RegisterState({
    this.speciality = 0,
    this.userType = 0,
  });

  RegisterState copyWith({
    int? speciality,
    int? userType,
  }) {
    return RegisterState(
      speciality: speciality ?? this.speciality,
      userType: userType ?? this.userType,
    );
  }
}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}
class RegisterChangeState extends RegisterState{}

class RegisterUserSuccessfulState extends RegisterState {
  final userDataResponse userResponse;

  RegisterUserSuccessfulState(this.userResponse);
}

class RegisterWorkerSuccessfulState extends RegisterState {
  final workerDataResponse workerResponse;

  RegisterWorkerSuccessfulState(this.workerResponse);
}
class AlreadyRegisteredState extends RegisterState {}
class RegisterFailState extends RegisterState {}