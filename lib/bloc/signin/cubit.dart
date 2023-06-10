import 'dart:convert';
import 'dart:convert' as convert;
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortestpages/models/persons.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../src/const.dart';
                                                                                                                                                                                                                                                                                                                                                                                                         
part 'states.dart';

class SignInCubit extends Cubit<SignInStates>
{
  SignInCubit(): super (SignInInitialState());

  static SignInCubit get(context) => BlocProvider.of(context);
  
    userData? loginResponse;
    login(String email, String password) async {
    emit(SignInLoadingState());
    var url = Uri.parse('https://hicraftapi20.azurewebsites.net/api/Auth/Login');
    http.Response response;
    dynamic jsonResponse;
    // SharedPreferences pref=await SharedPreferences.getInstance();
    try {
      response = await http.post(url,
          headers: {
            "Accept": "application/json",
            "content-type":"application/json"
          },
          body: jsonEncode(<String, String>{
            "email": email,
            "password": password
          }),
          );
          
      if (response.statusCode == 200) {
        jsonResponse = 
         convert.jsonDecode(response.body) as Map<String, dynamic>;
        if(jsonResponse["roles"] == 0){
         loginResponse = userData.fromJson(jsonResponse);

        emit(SignInUserSuccessfulState(loginResponse!));
        //sharedPreferences.setString('id', jsonResponse!["id"]);
        }
        else{
        workerData workerResponse = workerData.fromJson(jsonResponse);
        emit(SignInWorkerSuccessfulState(workerResponse));
        }
      }
      else{
        emit(SignInFailState());
      }
    } on FormatException {
      print("format exception");
      emit(SignInFailState());
    } on SocketException {
      print("problem in connecting to internet");
      emit(SignInFailState());

    } catch (e) {
      print(e);
      emit(SignInFailState());

    }
  }

    ForgetPassword(String email) async {
    emit(ForgetPasswordLoadingState());
    var url = Uri.parse('https://hicraftapi20.azurewebsites.net/api/ForgotPassword/ForgotPassword');
    http.Response response;
    try {
      response = await http.post(url,
          headers: {
            "Accept": "application/json",
            "content-type":"application/json"
          },
          body: jsonEncode(<String, String>{
            "email": email,
            
          }),
          );
      if (response.statusCode == 200) { 
        emit(ForgetPasswordSuccessfulState(email));
        }
      else{
        emit(ForgetPasswordFailState());
      }
    } on FormatException {
      print("format exception");
      emit(ForgetPasswordFailState());
    } on SocketException {
      print("problem in connecting to internet");
      emit(ForgetPasswordFailState());
    } catch (e) {
      print(e);
      emit(ForgetPasswordFailState());

    }
  }
  
  String currentText = '';
  void setValue(var value){
    currentText = value;
    emit(CodeChangeState());
  }

    checkForgetCode(String email,String password,String conPassword) async {
    emit(resetPasswordCodeLoadingState());
    var url = Uri.parse('https://hicraftapi20.azurewebsites.net/api/ForgotPassword/ResetPassword');
    http.Response response;
    try {
      response = await http.post(url,
          headers: {
            "Accept": "application/json",
            "content-type":"application/json"
          },
          body: jsonEncode(<String, String>{
            "email": email,
            "password": password,
            "confirmPassword": conPassword,
            "code": currentText
          }),
          );
      if (response.statusCode == 200) { 
        emit(resetPasswordCodeSuccessfulState(email,password));
        }
      else{
        emit(resetPasswordCodeFailState());
      }
    } on FormatException {
      print("format exception");
      emit(resetPasswordCodeFailState());
    } on SocketException {
      print("problem in connecting to internet");
      emit(resetPasswordCodeFailState());
    } catch (e) {
      print(e);
      emit(resetPasswordCodeFailState());

    }
  }

  



    

  
}
