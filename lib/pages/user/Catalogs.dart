import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../bloc/userData/cubit.dart';
import '../../services/methods/navigation.dart';
import 'best_workers_of_category.dart';

class Catalogs extends StatelessWidget {
  // var myInitialItem = 'your Location';
  // List<String> myItems= ['Cairo', 'Alex', 'Maddi', 'Giza', 'Aswan'];

  String? value;
  final items = ['Cairo', 'Alex', 'Maddi', 'Giza', 'Aswan'];

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15.sp),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<userDataCubit, userDataStates>(
      listener: (context, state) {
        if (state is getWorkerSuccessState) {
          navigateWithBack(context, const BestWorkersOfCategory());
        }
      },
      builder: (context, state) {
        var cubit = userDataCubit.get(context);
        return Scaffold(
            body: Container(child:
          Column(
            children: [
              Stack(
                children: [
                  Container(
                      
                      height: 117.h,
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
                                )),
                          ]
                          )
                          ),
                ],
              ),
            
          
         SizedBox(height: 20.h,),
               Column(
                children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              cubit.getWorkers(1);
                            },
                            child: CircleAvatar(
                              radius: 28.r, 
                              child: CircleAvatar(
                                radius: 28.r,
                              backgroundColor: const Color.fromRGBO(104, 140, 40, 1),
                              backgroundImage:
                                  const AssetImage('assets/ficraft39.png'),
                            ),
                            ),
                          ),
                           SizedBox(height: 8.h),
                          const Text('نجار',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontFamily: 'Tajawal')),
                        ]),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              cubit.getWorkers(5);
                            },
                            child: CircleAvatar(
                             radius: 28.r,
                              child: CircleAvatar(
                                radius: 28.r,
                                backgroundColor: const Color.fromRGBO(104, 140, 40, 1),
                              backgroundImage:
                                  const AssetImage('assets/ficraft40.png'),
                            ),
                            ),
                          ),
                           SizedBox(height: 8.h),
                          const Text('سباك',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontFamily: 'Tajawal')),
                        ]),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              cubit.getWorkers(3);
                            },
                            child:  CircleAvatar(
                              radius: 28.r,
                              child: CircleAvatar(
                                radius: 28.r,
                                backgroundColor: const Color.fromRGBO(104, 140, 40, 1),
                              backgroundImage:
                                  const AssetImage('assets/ficraft41.png'),
                            ),
                            ),
                          ),
                           SizedBox(height: 8.h),
                          const Text('كهربائى',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontFamily: 'Tajawal')),
                        ]),
                  ],
                ),
                 SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              cubit.getWorkers(6);
                            },
                            child: CircleAvatar(
                             radius: 28.r,
                              backgroundColor: Colors.transparent,
                              child:  CircleAvatar(
                                radius: 28.r,
                                backgroundColor: const Color.fromRGBO(104, 140, 40, 1),
                              backgroundImage:
                                  const AssetImage('assets/ficraft42.png'),
                            ),
                            ),
                          ),
                           SizedBox(height: 8.h),
                          const Text('نقاش',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontFamily: 'Tajawal')),
                        ]),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              cubit.getWorkers(4);
                            },
                            child: CircleAvatar(
                             radius: 28.r,
                              backgroundColor: Colors.transparent,
                              child: CircleAvatar(
                                radius: 28.r,
                                 backgroundColor: const Color.fromRGBO(104, 140, 40, 1),
                              backgroundImage:
                                  const AssetImage('assets/ficraft43.png'),
                            ),
                            ),
                          ),
                           SizedBox(height: 8.h),
                          const Text('تعقيم و نظافة',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontFamily: 'Tajawal')),
                        ]),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              cubit.getWorkers(9);
                            },
                            child: CircleAvatar(
                              radius: 28.r,
                              backgroundColor: Colors.transparent,
                              child: CircleAvatar(
                                radius: 28.r,
                             backgroundColor: const Color.fromRGBO(104, 140, 40, 1),
                              backgroundImage:
                                  const AssetImage('assets/ficraft44.png'),
                            ),
                            ),
                          ),
                           SizedBox(height: 8.h),
                          const Text('ستائر',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontFamily: 'Tajawal')),
                        ]),
                  ],
                ),
                 SizedBox(
                  height: 30.h,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                cubit.getWorkers(2);
                              },
                              child: CircleAvatar(
                                radius: 28.r,
                              backgroundColor: Colors.transparent,
                              child: CircleAvatar(
                                radius: 28.r,
                                backgroundColor: const Color.fromRGBO(104, 140, 40, 1),
                              backgroundImage:
                                  const AssetImage('assets/ficraft45.png'),
                            ),
                              ),
                            ),
                             SizedBox(height: 8.h),
                            const Text('حداد',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontFamily: 'Tajawal')),
                          ]),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                cubit.getWorkers(7);
                              },
                              child: CircleAvatar(
                                radius: 28.r,
                              backgroundColor: Colors.transparent,
                              child: CircleAvatar(
                                radius: 28.r,
                               backgroundColor: const Color.fromRGBO(104, 140, 40, 1),
                              backgroundImage:
                                  const AssetImage('assets/ficraft46.png'),
                            ),
                              ),
                            ),
                             SizedBox(height: 8.h),
                            const Text('زجاج',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontFamily: 'Tajawal')),
                          ]),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                cubit.getWorkers(8);
                              },
                              child: CircleAvatar(
                                radius: 28.r,
                              backgroundColor: Colors.transparent,
                              child: CircleAvatar(
                                radius: 28.r,
                                backgroundColor:const Color.fromRGBO(104, 140, 40, 1),
                              backgroundImage:
                                  const AssetImage('assets/ficraft47.png'),
                            ),
                              ),
                            ),
                             SizedBox(height: 8.h),
                            const Text('محارة',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontFamily: 'Tajawal')),
                          ]),
                    ]),
              ])
              ])
            )
        );
      },
    );
  }
}
