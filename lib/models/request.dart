import 'persons.dart';

class requests{
    late int id;
    late String details;
    late int status;
    String? location;
    late String customerId;
    late String workerId;
     String? customerImage;
     String? workerImage;
     String? customerName;
     String? workerName;
    late var rating;
    requests({required this.id,required this.location,required this.customerImage, this.customerName,this.workerName, required this.customerId,required this.workerId,required this.details,required this.status});

    requests.fromJson(Map<String,dynamic> json){

      id=json["id"];
      customerId=json['customerId'];
      workerId=json['craftmanId'];
      customerImage = json?['customerProfilePicture'] != null ? json['customerProfilePicture'] : null;
      workerImage = json?['craftManProfilePicture'] != null ? json['craftManProfilePicture'] : null;
      rating = json?['rating'] != null ? json['rating'] : 0;
      customerName = json?['customerName'] != null ? json['customerName'] : null;
      workerName = json?['craftName'] != null ? json['craftName'] : null;
      details=json["details"];
      status=json['status'];
      location=json['location'] !=null ? json['location']:null;

  }
//   Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['status'] = this.status;
//   data['customer'] = this.user;
//   data['craftman'] = this.worker;
//   data['details'] = this.details;
//   return data;
// }
}