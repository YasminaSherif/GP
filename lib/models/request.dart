import 'persons.dart';

class requests{
    late int id;
    late String details;
    late int status;
    late String city;
    late String area;
    late String customerId;
    late String workerId;
    late String? customerImage;
    late String? workerImage;
    late String? customerName;
    late String? workerName;
    late var rating;
    requests(this.id,this.customerId,this.workerId,this.details,this.status);

    requests.fromJson(Map<String,dynamic> json){
      id=json["id"];
      customerId=json['customerId'];
      workerId=json['craftmanId'];
      customerImage = json?['customerProfilePicture'] != null ? customerImage : null;
      workerImage = json?['craftManProfilePicture'] != null ? workerImage : null;
      rating = json?['rating'] != null ? rating : null;
      customerName = json['customerName'] != null ? workerName : null;
      workerName = json['craftName'] != null ? customerName : null;
      details=json["details"];
      status=json['status'];

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