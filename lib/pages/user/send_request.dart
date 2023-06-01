import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortestpages/models/loginDataResponse.dart';
import 'package:fortestpages/pages/user/user_requests.dart';
import 'package:fortestpages/services/methods/navigation.dart';

import '../../bloc/mainUser/cubit.dart';
import '../../bloc/userData/cubit.dart';
import '../../customized/FormButton.dart';




class Request extends StatelessWidget {
  Request({Key? key, required this.worker}) : super(key: key);
  workerData worker;
  String request='';
  @override
  Widget build(BuildContext context) {
    
      return BlocConsumer<userDataCubit, userDataStates>(
        listener:(context, state){
          if(state is sendRequestSuccessState){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text('تم ارسال الطلب')));
             navigateWithBack(context, UserRequests());
          }
          if(state is sendRequestFaillState){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text('حدث خطاء ما حاول مره اخري')));
            
          }
        } ,
        builder:(context, state){
          var cubit=userDataCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
              color: Colors.grey[250],
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
              Stack(
              clipBehavior: Clip.none,
              children: [
              Container(
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0),
          color: const Color.fromRGBO(217, 173, 48, 1),
          ),
          height: 127.0,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back_outlined,
                                    color: Colors.black,
                                  )),
                            ])),
                Positioned(
                  left: 70.0,
                  top: 60.0,
                  child: Container(
                    height: 150,
                    width: 240,
                    child: Image.asset(
                      'assets/disaster-or-mental-health-crisis.png',
                      fit: BoxFit.cover,
                    ),

                  ),
                ),



                  ],
                ),
                const SizedBox(
                  height: 72,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'انشاء طلب',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900,),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 200,
                    right:15,
                  ),
                  child: Text(
                    'وصف المهمة المطلوبة',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: TextField(
                    onChanged: (val){
                      request=val;
                    },
                    textAlign: TextAlign.end,
                    // validator: (email){
                    //   if (email!.isEmpty || !email.contains('@') || !email.contains('.com')){
                    //     return 'Invalid E-mail';  } },
                    // onSaved: (value){
                    //   email = value!;
                    //   print(email);
                    // },
                    decoration: InputDecoration(
                        hintText: 'اخبرنا عن طلبك',
                        hintStyle: const TextStyle(color: Colors.black45),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                        const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5))),
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),
                // the button
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  
                                    child:
                                     FormButton(
                      gradient: LinearGradient(colors: <Color>[
                        const Color(0xffD9AD30),
                        Colors.amber.shade200,
                      ]),
                      onPressed: () {
                        cubit.sendRequest(request, worker);
                      },
                      child: const Text(
                        'ارسال طلب',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )),
                ),
              ]),
            ),
            ),
          );
        },
      );
    
  }
}