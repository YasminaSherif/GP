import 'persons.dart';

class reviews{
    late int id;
    late String details;
    late String customerId;
    late String workerId;
    String? customerImage;
     String? customerName;
    late var rateOfthisWork;
    reviews(this.id,this.details,this.rateOfthisWork,this.customerId,this.workerId,this.customerImage,this.customerName);

    reviews.fromJson(Map<String,dynamic> json){
      id=json["id"];
      customerId=json['clientID'];
      workerId=json['craftmanId'];
      details=json["details"];
      customerName = json?['clientName'] != null ? json['clientName'] : null;
      rateOfthisWork=json["rateOFthisWork"];
      customerImage = json?['customerProfilePicture'] != null ? json['customerProfilePicture'] : null;
      
  }
 
}