//import 'package:fortestpages/pages/register/cubit/states.dart';
import 'dart:convert';
import 'dart:convert' as convert;
import 'dart:io';
import '../../models/loginDataResponse.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
part 'states.dart';
class RegisterCubit extends Cubit<RegisterState>
{
  RegisterCubit(): super (RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  final ImagePicker picker = ImagePicker();

  XFile? image;
  File? fileImage;
  void takePhoto(ImageSource source) async {
    var pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
     var file = File(pickedFile.path);
    fileImage = file;
    image=pickedFile;
    emit(RegisterChangeState());
  }
  }


  // speciality,userType are the values you wanna catch
  void specialityChanged(int? value){
    emit(state.copyWith(speciality: value));
  }

  void userTypeChanged(int value){
    emit(state.copyWith(userType: value));
  }


  Register (String firstName,String lastName,String username,String location,String email, String password,String conPassword,String phoneNumber,int role, int? specialization,File? imageFile) async {
    emit(RegisterLoadingState());
    var client= http.Client();
    var url = Uri.parse('https://hicraftapi20.azurewebsites.net/api/Auth/register');
    var response;
    dynamic jsonResponse;
    username=username.trim();
    email=email.trim();
    firstName=firstName.trim();
    lastName=lastName.trim();
    location=location.trim();
    try {
            var request=http.MultipartRequest('POST',url);
            request.headers['content-type']='multipart/form-data';
            request.fields['FirstName']=firstName;
            request.fields['LastName']=lastName;
            request.fields['Username']=username;
            request.fields['Location']=location;
            request.fields['Email']= email;
            request.fields['Password']= password;
            request.fields['ConfirmPassword']= conPassword;
            request.fields['PhoneNumber']=phoneNumber;
            if (imageFile != null) {
      var stream = http.ByteStream(imageFile.openRead());
      var length = await imageFile.length();
      var multipartFile = http.MultipartFile('ProfilePicture', stream, length, filename: imageFile.path.split('/').last);
      request.files.add(multipartFile);
    }
            request.fields['Role']=role.toString();
            if (specialization != null) {
            specialization++;
            request.fields['SpecializationId'] = specialization.toString();
               }

            response=await client.send(request);
            response=await response.stream.bytesToString();
            jsonResponse=convert.jsonDecode(response)  as Map<String, dynamic>;
               //jsonResponse =
           // convert.jsonDecode(response.body) ;
      if (jsonResponse['message']=="Register") {
     
        if(jsonResponse["roles"] == 0){
        userDataResponse userResponse = userDataResponse.fromJson(jsonResponse);
        print(userResponse.data!.firstName);
        emit(RegisterUserSuccessfulState(userResponse));
        client.close();
        }
        else{
        workerDataResponse workerResponse = workerDataResponse.fromJson(jsonResponse);
        emit(RegisterWorkerSuccessfulState(workerResponse));
        }
      }
       else if (jsonResponse['message']=="Email is already Register") {
      emit(AlreadyRegisteredState());
        
        
      }
      else{
        print("error code is");

        print(response.statusCode );
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

