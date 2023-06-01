import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortestpages/bloc/mainUser/cubit.dart';
import 'package:fortestpages/models/loginDataResponse.dart';
import 'package:fortestpages/services/methods/navigation.dart';

import '../../bloc/userData/cubit.dart';
import 'craft_profile/craft_profile.dart';


class workerOfCate extends StatelessWidget {
  workerOfCate({Key? key, required this.worker}) : super(key: key);
  workerData worker;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocConsumer<userDataCubit, userDataStates>(
      listener: (context, state) {
        // if (state is getWorkerSuccessState){
        //   navigateWithBack(context, CraftProfile());
        // }
        
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit=userDataCubit.get(context);
        return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Container(
      height: 70.0,
      color: Colors.white,
      child: Row(
        children:  [
          const SizedBox(
            width: 15.0,
          ),
          IconButton(
            
            icon:const Icon(
              Icons.navigate_before_outlined,
              size: 30,
              color: Colors.grey,

            ),
            onPressed: () {
              cubit.getWorkerData(worker.id);
              navigateWithBack(context, CraftProfile());
            },
          ),
          // const Spacer(),
          // const Icon(Icons.star_rate,
          //   color: Colors.amber,
          //   size:20.0 ,
          // ),
          // const Text('4.5',
          //   style: TextStyle(
          //     height: 1.0,
          //     fontSize: 12.0,
          //     fontWeight: FontWeight.w700,
          //   ),
          // ),
          const SizedBox(
            width: 40.0,
          ),
          Expanded(
            child: Container(
              
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
              ),

              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                     Text(worker.firstName +" "+worker.lastName,
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16.0,
                          height: 1.0
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:  [
                        Icon(Icons.star_rate,
                          color: Colors.amber,
                          size:16.0 ,
                        ),
                        
                        Text(worker.rating.toString(),
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),

                     Text(worker.cate!.name!,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11.0,
                          fontWeight: FontWeight.w700,
                          height: 1.5
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
           Padding(
            padding: EdgeInsets.only(right: 15),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 28.0,
              child: CircleAvatar(
                backgroundImage: worker.image != null
        ? MemoryImage(base64Decode(worker.image!))
        : null,
    radius: 35.0,
    backgroundColor: Colors.grey,

              ),
            ),
          ),
        ],
      ),
    ),
  );
  },
    );
  }
}