


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/workerData/cubit.dart';
import '../../../customized/FormButton.dart';
//import 'cubit/cubit.dart';


class CraftInfoEditing extends StatelessWidget {
  const CraftInfoEditing({super.key});

  @override
  Widget build(BuildContext context) {
    String bio='';
      return BlocConsumer<workerDataCubit, workerDataStates>(
        listener:(context, state){
          if(state is UpdateProfileSuccessful){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text('تم التغير بنجاح')));
          }
        } ,
        builder:(context, state){
        var cubit=workerDataCubit.get(context);
          
          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                color: Colors.grey[300],
                child: Column(children: [
                  Stack(
                    alignment: AlignmentDirectional.center,
                    clipBehavior: Clip.none,
                    children: [
                      Container(

                          height: 127,
                          color: const Color(0xffD9AD30),
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
                                    )
                                ),
                              ]
                          )
                      ),

                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: TextFormField(
                      onChanged: (value) {
                        bio=value;
                      },
                      textAlign: TextAlign.end,

                      decoration: InputDecoration(
                          hintText: 'ادخل معلومات عملك',
                          hintStyle: const TextStyle(color: Colors.black45),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                          const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(5)
                          )
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 45,
                  ),
                  // the button
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 150),
                    child: FormButton(
                        gradient: LinearGradient(colors: <Color>[
                          const Color(0xffD9AD30),
                          Colors.amber.shade200,
                        ]),
                        onPressed: () {
                        
                            cubit.updateWorker(
  
  firstName: null,
  lastName: null,
  bio: bio,
  username: null,
  location: null,
  phoneNumber: null,
  profilePic: null,
  workImage: null,
);
                        },
                        child: const Text(
                          'حفظ',
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










