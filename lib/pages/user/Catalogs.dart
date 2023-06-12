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
          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
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
                      width: 700.w,
                      height: 100.h,
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
                          ])),
                   Positioned(
                    left: 100.r, 
                    right: 100.r,
                    top: 40.r,
                    child: Text('اختر فئات اخرى',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20.sp, fontFamily: 'Tajawal')),
                  ),
                ],
              ),
            
          
         SizedBox(height: 30.h,),
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
                              radius: 34.r,
                              backgroundColor: Colors.red,
                              child: CircleAvatar(

                                radius: 34.r,
                              backgroundImage:
                                  const AssetImage('assets/day9-toolbox-removebg-preview.png'),
                            ),
                            ),
                          ),
                          const SizedBox(height: 8),
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
                             radius: 34.r,
                              backgroundColor: Colors.transparent,
                              child: CircleAvatar(
                                radius: 34.r,
                              backgroundImage:
                                  const AssetImage('assets/day9-toolbox-removebg-preview.png'),
                            ),
                            ),
                          ),
                          const SizedBox(height: 8),
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
                                backgroundColor: const Color.fromRGBO(104, 140, 40, 1),
                                radius: 28.r,
                              backgroundImage:
                                  const AssetImage('assets/ficraft__39_-removebg-preview.png'),
                            ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text('كهربائى',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontFamily: 'Tajawal')),
                        ]),
                  ],
                ),
                const SizedBox(
                  height: 30,
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
                             radius: 34.r,
                              backgroundColor: Colors.transparent,
                              child: CircleAvatar(
                                radius: 34.r,
                              backgroundImage:
                                  const AssetImage('assets/day9-toolbox-removebg-preview.png'),
                            ),
                            ),
                          ),
                          const SizedBox(height: 8),
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
                             radius: 34.r,
                              backgroundColor: Colors.transparent,
                              child: CircleAvatar(
                                radius: 34.r,
                              backgroundImage:
                                  const AssetImage('assets/day9-toolbox-removebg-preview.png'),
                            ),
                            ),
                          ),
                          const SizedBox(height: 8),
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
                              radius: 34.r,
                              backgroundColor: Colors.transparent,
                              child: CircleAvatar(
                                radius: 34.r,
                              backgroundImage:
                                  const AssetImage('assets/day9-toolbox-removebg-preview.png'),
                            ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text('ستائر',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontFamily: 'Tajawal')),
                        ]),
                  ],
                ),
                const SizedBox(
                  height: 30,
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
                                radius: 34.r,
                              backgroundColor: Colors.transparent,
                              child: CircleAvatar(
                                radius: 34.r,
                              backgroundImage:
                                  const AssetImage('assets/day9-toolbox-removebg-preview.png'),
                            ),
                              ),
                            ),
                            const SizedBox(height: 8),
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
                                radius: 34.r,
                              backgroundColor: Colors.transparent,
                              child: CircleAvatar(
                                radius: 34.r,
                              backgroundImage:
                                  const AssetImage('assets/day9-toolbox-removebg-preview.png'),
                            ),
                              ),
                            ),
                            const SizedBox(height: 8),
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
                                radius: 34.r,
                              backgroundColor: Colors.transparent,
                              child: CircleAvatar(
                                radius: 34.r,
                              backgroundImage:
                                  const AssetImage('assets/day9-toolbox-removebg-preview.png'),
                            ),
                              ),
                            ),
                            const SizedBox(height: 8),
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
