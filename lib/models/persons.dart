//import 'package:fortestpages/models/request.dart';

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fortestpages/models/category.dart';
import 'package:fortestpages/models/request.dart';
import 'package:fortestpages/models/reviews.dart';



class person {
  late String id;
  late String firstName;
  late String lastName;
  late String name;
  late String? username;
  late String? area;
  late String? email;
  late String? phonenumber;
  late String? image;
  late String? city;


  person({
    required this.id,
    required this.firstName,
    required this.lastName,
     this.username,
     this.email,
    this.area,
    this.image,
    this.phonenumber,
    this.city
  }) {
    name = firstName + " " + lastName;
  }

  person.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    firstName = json["firstName"];
    lastName = json["lastName"];
    username = json["userName"];
    email = json["email"];
    phonenumber = (json["phoneNumber"] != null) ? json["phoneNumber"] : null;
    area = json["location"];
    image = (json["profilePicture"] != null) ? json["profilePicture"] : null;
    city = (json["city"] != null) ? json["city"] : null;
    name = firstName + " " + lastName;
  }

 
}

class workerData extends person {
  late var rating;
  late category? cate;
  late List<imageOfPastWork>? pastWorkImages;
  late List<reviews>? review;
  late String? bio;

  workerData({
    required String id,
    required String firstName,
    required String lastName,
    required String username,
    required String email,
    required String area,
    required String city,
    String? image,
    String? phonenumber,
    this.rating,
    this.cate,
    this.pastWorkImages,
    this.review,
    this.bio,
  }) : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
          username: username,
          email: email,
          area: area,
          image: image,
          phonenumber: phonenumber,
          city: city
        );

  workerData.fromJson(Map<String, dynamic> json)
      :
        rating =
            (json.containsKey('overAllRating')) ? json["overAllRating"] : null,
        cate = (json.containsKey('specializID'))
            ? category(id: json['specializID'])
            : null,
        pastWorkImages = (json['imagesOfPastWorks'] != null)
            ? List.from(json['imagesOfPastWorks'])
                .map((e) => imageOfPastWork.fromJson(e))
                .toList()
            : null,
        review = (json['review'] != null)
            ? List.from(json['review'])
                .map((e) => reviews.fromJson(e))
                .toList()
            : null,
        bio = json["bios"],
        super.fromJson(json);

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
