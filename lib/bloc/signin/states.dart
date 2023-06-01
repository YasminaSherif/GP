part of 'cubit.dart';
abstract class SignInStates {}

class SignInInitialState extends SignInStates{}
class SignInLoadingState extends SignInStates{}
class SignInUserSuccessfulState extends SignInStates{
  userDataResponse userResponse;
  SignInUserSuccessfulState(this.userResponse);
}
class SignInWorkerSuccessfulState extends SignInStates{
  workerDataResponse workerResponse;
  SignInWorkerSuccessfulState(this.workerResponse);
}
class SignInFailState extends SignInStates{}



class ForgetPasswordLoadingState extends SignInStates{}
class ForgetPasswordSuccessfulState extends SignInStates{
  String email;
  ForgetPasswordSuccessfulState(this.email);
}
class ForgetPasswordFailState extends SignInStates{}



class resetPasswordCodeLoadingState extends SignInStates{}
class resetPasswordCodeSuccessfulState extends SignInStates{
  String email;
  String password;
  resetPasswordCodeSuccessfulState(this.email,this.password);
}
class resetPasswordCodeFailState extends SignInStates{}

class CodeInitialState extends SignInStates{}
class CodeChangeState extends SignInStates{}