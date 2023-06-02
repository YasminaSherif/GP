import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:io';
import '../../models/request.dart';
import '../../src/const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../models/loginDataResponse.dart';
import 'dart:convert';
import 'dart:convert' as convert;
part 'states.dart';

class mainCubit extends Cubit<mainStates>
{

  mainCubit(): super(mainInitialState());

  static mainCubit get(context) => BlocProvider.of(context);

   List<workerData>? catResponse;
    getWorkers(int cateId) async {
      catResponse=null;
    emit(getWorkersLoadingsState());
    var url='https://hicraftapi20.azurewebsites.net/api/Craft/GetAllCrafts?catid=${cateId.toString()}';
    http.Response response;
    List<dynamic> jsonResponse;
    List<workerData>? emptyResponse=null;
        try {
      response = await http.get(Uri.parse(url),
          headers: {
            "Accept": "application/json",
            "content-type":"application/json"
          },
          );
      if (response.statusCode == 200) {
        
        jsonResponse =
            convert.jsonDecode(response.body);

            emptyResponse = jsonResponse.map((e) {
              return workerData.fromJson(e);
            }).toList();
            catResponse=emptyResponse;
        emit(getWorkersSuccessState());
      }
      else if (response.statusCode == 400){
         catResponse=emptyResponse;
                emit(getWorkersSuccessState());
      }
      else{
        emit(getWorkersFaillState());
      }
    } on FormatException {
      print("format exception");
      emit(getWorkersFaillState());
    } on SocketException {
      print("problem in connecting to internet");
      emit(getWorkersFaillState());

    } catch (e) {
      print(e);
      emit(getWorkersFaillState());

    }}

    search (String search)async{
      catResponse=null;
      emit(searchLoadingsState());
      search=search.trim();
      Map<String, int> cate = {
  'نجار': 1,
  'حداد': 2,
  'كهربائي': 3,
  'تعقيم': 4,
  'سباك': 5,
  'نقاش': 6,
  'زجاج': 7,
  'محاره': 8,
  'ستائر': 9,
};

if (cate.containsKey(search)) {
  await getWorkers(cate[search]!);
  //emit(searchSuccessState());
}
else{
  emit(searchFaillState());
}
    }
}
  