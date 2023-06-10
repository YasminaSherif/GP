import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fortestpages/models/persons.dart';
import 'package:fortestpages/pages/user/settings.dart';


import '../../../bloc/userData/cubit.dart';
import '../../../services/methods/navigation.dart';
import '../Catalogs.dart';
import '../best_workers_of_category.dart';



class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);
  String search='';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<userDataCubit, userDataStates>(
          listener: ( context,state) {
            if(state is getWorkersSuccessState){
            navigateWithBack(context,const BestWorkersOfCategory());
          }
          // if(state is searchSuccessState){
          //   navigateWithBack(context,const BestWorkersOfCategory());
          // }
          // if(state is searchSuccessState){
          //   navigateWithBack(context,const BestWorkersOfCategory());
          // }
          
          if(state is searchFaillState){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text('عذرا هذه الفئه غير متوفره')));
          }
          },
          builder: ( context,  state){
            var cubit=userDataCubit.get(context);
    return Container(
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
                  height: 117.0.h,

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children:  [
                      Padding(
                        padding: EdgeInsets.only(
                          right: 20.0.r,
                        ),
                        child: IconButton(
                          onPressed: () {
                             navigateWithBack(context, const UserProfile());
                          },
                          icon: const Icon(
                            Icons.settings,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 20.0.r,
                  top: 88.0.r,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0).r,
                      color: Colors.grey[350],
                    ) ,
                    width: 320.0.w,
                    height: 90.0.h,
                    child: Row(
                      children:   [
                        Container(
                          width: 152.0.w,
                          color: Colors.transparent,
                          child: Text('الحل الامثل لجميع صيانات منزلك',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0.sp,
                              height: 1.0.h
                            ),
                          ),
                        ),
                         SizedBox(
                          width: 10.0.w,
                        ),

                        Container(
                          width: 158.0.w,
                          height: 85.0.h,
                          color: Colors.transparent,
                          child:  const Image(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/disaster-or-mental-health-crisis.png',
                            ),
                          ),
                        ),

                        ]
                    ),
                  ),
                ),
              ],
            ),
            
           Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0.r,
              ),
              child: Container(
                  width: double.infinity,
                  height: 50.h,
                margin: EdgeInsets.only(
                  top: 66.0.r,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0).r,
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: TextField(
                    onChanged: (val){
                      search=val;
                    },
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                        hintText: 'البحث',
                        icon: IconButton(icon: const Icon(Icons.search),
                        onPressed: () { 
                          cubit.search(search);
                         },
                         ),
                        hintStyle: const TextStyle(color: Colors.black45),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                         EdgeInsets.symmetric(vertical: 2.r, horizontal: 10.r),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5).r
                        )
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                     Padding(
                      padding: EdgeInsets.only(
                        top: 5.0.r,
                        right: 20.0.r,
                      ),
                      child: Text('فئاتنا الرئيسية',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20.0.sp,
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(onPressed: (){
                          cubit.getWorkers(1);
                          
                        },
                          child: Stack(
                            children: [
                              Container(
                                width: 120.0.w,
                                height: 110.0.h,
                                color: const Color.fromRGBO(104, 140, 40, 1),
                              ),

                               Positioned(
                                left: 70.0.r,
                                child: Text('نجار',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19.0.sp,
                                  ),
                                ),
                              ),
                              
                              Positioned(
                                top: 40.0.r,
                                child: Container(
                                  width: 60.0.w,
                                  height: 80.0.h,
                                  color: Colors.transparent,
                                  child:  const Image(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/ficraft__22_-removebg-preview.png',
                                    ),
                                  ),
                                ),
                              ),
                              


                            ],
                          ),
                        ),

                        MaterialButton(onPressed: (){
                           cubit.getWorkers(3);
                        },
                          child: Stack(
                            children: [
                              Container(
                                width: 120.0.w,
                                height: 110.0.h,
                                color: Colors.yellow,
                              ),

                               Positioned(
                                left: 45.0.r,
                                child: Text('كهربائي',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19.0.sp,
                                  ),
                                ),
                              ),

                              Positioned(
                                top: 30.0.r,
                                child: Container(
                                  width: 60.0.w,
                                  height: 80.0.h,
                                  color: Colors.transparent,
                                  child:  const Image(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/ficraft__40_-removebg-preview.png',
                                    ),
                                  ),
                                ),
                              ),



                            ],
                          ),
                        ),
                      ],
                    ),

                     SizedBox(
                      height: 10.0.h,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(onPressed: (){
                           cubit.getWorkers(2);
                        },
                          child: Stack(
                            children: [
                              Container(
                                width: 120.0.w,
                                height: 110.0.h,
                                color: const Color.fromRGBO(47, 52, 76, 1),
                              ),

                               Positioned(
                                left: 65.0.r,
                                child: Text('حداد',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19.0.sp,
                                  ),
                                ),
                              ),

                              Positioned(
                                top: 35.0.r,
                                child: Container(
                                  width: 70.0.w,
                                  height: 90.0.h,
                                  color: Colors.transparent,
                                  child:  const Image(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/ficraft__26_-removebg-preview (1).png',
                                    ),
                                  ),
                                ),
                              ),



                            ],
                          ),
                        ),

                        MaterialButton(onPressed: (){
                           cubit.getWorkers(5);
                        },
                          child: Stack(
                            children: [
                              Container(
                                width: 120.0.w,
                                height: 110.0.h,
                                color: const Color.fromRGBO(50, 135, 140, 1),
                              ),

                               Positioned(
                                left: 65.0.r,
                                child: Text('سباك',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19.0.sp,
                                  ),
                                ),
                              ),

                              Positioned(
                                top: 37.0.r,
                                child: Container(
                                  width: 70.0.w,
                                  height: 90.0.h,
                                  color: Colors.transparent,
                                  child:  const Image(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/ficraft__36_-removebg-preview.png',
                                    ),
                                  ),
                                ),
                              ),



                            ],
                          ),
                        ),
                      ],
                    ),


                     SizedBox(
                      height: 10.0.h,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(onPressed: (){
                           cubit.getWorkers(4);
                        },
                          child: Stack(
                            children: [
                              Container(
                                width: 120.0.w,
                                height: 110.0.h,
                                color: const Color.fromRGBO(140, 131, 50, 1),
                              ),

                               Positioned(
                                left: 65.0.r,
                                child: const Text('تعقيم',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19.0,
                                  ),
                                ),
                              ),

                              Positioned(
                                right: 50,
                                top: 50.0.r,
                                child: Container(
                                  width: 70.0.w,
                                  height: 90.0.h,
                                  color: Colors.transparent,
                                  child:  const Image(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/ficraft__38_-removebg-preview.png',
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),


                      ],
                    ),

                    Center(
                      child: TextButton(onPressed: (){
                        navigateWithBack(context, Catalogs());
                      },
                          child: const Text('المزيد من الفئات',
                            style: TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                          )
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],


        ),

      );
          },
    );

  }
}
