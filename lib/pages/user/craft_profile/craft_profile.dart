import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fortestpages/pages/user/craft_profile/ratingItem.dart';
import 'package:fortestpages/pages/user/craft_profile/workerImageItem.dart';
import 'package:fortestpages/services/methods/navigation.dart';

import '../../../bloc/mainUser/cubit.dart';
import '../../../bloc/userData/cubit.dart';
import '../../../customized/FormButton.dart';
import '../../../models/loginDataResponse.dart';
import '../Send_Request.dart';

class CraftProfile extends StatelessWidget {
   CraftProfile({Key? key,workerid}) : super(key: key);
 // workerData worker;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<userDataCubit , userDataStates>(
          listener: ( context, state) {},
          builder: ( context, state){
            late double _minTextAdapt = 0.0;
            var cubit=userDataCubit.get(context);
            
         return Scaffold(
      body:
      (cubit.worker == null)
      ? const Center(child: CircularProgressIndicator())
      :Container(
        color: Colors.grey[300],
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.0),
                      color: const Color.fromRGBO(217, 173, 48, 1),
                    ),
                      height: 117.0,

                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Icon(
                            Icons.arrow_back_sharp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 140.0,
                    top: 85.0,
                    child: Column(
                      children:  [
                                CircleAvatar(
  backgroundColor: Colors.transparent,
  radius: 35.0,
  child: CircleAvatar(
  backgroundColor: Colors.transparent,
  radius: 35.0,
  child: CircleAvatar(
      
    backgroundImage: cubit.worker![0].image != null
        ? MemoryImage(base64Decode(cubit.worker![0].image!))
        : null,
    radius: 35.0,
    backgroundColor: Colors.grey,
  ),
),),
                         Text(cubit.worker![0].firstName+" "+cubit.worker![0].lastName,
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                         Text(cubit.worker![0].cate!.name!,
                          style: TextStyle(
                            color: Colors.grey,
                            height: 1.0,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            Icon(Icons.star_rate,
                              color: Colors.amber,
                              size:20.0 ,
                            ),
                            Text(cubit.worker![0].rating.toString(),
                              style: TextStyle(
                                height: 1.0,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              
              Container(
                margin: const EdgeInsets.only(
                  top: 100.0,
                ),
                color: Colors.white,
                height: 65.0,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 65.0,
                    right: 10.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children:  [
                      const Text('عني',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(cubit.worker![0].bio??"لم يتم اضافة تفاصيل بعد",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: Colors.grey,
                                  height: 1.1,
                                  fontSize: _minTextAdapt != 0.0 ? _minTextAdapt : MediaQuery.of(context).size.width * 0.045,
                                  fontWeight: FontWeight.w700,

                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 7.0,
              ),
              Container(
                color: Colors.white,
                height: 120.0,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children:  [
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 10.0,
                      ),
                      child: Text('اعمالي',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                
                if (cubit.worker![0].pastWorkImages== null || cubit.worker![0].pastWorkImages!.isEmpty)
                     const Center(
                        child: Text(
                          "لا يوجد",
                          style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ))
                    
                else Padding(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                      ),
                      child: Container(
                        height: 85.0,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder:(context, index)=> workImages(image: cubit.worker![0].pastWorkImages![index],),
                          separatorBuilder:(context, index)=> const SizedBox(width: 8.0) ,
                          itemCount: cubit.worker![0].pastWorkImages!.length,
                    ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 7.0,
              ),
          Container(
            color: Colors.white,
            height: 130.0,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children:   [
                const Padding(
                  padding: EdgeInsets.only(
                    right: 10.0,
                  ),
                  child: Text('التقييمات و التعليقات',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                if (cubit.worker![0].review== null || cubit.worker![0].review!.isEmpty)
                     const Center(
                        child: Text(
                          "لا يوجد",
                          style: TextStyle(
                            color: Colors.grey,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ))
                    
                else if(state is getWorkerSuccessState) Expanded(
                  child: MediaQuery.removePadding(
                    removeTop:true ,
                    context: context,
                    child: ListView.separated(
                      itemBuilder:(context, index)=> ratingItem(review: cubit.worker![0].review![index],),
                      separatorBuilder:(context, index)=> const Divider(height: 15) ,
                      itemCount: cubit.worker![0].review!.length,
                    ),
                  ),
                ),

              ],
            ),
          ),
              const SizedBox(
                height: 7.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: FormButton(
                    gradient: LinearGradient(colors: <Color>[
                      const Color(0xffD9AD30),
                      Colors.amber.shade200,
                    ]),
                    onPressed: () {
                      navigateWithBack(context, Request(worker: cubit.worker![0],));
                    },
                    child: const Text(
                      'انشاء طلب',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )),
              )
            ],


          ),
        ),

      ));

  
  },);

  }

  }




