import 'persons.dart';

class reviews{
    late int id;
    late String details;
    late String customerId;
    late String workerId;
    late person? user;
    late workerData? worker;
    late var rateOfthisWork;

    reviews(this.id,this.details,this.rateOfthisWork,this.customerId,this.workerId);

    reviews.fromJson(Map<String,dynamic> json){
      id=json["id"];
      customerId=json['clientID'];
      workerId=json['craftmanId'];
      details=json["details"];
      user = json?['customer'] != null ? person.fromJson(json['customer']) : null;
      worker = json?['craftman'] != null ? workerData.fromJson(json['craftman']) : null;
      rateOfthisWork=json["rateOFthisWork"];
      
  }
 
}