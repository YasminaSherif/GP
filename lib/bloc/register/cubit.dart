//import 'package:fortestpages/pages/register/cubit/states.dart';
import 'dart:convert';
import 'dart:convert' as convert;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../models/persons.dart';

part 'states.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  final ImagePicker picker = ImagePicker();

  XFile? image;
  File? fileImage;

  void takePhoto(ImageSource source) async {
    var pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      var file = File(pickedFile.path);
      fileImage = file;
      image = pickedFile;
      emit(RegisterChangeState());
    }
  }


  // speciality,userType are the values you wanna catch
  void specialityChanged(int? value) {
    emit(state.copyWith(speciality: value));
  }

  void userTypeChanged(int value) {
    emit(state.copyWith(userType: value));
  }

  void registerCityChanged(String value) {
    emit(state.copyWith(registerCity: value));
  }



  Register(
      String firstName,
      String lastName,
      String username,
      String location,
      String city,
      String email,
      String password,
      String conPassword,
      String phoneNumber,
      int role,
      int? specialization,
      File? imageFile) async {
    emit(RegisterLoadingState());
    var client = http.Client();
    var url =
        Uri.parse('https://hicraftapi20.azurewebsites.net/api/Auth/register');
    var response;
    dynamic jsonResponse;
    String jsonResponseError='';
    username = username.trim();
    email = email.trim();
    firstName = firstName.trim();
    lastName = lastName.trim();
    location = location.trim();
    try {
      var request = http.MultipartRequest('POST', url);
      request.headers['content-type'] = 'multipart/form-data';
      request.fields['FirstName'] = firstName;
      request.fields['LastName'] = lastName;
      request.fields['Username'] = username;
      request.fields['Location'] = location;
      request.fields['City'] = city;
      request.fields['Email'] = email;
      request.fields['Password'] = password;
      request.fields['ConfirmPassword'] = conPassword;
      request.fields['PhoneNumber'] = phoneNumber;
      if (imageFile != null) {
        var stream = http.ByteStream(imageFile.openRead());
        var length = await imageFile.length();
        var multipartFile = http.MultipartFile('ProfilePicture', stream, length,
            filename: imageFile.path.split('/').last);
        request.files.add(multipartFile);
      }
      request.fields['Role'] = role.toString();
      if (specialization != null) {
        specialization++;
        request.fields['SpecializationId'] = specialization.toString();
      }

      response = await client.send(request);
      response = await response.stream.bytesToString();

      try {
  jsonResponse = convert.jsonDecode(response) as Map<String ,dynamic>;
} on FormatException catch (e) {
  print('Response is not a valid JSON string: $e');
}
if (jsonResponse == null) {
  jsonResponseError = response;
}
     if(jsonResponse!=null){
      if (jsonResponse['message'] == "Register") {
        if (jsonResponse["roles"] == 0) {
          userData userResponse =
              userData.fromJson(jsonResponse);
          print(userResponse.firstName);
          emit(RegisterUserSuccessfulState(userResponse));
          client.close();
        } else {
          workerData workerResponse =
              workerData.fromJson(jsonResponse);
          emit(RegisterWorkerSuccessfulState(workerResponse));
        }
      } }else if (jsonResponse==null && jsonResponseError!=null) {
        emit(AlreadyRegisteredState(jsonResponseError));
      } else {
        print("error code is");

        print(response.statusCode);
      }
    } on FormatException {
      print("format exception");
      emit(RegisterFailState());
    } on SocketException {
      print("problem in connecting to internet");
      emit(RegisterFailState());
    } catch (e) {
      print(e);
      emit(RegisterFailState());
    }
  }
}