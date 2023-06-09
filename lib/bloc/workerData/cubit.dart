import 'dart:io';
import 'package:fortestpages/pages/worker/craft_profile_editing/pastWorkItem.dart';

import '../../models/request.dart';
import '../../src/const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../models/persons.dart';
import 'dart:convert';
import 'dart:convert' as convert;
part 'states.dart';

class workerDataCubit extends Cubit<workerDataStates>
{
    workerDataCubit(): super(workerInitialState());
  static workerDataCubit get(context) => BlocProvider.of(context);


  List<workerData>? workerResponse;
    getworker() async {
    emit(GetworkerDataLoading());
    var url = Uri.https('hicraftapi20.azurewebsites.net', '/api/Craft/GetCraftById', {'id': Constant.getData(key: 'workerId')});
    http.Response response;
    Map<String, dynamic> jsonMap;
    try {
      response = await http.get(url,
          headers: {
            "Accept": "application/json",
            "content-type":"application/json"
          },
          );
      if (response.statusCode == 200) {
        
        jsonMap =
            convert.jsonDecode(response.body);
          workerResponse = [workerData.fromJson(jsonMap)];
          
        emit(GetworkerDataSuccessful());
        
      }
      else{
        emit(GetworkerDataError());
      }
    } on FormatException {
      print("format exception");
      emit(GetworkerDataError());
    } on SocketException {
      print("problem in connecting to internet");
      emit(GetworkerDataError());

    } catch (e) {
      print(e);
      emit(GetworkerDataError());

    }
  }
  
