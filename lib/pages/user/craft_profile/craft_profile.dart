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
import '../../../models/persons.dart';
import '../Send_Request.dart';

class CraftProfile extends StatelessWidget {
  CraftProfile({Key? key, workerid}) : super(key: key);
  // workerData worker;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<userDataCubit, userDataStates>(
      listener: (context, state) {},
      builder: (context, state) {
        late double _minTextAdapt = 0.0;
        var cubit = userDataCubit.get(context);

        return Scaffold(
            body: (cubit.worker == null)
                ? const Center(child: CircularProgressIndicator(color:Color.fromRGBO(217, 173, 48, 1), ))
                : Container(
                    color: Colors.grey[250],
                    child: Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3.0).w,
                                color: const Color.fromRGBO(217, 173, 48, 1),
                              ),
                              height: 117.0.h,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back_sharp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              left: 140.0.r,
                              top: 85.0.r,
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: 35.0.r,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      radius: 35.0.r,
                                      child: CircleAvatar(
                                        backgroundImage:
                                            cubit.worker![0].image != null
                                                ? MemoryImage(base64Decode(
                                                    cubit.worker![0].image!))
                                                : null,
                                        radius: 35.0.r,
                                        backgroundColor: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    cubit.worker![0].firstName +
                                        " " +
                                        cubit.worker![0].lastName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Text(
                                    cubit.worker![0].cate!.name!,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      height: 0.8.h,
                                      fontSize: 12.0.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.star_rate,
                                        color: Colors.amber,
                                        size: 20.0,
                                      ),
                                      Text(
                                        cubit.worker![0].rating.toString(),
                                        style: TextStyle(
                                          height: 1.0.h,
                                          fontSize: 12.0.sp,
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
                         SizedBox(height: 100.h,),
                        Expanded(                        
                          child: Container(
                            width: double.infinity,                          
                            color: Colors.white,                         
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 65.0.r,
                                right: 10.0.r,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                   Text(
                                    'عني',
                                    style: TextStyle(
                                      fontSize: 17.0.sp,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Text(
                                            cubit.worker![0].bio ??
                                                "لم يتم اضافة تفاصيل بعد",
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              height: 1.1.h,
                                              fontSize: 12.sp,
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
                        ),
                        SizedBox(
                          height: 7.0.h,
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.white,                            
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: 10.0.r,
                                  ),
                                  child: Text(
                                    'اعمالي',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16.0.sp,
                                    ),
                                  ),
                                ),
                                if (cubit.worker![0].pastWorkImages == null ||
                                    cubit.worker![0].pastWorkImages!.isEmpty)
                                  Center(
                                      child: Text(
                                    "لا يوجد",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16.0.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ))
                                else
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 15.0.r,
                                    ),
                                    child: Center(
                                      child: Container(
                                        height: 65.0.h,
                                        child: ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) =>
                                              workImages(
                                            image: cubit.worker![0]
                                                .pastWorkImages![index],
                                          ),
                                          separatorBuilder: (context, index) =>
                                               SizedBox(width: 8.0.w),
                                          itemCount: cubit
                                              .worker![0].pastWorkImages!.length,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 7.0.h,
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.white,                           
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    right: 10.0.r,
                                  ),
                                  child: Text(
                                    'التقييمات و التعليقات',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16.0.sp,
                                    ),
                                  ),
                                ),
                                if (cubit.worker![0].review == null ||
                                    cubit.worker![0].review!.isEmpty)
                                  Center(
                                      child: Text(
                                    "لا يوجد",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16.0.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ))
                                else if (state is getWorkerSuccessState)
                                  Expanded(
                                    child: MediaQuery.removePadding(
                                      removeTop: true,
                                      context: context,
                                      child: ListView.separated(
                                        itemBuilder: (context, index) =>
                                            ratingItem(
                                          review:
                                              cubit.worker![0].review![index],
                                        ),
                                        separatorBuilder: (context, index) =>
                                             Divider(height: 15.h),
                                        itemCount:
                                            cubit.worker![0].review!.length,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 7.0.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.0.r,
                          ),
                          child: FormButton(                             
                              gradient: LinearGradient(colors: <Color>[
                                const Color(0xffD9AD30),
                                Colors.amber.shade200,
                              ]),
                              onPressed: () {
                                navigateWithBack(
                                    context,
                                    Request(
                                      worker: cubit.worker![0],
                                    ));
                              },
                              child: const Text(
                                'انشاء طلب',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              )),
                        )
                      ],
                    ),
                  )
                  );
      },
    );
  }
}
