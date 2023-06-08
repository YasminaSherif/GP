//import 'package:fortestpages/pages/send_code/cubit/states.dart';
import 'dart:io';
import '../../models/request.dart';
import '../../src/const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../models/loginDataResponse.dart';
import 'dart:convert';
import 'dart:convert' as convert;
part 'states.dart';
class userDataCubit extends Cubit<userDataStates>
{
  userDataCubit(): super(UserInitialState());
  static userDataCubit get(context) => BlocProvider.of(context);
    
     List<userData>? userResponse;
    getUserData() async {
    emit(GetUserDataLoading());
    var url = Uri.https('hicraftapi20.azurewebsites.net', '/api/Craft/GetCustomerById', {'id': Constant.getData(key: 'id')});
    http.Response response;
    List<dynamic> jsonResponse;
    try {
      response = await http.get(url,
          headers: {
            "Accept": "application/json",
            "content-type":"application/json"
          },
          );
      if (response.statusCode == 200) {
        
        jsonResponse =
            convert.jsonDecode(response.body);
        userResponse = jsonResponse.map((e) {
              return userData.fromJson(e);
            }).toList();
        emit(GetUserDataSuccessful());
      }
      else{
        emit(GetUserDataError());
      }
    } on FormatException {
      print("format exception");
      emit(GetUserDataError());
    } on SocketException {
      //getUser();
      print("problem in connecting to internet");
      emit(GetUserDataError());

    } catch (e) {
      print(e);
      emit(GetUserDataError());

    }
  }
  
  List<requests>? panding;
  List<requests>? accepted;
  List<requests>? declined;
  List<workerData>? workersToChat;
  GetRequests() async {
    emit(getRequestLoadingsState());
    var url = Uri.parse('https://hicraftapi20.azurewebsites.net/api/Customer/GetAllRequests?UserId=${Constant.getData(key: 'id')}');
    http.Response response;
    List<dynamic> jsonResponse;
    try {
      response = await http.get(url);
      if (response.statusCode == 200) {
        jsonResponse =convert.jsonDecode(response.body);
        List<requests> allRequests=jsonResponse.map((e) {
              return requests.fromJson(e);
            }).toList();
          for (var request in allRequests) {
        //   if (request.user == null) {
        //   request.user = userResponse![0];
        // }
        if (request.worker == null) {
          await getWorkerDataForRequest(request.workerId);
          request.worker = worker![0];
          
        }
      }
        panding=allRequests.where((r) => r.status == 0).toList();
        accepted=allRequests.where((r) => r.status == 1).toList();
        declined=allRequests.where((r) => r.status == 2).toList(); 
        if(accepted!=null){
        for(var item in accepted!){
        if (workersToChat!=null && !workersToChat!.any((worker) => worker.id == item.worker!.id)) {
        workersToChat!.add(item.worker!);
          }else if(workersToChat==null){
           workersToChat=[item.worker!];
          }}}
        
        emit(getRequestSuccessState());
        //sharedPreferences.setString('id', jsonResponse!["id"]);
        }
             else if (response.statusCode == 400){
                emit(getRequestSuccessState());
                // panding = [];
                // accepted = [];
                // declined = [];
      }
      else{
        emit(getRequestFaillState());
      //   panding = [];
      //  accepted = [];
      //  declined = [];
      }
    } on FormatException {
      print("format exception");
      emit(getRequestFaillState());
    } on SocketException {
      print("problem in connecting to internet");
      emit(getRequestFaillState());

    } catch (e) {
      print(e);
      emit(getRequestFaillState());
      //  panding = [];
      //  accepted = [];
      //  declined = [];
    }
  }

  deleteRequest (String customerid,requests req)async{
    emit(deleteRequestLoadingsState());
    var url = Uri.parse('https://hicraftapi20.azurewebsites.net/api/Customer/DeleteRequest?CustomerId=${customerid}&reqid=${req.id.toString()}');
    
      //var client = http.Client();
      var response;
     dynamic jsonResponse;
     try {
    var request = http.MultipartRequest('DELETE', url);
    request.headers['content-type'] = 'multipart/form-data';
      // request.fields['CustomerId'] = customerid;
      // request.fields['reqid'] = requestId.toString();
    response = await request.send();
    // response = await response.stream.bytesToString();
    //jsonResponse = convert.jsonDecode(response) as Map<String, dynamic>;
    if (response.statusCode == 200) {
      if (panding != null) {
      panding!.removeWhere((item) => item == req);
      }
      emit(deleteRequestSuccessState());
      //client.close();
    } else {
      print("error code is");
      print(jsonResponse['status']);
    }
  } on FormatException {
    print("format exception");
    emit(deleteRequestFaillState());
  } on SocketException {
    print("problem in connecting to internet");
    emit(deleteRequestFaillState());
  } catch (e) {
    print(e);
    emit(deleteRequestFaillState());
  }
}