  workerData? workerUpdateResponse;
  updateWorker({String? firstName, String? lastName,String? bio,  String?  username, String? area,String? city, String? phoneNumber, File? profilePic,File? workImage}) async {
  emit(UpdateProfileLoading());
  var client = http.Client();
  var url = Uri.parse('https://hicraftapi20.azurewebsites.net/api/Craft/EditCraft?CraftManId=${Constant.getData(key: 'workerId')}');
  var response;
  dynamic jsonResponse;
  if(firstName==null && lastName==null &&  bio==null &&  username==null && area==null && phoneNumber==null&& profilePic==null && workImage==null){
    emit(UpdateProfileError());
  }
  try {
    
    // final imageBytes = (imageFile != null) ? await imageFile.readAsBytes() : null;
    // final imageString = (imageBytes != null) ? base64.encode(imageBytes) : null;
    var request = http.MultipartRequest('Put', url);
    request.headers['content-type'] = 'multipart/form-data';
    
     (firstName != null) ? request.fields['FirstName'] = firstName.trim() : request.fields['FirstName'] =workerResponse![0].firstName ;
     request.fields['Specializ']=workerResponse![0].cate!.id.toString();
    
     (lastName != null) ? request.fields['LastName'] = lastName.trim(): request.fields['LastName'] =  workerResponse![0].lastName;
    
     (area != null) ? request.fields['Location'] = area.trim():request.fields['Location'] = workerResponse![0].area!;
    (city != null) ? request.fields['city'] = city.trim():request.fields['city'] = workerResponse![0].city!;
     (username != null) ? request.fields['UserName'] = username.trim(): request.fields['UserName'] = workerResponse![0].username!;
    
     (phoneNumber != null)? request.fields['PhonNumber'] = phoneNumber.trim(): request.fields['PhonNumber'] = workerResponse![0].phonenumber!;
    
     (bio != null) ?  request.fields['Bio'] = bio : request.fields['Bio'] = workerResponse![0].bio ?? ' '; 

    
    if (profilePic != null) {
      var stream = http.ByteStream(profilePic.openRead());
      var length = await profilePic.length();
      var multipartFile = http.MultipartFile('ProfilePicture', stream, length, filename: profilePic.path.split('/').last);
      request.files.add(multipartFile);
    }else{
      request.fields['ProfilePicture'] = '';
    }
    if (workImage != null) {
      var stream = http.ByteStream(workImage.openRead());
      var length = await workImage.length();
      var multipartFile = http.MultipartFile('ImagesOfPastWork', stream, length, filename: workImage.path.split('/').last);
      request.files.add(multipartFile);
      if(workerResponse![0].pastWorkImages != null){
      for  (var i = 0; i < workerResponse![0].pastWorkImages!.length; i++) {
      var pastImageData = workerResponse![0].pastWorkImages![i].image;
      var pastImageBytes = base64Decode(pastImageData);
      var pastImageFile = http.MultipartFile.fromBytes(
      'ImagesOfPastWork',
      pastImageBytes,
      filename: 'past_image_$i.jpg',
    );
     request.files.add(pastImageFile);}
  }
    }else{
      if(workerResponse![0].pastWorkImages != null){
      for  (var i = 0; i < workerResponse![0].pastWorkImages!.length; i++) {
      var pastImageData = workerResponse![0].pastWorkImages![i].image;
      var pastImageBytes = base64Decode(pastImageData);
      var pastImageFile = http.MultipartFile.fromBytes(
      'ImagesOfPastWork',
      pastImageBytes,
      filename: 'past_image_$i.jpg',
    );
     request.files.add(pastImageFile);}
  }
      else {request.fields['ImagesOfPastWork'] = '';}
    }
  
    response = await client.send(request);
    response = await response.stream.bytesToString();
    //jsonResponse = convert.jsonDecode(response) as Map<String, dynamic>;
    if (response == 'Updated') {
     // workerUpdateResponse = workerData.fromJson(jsonResponse);
      if (firstName != null) {
        workerResponse![0].firstName = firstName;
      }
      if (lastName != null) {
        workerResponse![0].lastName = lastName;
      }
      if (area != null) {
        workerResponse![0].area = area;
      }
      if (bio != null) {
        workerResponse![0].bio = bio;
      }
      if (username != null) {
        workerResponse![0].username = username;
      }
      if (phoneNumber != null) {
        workerResponse![0].phonenumber = phoneNumber;
      }
      if (profilePic != null) {
         List<int> imageBytes = await profilePic.readAsBytes();
          String imageBase64 = base64Encode(imageBytes);
          //String imageBase64URL = Uri.encodeComponent(imageBase64);
         workerResponse![0].image=imageBase64;
      }
      if (workImage != null) {
        List<int> imageBytes = await workImage.readAsBytes();
          String imageBase64 = base64Encode(imageBytes);
          //String imageBase64URL = Uri.encodeComponent(imageBase64);
          imageOfPastWork image =imageOfPastWork(image: imageBase64);
          workerResponse![0].pastWorkImages!.add(image);
      }
      emit(UpdateProfileSuccessful());
      client.close();
    } else {
      print("error code is");
      print(jsonResponse['status']);
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
  List<person>? usersToChat;
  List<requests>? panding;
  List<requests>? accepted;
  GetRequests() async {
    emit(getRequestLoadingsState());
    panding=[];
    accepted=[];
    var url = Uri.parse('https://hicraftapi20.azurewebsites.net/api/Craft/GetAllRequests?UserId=${Constant.getData(key: 'workerId')}');
    http.Response response;
    List<dynamic> jsonResponse;
    try {
      response = await http.get(url);
      if (response.statusCode == 200) {
        jsonResponse =convert.jsonDecode(response.body);
        List<requests> allRequests=jsonResponse.map((e) {
              return requests.fromJson(e);
            }).toList();
        panding=allRequests.where((r) => r.status == 0).toList();
        accepted=allRequests.where((r) => r.status == 1).toList();
        if(accepted!=null){
        for(var item in accepted!){
                  List<String> nameParts = item.customerName!.split("  ");
          String firstName = nameParts[0];
          String lastName = nameParts[1];
         person Person = person(id: item.customerId, firstName: firstName, lastName: lastName, image: item.customerImage);
        if (usersToChat!=null && !usersToChat!.any((user) => user.id == item.customerId!)) {
        usersToChat!.add(Person);
          }else if(usersToChat==null){
           usersToChat=[Person];
          }}}
        emit(getRequestSuccessState());
        //sharedPreferences.setString('id', jsonResponse!["id"]);
        }
      else{
        emit(getRequestFaillState());
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
    }
  }

 List<person>? user;
    getUser(String customerid) async {
     //emit(GetUserDataLoading());
    var url ='https://hicraftapi20.azurewebsites.net/api/Craft/GetCustomerById?id=${customerid}';
    http.Response response;
    List<dynamic> jsonResponse;
    try {
      response = await http.get(Uri.parse(url),
          headers: {
            "Accept": "*/*",
            "content-type":"application/json"
          },
          );
      if (response.statusCode == 200) {
        
        jsonResponse =
            convert.jsonDecode(response.body);
        user = jsonResponse.map((e) {
              return person.fromJson(e);
            }).toList();
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

 declineRequest (String craftid,int requestId)async{
    emit(declineRequestLoadingsState());
    var url = Uri.parse('https://hicraftapi20.azurewebsites.net/api/Craft/DeclineRequest?CraftManId=${craftid}&RequestId=${requestId}');
    
      //var client = http.Client();
      var response;
     dynamic jsonResponse;
     try {
    var request = http.MultipartRequest('POST', url);
    request.headers['content-type'] = 'multipart/form-data';
      // request.fields['CustomerId'] = customerid;
      // request.fields['reqid'] = requestId.toString();
    response = await request.send();
    // response = await response.stream.bytesToString();
    //jsonResponse = convert.jsonDecode(response) as Map<String, dynamic>;
    if (response.statusCode == 200) {
      panding!.removeWhere((request) => request.id == requestId);
      emit(declineRequestSuccessState());
      //client.close();
    } else {
      print("error code is");
      print(jsonResponse['status']);
    }
  } on FormatException {
    print("format exception");
    emit(declineRequestFaillState());
  } on SocketException {
    print("problem in connecting to internet");
    emit(declineRequestFaillState());
  } catch (e) {
    print(e);
    emit(declineRequestFaillState());
  }
}
 
   acceptRequest (String craftid,requests req)async{
    emit(acceptedRequestLoadingsState());
    var url = Uri.parse('https://hicraftapi20.azurewebsites.net/api/Craft/AcceptRequest?CraftManId=${craftid}&RequestId=${req.id}');
    
      //var client = http.Client();
      var response;
     dynamic jsonResponse;
     try {
    var request = http.MultipartRequest('POST', url);
    request.headers['content-type'] = 'multipart/form-data';
      // request.fields['CustomerId'] = customerid;
      // request.fields['reqid'] = requestId.toString();
    response = await request.send();
    // response = await response.stream.bytesToString();
    //jsonResponse = convert.jsonDecode(response) as Map<String, dynamic>;
    if (response.statusCode == 200) {
      await getUser(req.customerId);
     if (accepted!=null) {
  accepted!.add(req);
  panding!.removeWhere((item) => item == req); 
}else{
  accepted=[req];
}
if (usersToChat!=null && !usersToChat!.any((item) => item.id == user![0]!.id) ) {
        usersToChat!.add(user![0]);
          }else{
           usersToChat=[user![0]];
          }

      emit(acceptedRequestSuccessState());
      //client.close();
    } else {
      print("error code is");
      print(jsonResponse['status']);
    }
  } on FormatException {
    print("format exception");
    emit(declineRequestFaillState());
  } on SocketException {
    print("problem in connecting to internet");
    emit(acceptedRequestFaillState());
  } catch (e) {
    print(e);
    emit(acceptedRequestFaillState());
  }
}

  
 logout(){
  workerResponse=null;
  panding =null;
  accepted=null;
  user=null;
  workerUpdateResponse=null;
  usersToChat=null;


  Constant.removeData(
                    key: "workerId");                  
 }


    }