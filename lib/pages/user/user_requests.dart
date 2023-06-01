

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../bloc/mainUser/cubit.dart';
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
        color: Colors.grey[300],
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
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
                Container(
                  height: 170.0,
                  width: double.infinity,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children:    [
                        const Padding(
                          padding: EdgeInsets.only(
                            right: 20.0,
                            

                          ),
                          child: Text('الطلبات الجاريه',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 20.0,
                            ),
                          ),
                        ),

                        (state is getRequestLoadingsState || cubit.panding==null)
                ? const Center(child: CircularProgressIndicator())
            :  (cubit.panding!.isNotEmpty)
                   ? 
                        Expanded(
                          child: ListView.separated(
                            itemBuilder:(context, index)=> OrderItem(request: cubit.panding![index],),
                            separatorBuilder:(context, index)=> const SizedBox(height: 11) ,
                            itemCount: cubit.panding!.length,
                            
                          ),
                        )
                        :const Center(
                        child: Text(
                          "لا يوجد طلبات في هذه الفئه",
                          style: TextStyle(
                  height: 1.0,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                       ),
                        ))
                        

                      ]
                  ),
                ),

                const SizedBox(
                  height: 7.0,
                ),

                Container(
                  height: 170.0,
                  width: double.infinity,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children:   [
                        const Padding(
                          padding: EdgeInsets.only(
                            right: 10.0,
                          ),
                          child: Text('الطلبات السابقه',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        (state is getRequestLoadingsState || cubit.accepted==null)
                ? const Center(child: CircularProgressIndicator())
            :  (cubit.accepted!.isNotEmpty)
                   
                       ? Expanded(
                          child: ListView.separated(
                            itemBuilder:(context, index)=> OrderItem(request: cubit.accepted![index],),
                            separatorBuilder:(context, index)=> const SizedBox(height: 11) ,
                            itemCount: cubit.accepted!.length,
                          ),
                        )
                        :const Center(
                        child: Text(
                          "لا يوجد طلبات في هذه الفئه",
                          style: TextStyle(
                  height: 1.0,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                       ),
                        ))
                      ]
                  ),
                ),

                const SizedBox(
                  height: 7.0,
                ),

                Container(
                  height: 170.0,
                  width: double.infinity,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children:   [
                        const Padding(
                          padding: EdgeInsets.only(
                            right: 10.0,
                          ),
                          child: Text('الطلبات المرفوضه',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 20.0,
                            ),
                          ),
                        ),(state is getRequestLoadingsState || cubit.declined==null)
                ? const Center(child: CircularProgressIndicator())
            :  (cubit.declined!.isNotEmpty)
                   ? 
                        Expanded(
                          child: ListView.separated(
                            itemBuilder:(context, index)=> OrderItem(request: cubit.declined![index],),
                            separatorBuilder:(context, index)=> const SizedBox(height: 11) ,
                            itemCount: cubit.declined!.length,
                          ),
                          
                        )
                       : const Center(
                        child: Text(
                          "لا يوجد طلبات في هذه الفئه",
                          style: TextStyle(
                  height: 1.0,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                       ),
                        ))
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