    sendRequest(String details, workerData worker) async {
    emit(sendRequestLoadingsState());
    var url = Uri.parse('https://hicraftapi20.azurewebsites.net/api/Customer/MakeRequest');
    http.Response response;
    //dynamic jsonResponse;
    try {
      response = await http.post(url,
          headers: {
            'Accept': '*/*',
            "content-type":"application/json"
          },
          body: jsonEncode(<String, String>{
             
            "customerId": userResponse![0].id,
            "craftmanId": worker.id,
            "details": details,
            
          }),
          );
      if (response.statusCode == 200) {
        
        requests request=requests(
          0000,userResponse![0].id,worker.id,details,0
        );
        if (panding!=null) {
  panding!.add(request);
}else{
  panding=[request];
}
         GetRequests();
        emit(sendRequestSuccessState());
        //sharedPreferences.setString('id', jsonResponse!["id"]);
        }
      else{
        emit(sendRequestFaillState());
      }
    } on FormatException {
      print("format exception");
      emit(sendRequestFaillState());
    } on SocketException {
      print("problem in connecting to internet");
      emit(sendRequestFaillState());

    } catch (e) {
      print(e);
      emit(sendRequestFaillState());
    }
  }

    userData? userUpdateResponse;
    updateUser({String? firstName, String? lastName, String? username, String? location, String? phoneNumber, File? imageFile}) async {
  emit(UpdateProfileLoading());
  var client = http.Client();
  var url = Uri.parse('https://hicraftapi20.azurewebsites.net/api/Customer/EditCustomer?CustomerId=${Constant.getData(key: 'id')}');
  var response;
  //dynamic jsonResponse;
  try {
    // final imageBytes = (imageFile != null) ? await imageFile.readAsBytes() : null;
    // final imageString = (imageBytes != null) ? base64.encode(imageBytes) : null;
    var request = http.MultipartRequest('PUT', url);
    request.headers['content-type'] = 'multipart/form-data';
     //request.fields['id'] = userResponse![0].id;
    // request.fields['CustomerId'] =  userResponse![0].id;
     (firstName != null) ? request.fields['FirstName'] = firstName.trim() : request.fields['FirstName'] =userResponse![0].firstName ;
    
     (lastName != null) ? request.fields['LastName'] = lastName.trim(): request.fields['LastName'] =  userResponse![0].lastName;
     (username != null) ? request.fields['UserName'] = username.trim(): request.fields['UserName'] = userResponse![0].username;
    
     (location != null) ? request.fields['Location'] = location.trim(): request.fields['Location'] = userResponse![0].location;
     (phoneNumber != null)? request.fields['PhonNumber'] = phoneNumber.trim() : request.fields['PhonNumber'] = userResponse![0].phonenumber!;
    
    if (imageFile != null) {
      var stream = http.ByteStream(imageFile.openRead());
      var length = await imageFile.length();
      var multipartFile = http.MultipartFile('ProfilePicture', stream, length, filename: imageFile.path.split('/').last);
      request.files.add(multipartFile);
    }else{
      request.fields['ProfilePicture'] = '';
    }
  
    response = await client.send(request);
    response = await response.stream.bytesToString();
   // jsonResponse = jsonDecode(response);
   print(response.runtimeType);
    if (response== "Updated") {
     // userUpdateResponse = userData.fromJson(jsonResponse);
      if (firstName != null) {
        userResponse![0].firstName = firstName;
      }
      if (lastName != null) {
        userResponse![0].lastName = lastName;
      }
      if (location != null) {
        userResponse![0].location = location;
      }
      if (username != null) {
        userResponse![0].username = username;
      }
      if (phoneNumber != null) {
        userResponse![0].phonenumber = phoneNumber;
      }
      if (imageFile != null) {
         List<int> imageBytes = await imageFile.readAsBytes();
          String imageBase64 = base64Encode(imageBytes);
          //String imageBase64URL = Uri.encodeComponent(imageBase64);
         userResponse![0].image=imageBase64;
      }
      emit(UpdateProfileSuccessful());
      client.close();
    } else {
      print("error code is");
      //print(jsonResponse['status']);
    }
  } on FormatException {
    print("format exception");
    emit(UpdateProfileError());
  } on SocketException {
    print("problem in connecting to internet");
    emit(UpdateProfileError());
  } catch (e) {
    print(e);
    emit(UpdateProfileError());
  }
}

  changePassword(String password,String conPassword) async {
    emit(changePasswordLoadingState());
    var url = Uri.parse('https://hicraftapi20.azurewebsites.net/api/Auth/ChangePassword');
    http.Response response;
    try {
      response = await http.post(url,
          headers: {
            "Accept": "*/*",
            "content-type":"application/json"
          },
          body: jsonEncode(<String, String>{
            "email": userResponse![0].email,
            "password": password,
            "confirmPassword": conPassword,
            
          }),
          );
      if (response.statusCode == 200) { 
        emit( changePasswordSuccessfulState()); 

        }
      else{
        emit(changePasswordFailState());
      }
    } on FormatException {
      print("format exception");
      emit(changePasswordFailState());
    } on SocketException {
      print("problem in connecting to internet");
      emit(changePasswordFailState());
    } catch (e) {
      print(e);
      emit(changePasswordFailState());

    }
  }

