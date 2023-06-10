import 'persons.dart';

class reviews{
    late int id;
    late String details;
    late String customerId;
    late String workerId;
    late userData? user;
    late workerData? worker;
    late var rateOfthisWork;

    reviews(this.id,this.details,this.rateOfthisWork,this.customerId,this.workerId);

    reviews.fromJson(Map<String,dynamic> json){
      id=json["id"];
      customerId=json['clientID'];
      workerId=json['craftmanId'];
      details=json["details"];
      user = json?['customer'] != null ? userData.fromJson(json['customer']) : null;
      worker = json?['craftman'] != null ? workerData.fromJson(json['craftman']) : null;
      rateOfthisWork=json["rateOFthisWork"];
      
  }
  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = this.id;
  data['details'] = this.details;
  data['user'] = this.user?.toJson();
  data['rateOfthisWork'] = this.rateOfthisWork;
  return data;
}
}