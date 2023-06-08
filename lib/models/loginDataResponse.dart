//import 'package:fortestpages/models/request.dart';

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fortestpages/models/category.dart';
import 'package:fortestpages/models/request.dart';
import 'package:fortestpages/models/reviews.dart';


//List<userData> userDataFromJson(String str) => List<userData>.from(json.decode(str).map((x) => userData.fromJson(x)));

class userDataResponse{
  late final String? message;
  late userData? data;

  userDataResponse({
    required this.message,
    required this.data,
  });

  userDataResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = (json != null) ? userData.fromJson(json) : null;
  }
}

class workerDataResponse{
  late final String? message;
  late workerData? data;

  workerDataResponse({
    required this.message,
    required this.data,
  });

  workerDataResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = (json != null) ? workerData.fromJson(json) : null;
  }
}


class userData {
  late String id;
  late String firstName;
  late String lastName;
  late String name=firstName+" "+lastName;
  late String username;
  late String location;
  late String email;
  late String? phonenumber;
  late String? image;
  late List<requests>? request;
  // late List<review>? reviews;


  userData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.location,
    this.image,
    this.phonenumber,
    this.request,
    // this.reviews
   
    });


  userData.fromJson(Map<String,dynamic> json){
      id=json["id"];
      firstName=json["firstName"];
      lastName=json["lastName"];
      username=json["userName"];
      email=json["email"];
      phonenumber=(json["phoneNumber"]!=null)
      ?json["phoneNumber"]
      :null;
      location=json["location"];
      image=(json["profilePicture"]!=null)
      ? json["profilePicture"]
      : null;
      request=(json['serviceRequests'] != null)
                ?List.from(json['serviceRequests']).map((e) => requests.fromJson(e)).toList()
                :null;
      // reviews=(json['reviews'] != null)
      // ?List.from(json['reviews']).map((e) => review.fromJson(e)).toList()
      // : null;
  }


  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = this.id;
  data['firstName'] = this.firstName;
  data['lastName'] = this.lastName;
  data['userName'] = this.username;
  data['email'] = this.email;
  data['phoneNumber'] = this.phonenumber;
  data['location'] = this.location;
  data['profilePic'] = this.image;
  data['serviceRequests'] = this.request?.map((e) => e.toJson()).toList();
  return data;
}
}






class workerData {
  late String id;
  late String firstName;
  late String lastName;
  late String name=firstName+" "+lastName;
  late String username;
  late String location;
  late String email;
  late String? phonenumber;
  late String? image;
  late var rating;
  late category? cate;
  late List<requests>? request;
  late List<imageOfPastWork>? pastWorkImages;
  late List<reviews>? review;
  late String? bio;

  workerData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.location,
    this.image,
    this.phonenumber,
    this.rating,
    this.cate,
    this.pastWorkImages,
    this.request,
    this.review,
    this.bio
    });

  workerData.fromJson(Map<String,dynamic> json){
      id=json['id'];
      firstName=json["firstName"];
      lastName=json["lastName"];
      username=json["userName"];
      email=json["email"];
      phonenumber=json["phoneNumber"];
      location=json["location"];
      if (json.containsKey('overAllRating')) {
      rating = json["overAllRating"];
      }
      image=(json["profilePicture"]!=null)
      ? json["profilePicture"]
      : null;
      request=(json['serviceRequests'] != null)
                ?List.from(json['serviceRequests']).map((e) => requests.fromJson(e)).toList()
                :null;
      review=(json['review'] != null)
      ?List.from(json['review']).map((e) => reviews.fromJson(e)).toList()
      : null;
      // if (json.containsKey('specializID')) {
      //  cate = category(id: json['specializID']);
      //  }

      if (json.containsKey('specializID')) {
      cate=category(id: json['specializID']);
      }

      pastWorkImages=(json['imagesOfPastWorks'] != null )
      ? List.from(json['imagesOfPastWorks']).map((e) => imageOfPastWork.fromJson(e)).toList()
      : null;
      // if (json.containsKey('bios')) {
      //  bio=json["bios"];
      //  }
       bio=json["bios"];
      
  }


    Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = this.id;
  data['firstName'] = this.firstName;
  data['lastName'] = this.lastName;
  data['userName'] = this.username;
  data['email'] = this.email;
  data['location'] = this.location;
  data['overAllRating'] = this.rating;
  data['profilePic'] = this.image;
  data['serviceRequests'] = this.request?.map((e) => e.toJson()).toList();
  data['reviews'] = this.review?.map((e) => e.toJson()).toList();
  data['specializ'] = this.cate?.toJson();
  data['imagesOfPastWorks'] =
      this.pastWorkImages?.map((e) => e.toJson()).toList();
  return data;
}




}





class imageOfPastWork{

  late String image;
  //late workerData worker;
  imageOfPastWork({
     
    required this.image,
    //required this.worker
  });
  imageOfPastWork.fromJson(Map<String,dynamic> json){
    image=json['images'];
  }
  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['images'] = this.image;
  return data;
}
}

  