  sendReview(double rating,String details, workerData worker) async {
    emit(sendReviewLoadingsState());
    var url = Uri.parse('https://hicraftapi20.azurewebsites.net/api/Customer/CreateReview');
    http.Response response;
    // dynamic jsonResponse;
    try {
      response = await http.post(url,
          headers: {
            'Accept': '*/*',
            "content-type":"application/json"
          },
          body: jsonEncode(<String, String>{
          
            "clientID":userResponse![0].id ,
            "craftmanId": worker.id,
            "details": details,
            "rateOFthisWork": rating.toString(),
          }),
          );
      if (response.statusCode == 200) {
        emit(sendReviewSuccessState());
        //sharedPreferences.setString('id', jsonResponse!["id"]);
        }
      else{
        emit(sendReviewFaillState());
      }
    } on FormatException {
      print("format exception");
      emit(sendReviewFaillState());
    } on SocketException {
      print("problem in connecting to internet");
      emit(sendReviewFaillState());

    } catch (e) {
      print(e);
      emit(sendRequestFaillState());
    }
  } 

  List<workerData>? worker;
    getWorkerData(String workerId) async {
    worker = null;
    emit(getWorkerLoadingsState());
    var url='https://hicraftapi20.azurewebsites.net/api/Craft/GetCraftById?id=${workerId}';
    http.Response response;
    Map<String, dynamic> jsonMap;

    try {
      response = await http.get(Uri.parse(url),
          headers: {
            "Accept": "application/json",
            "content-type":"application/json"
          },
          );
      if (response.statusCode == 200) {
        
       jsonMap =
            convert.jsonDecode(response.body);
          worker = [workerData.fromJson(jsonMap)];

          for (var item in worker![0].review!) {
          if (item.user == null) {
           await getUser(item.customerId);
          item.user = user![0];
        }
        if (item.worker == null) {
          item.worker = worker![0];
        }
      }

        emit(getWorkerSuccessState());
      }
      else{
        emit(getWorkerFaillState());
      }
    } on FormatException {
      print("format exception");
      emit(getWorkerFaillState());
    } on SocketException {
      print("problem in connecting to internet");
      emit(getWorkerFaillState());

    } catch (e) {
      print(e);
      emit(getWorkerFaillState());

    }
  }

  List<workerData>? workerForRequest;
  getWorkerDataForRequest(String workerId) async {
    workerForRequest = null;
    emit(getWorkerDataForRequestLoadingsState());
    var url='https://hicraftapi20.azurewebsites.net/api/Craft/GetCraftById?id=${workerId}';
    http.Response response;
    Map<String, dynamic> jsonMap;

    try {
      response = await http.get(Uri.parse(url),
          headers: {
            "Accept": "application/json",
            "content-type":"application/json"
          },
          );
      if (response.statusCode == 200) {
        
       jsonMap =
            convert.jsonDecode(response.body);
          worker = [workerData.fromJson(jsonMap)];

      //     for (var item in worker![0].review!) {
      //     if (item.user == null) {
      //      await getUser(item.customerId);
      //     item.user = user![0];
      //   }
      //   if (item.worker == null) {
      //     item.worker = worker![0];
      //   }
      // }

        emit(getWorkerDataForRequestSuccessState());
      }
      else{
        emit(getWorkerDataForRequestFaillState());
      }
    } on FormatException {
      print("format exception");
      emit(getWorkerDataForRequestFaillState());
    } on SocketException {
      print("problem in connecting to internet");
      emit(getWorkerDataForRequestFaillState());

    } catch (e) {
      print(e);
      emit(getWorkerDataForRequestFaillState());

    }
  }

List<userData>? user;
    getUser(String customerid) async {
      user=null;
    //  emit(GetUserDataLoading());
    var url ='https://hicraftapi20.azurewebsites.net/api/Customer/GetCustomerById?id=${customerid}';
    http.Response response;
    // List<dynamic> jsonResponse;
    Map<String, dynamic> jsonMap;

    try {
      response = await http.get(Uri.parse(url),
          headers: {
            "Accept": "*/*",
            "content-type":"application/json"
          },
          );
      if (response.statusCode == 200) {
        
        jsonMap =
            convert.jsonDecode(response.body);
          user = [userData.fromJson(jsonMap)];
        // emit(GetUserDataSuccessful());
      }
      else{
        emit(GetUserDataError());
      }
    } on FormatException {
      print("format exception");
      emit(GetUserDataError());
    } on SocketException {
      //getUser();
      print("problem in connecting to internet");
      emit(GetUserDataError());

    } catch (e) {
      print(e);
      emit(GetUserDataError());

    }
  }

 logout(){
  userResponse=null;
  panding =null;
  accepted=null;
  declined=null;
  worker=null;
  workerForRequest=null;
  user=null;
  userUpdateResponse=null;
  workersToChat=null;

 }



}





