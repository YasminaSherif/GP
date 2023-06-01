import 'loginDataResponse.dart';

class requests{
    late int id;
    //late String location;
    late String details;
    late int status;
    late String customerId;
    late String workerId;
    late userData? user;
    late workerData? worker;
    requests(this.id,this.customerId,this.workerId,this.details,this.status);

    requests.fromJson(Map<String,dynamic> json){
      id=json["id"];
      customerId=json['customerId'];
      workerId=json['craftmanId'];
     user = json?['customer'] != null ? userData.fromJson(json['customer']) : null;
    worker = json?['craftman'] != null ? workerData.fromJson(json['craftman']) : null;
      details=json["details"];
      status=json['status'];

  }
  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['status'] = this.status;
  data['customer'] = this.user;
  data['craftman'] = this.worker;
  data['details'] = this.details;
  return data;
}
}