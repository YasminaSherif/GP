part of 'cubit.dart';

class RegisterState {
  final int speciality;
  final int userType;
  final String registerCity;

  RegisterState({
    this.speciality = 0,
    this.userType = 0,
    this.registerCity = '',
  });

  RegisterState copyWith({
    int? speciality,
    int? userType,
    String? registerCity,
  }) {
    return RegisterState(
      speciality: speciality ?? this.speciality,
      userType: userType ?? this.userType,
      registerCity: registerCity ?? this.registerCity,
    );
  }
}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}
class RegisterChangeState extends RegisterState{}

class RegisterUserSuccessfulState extends RegisterState {
  final userData userResponse;

  RegisterUserSuccessfulState(this.userResponse);
}

class RegisterWorkerSuccessfulState extends RegisterState {
  final workerData workerResponse;

  RegisterWorkerSuccessfulState(this.workerResponse);
}
class AlreadyRegisteredState extends RegisterState {
  String msg='';
  AlreadyRegisteredState(this.msg);
}
class RegisterFailState extends RegisterState {}