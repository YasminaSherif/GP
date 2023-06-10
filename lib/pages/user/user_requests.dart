

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


//import '../../bloc/userData/cubit.dart';
import '../../bloc/userData/cubit.dart';
import 'order_item.dart';

class UserRequests extends StatelessWidget {
  const UserRequests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
 return BlocConsumer<userDataCubit, userDataStates>(
          listener: ( context, state) {},
          builder: ( context, state){
        var cubit=userDataCubit.get(context);
        
      return  Scaffold(
      
      body: Container(
        color: Colors.grey[250],
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  clipBehavior: Clip.none,
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
                                  )
                              ),
                            ]
                        )
                    ),

                  ],
                ),
                Container(
                  height: 170.0.h,
                  width: double.infinity,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children:    [
                         Padding(
                          padding: EdgeInsets.only(
                            right: 20.0.r,
                            top: 8.r,                           
                          ),
                          child: Text('الطلبات المنتظره',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18.0.sp,
                              fontFamily: 'Tajawal',
                            
                            ),
                          ),
                        ),

                        (state is getRequestLoadingsState || state is getWorkerDataForRequestLoadingsState || state is getWorkerDataForRequestSuccessState)
                ? const Center(child: CircularProgressIndicator(color: Color(0xffD9AD30),))
            :  (cubit.panding!=null && cubit.panding!.isNotEmpty)
                   ? 
                        Expanded(
                          child: ListView.separated(
                            itemBuilder:(context, index)=> PandingOrderItem(request: cubit.panding![index],),
                            separatorBuilder:(context, index)=>  SizedBox(height: 11.h) ,
                            itemCount: cubit.panding!.length,
                            
                          ),
                        )
                        : Padding(
                          padding:  EdgeInsets.only(top: 40.r),
                          child: Center(                       
                          child: Text(
                            "لا يوجد طلبات في هذه الفئه",
                            style: TextStyle(
                                          height: 1.0.h,
                                          fontSize: 12.0.sp,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Tajawal',
                                               ),
                          )
                          
                          ),
                        )
                      ]
                  ),
                ),

                 SizedBox(
                  height: 12.0.h,
                ),

                Container(
                  height: 170.0.h,
                  width: double.infinity,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children:   [
                         Padding(
                          padding: EdgeInsets.only(
                            right: 10.0.r,
                          ),
                          child: Text('الطلبات الجاريه',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18.0.sp,
                               fontFamily: 'Tajawal',
                            ),
                          ),
                        ),
                        (state is getRequestLoadingsState || state is getWorkerDataForRequestLoadingsState || state is getWorkerDataForRequestSuccessState)
                ? const Center(child: CircularProgressIndicator(color: Color(0xffD9AD30),))
            :  ( cubit.accepted!=null && cubit.accepted!.isNotEmpty)
                       ? Expanded(
                          child: ListView.separated(
                            itemBuilder:(context, index)=> RejectedOrderItem(request: cubit.accepted![index],),
                            separatorBuilder:(context, index)=> SizedBox(height: 11.h) ,
                            itemCount: cubit.accepted!.length,
                          ),
                        )
                        : Padding(
                          padding:  EdgeInsets.only(top: 40.r),
                          child: Center(                       
                          child: Text(
                            "لا يوجد طلبات في هذه الفئه",
                            style: TextStyle(
                                          height: 1.0.h,
                                          fontSize: 12.0.sp,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Tajawal',
                                               ),
                          )
                          
                          ),
                        )
                      ]
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  });
  }


}
