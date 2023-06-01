import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fortestpages/bloc/userData/cubit.dart';
import 'package:fortestpages/models/request.dart';
import 'package:fortestpages/services/methods/navigation.dart';

import '../../bloc/workerData/cubit.dart';
import 'Rating.dart';
import 'craft_profile/craft_profile.dart';

class OrderItem extends StatefulWidget {
   OrderItem({Key? key,required this.request}) : super(key: key);
  requests request;
  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool detailsIsOpened = false;
  @override
  Widget build(BuildContext context) {
      var cubit=userDataCubit();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Slidable(
            startActionPane: ActionPane(
                   motion: const BehindMotion(),
                   children: [
                     SlidableAction(
                       icon: Icons.delete,
                       backgroundColor: Colors.red,
                       onPressed: (BuildContext context) {
                         var cubit = BlocProvider.of<userDataCubit>(context);
                               
                        cubit.deleteRequest(widget.request.customerId,widget.request);
                       },

                     ),
                   ],
                 ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 45.0,
              color: Colors.white,
              child: Row(
                children: [
                  const SizedBox(
                    width: 10.0,
                  ),
                  IconButton(
                    icon: Icon(
                      detailsIsOpened
                          ? Icons.arrow_drop_up
                          : Icons.arrow_drop_down,
                      size: 30,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        detailsIsOpened = !detailsIsOpened;
                      });
                      print(detailsIsOpened);
                    },
                  ),
                  const Spacer(),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          Text(
                             widget.request.id.toString()+'#'+'طلب',
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 13.0,
                                height: 1),
                          ),
                          // Text(
                          //   'تم الطلب في 10 اكتوبر 2019',
                          //   textAlign: TextAlign.end,
                          //   style: TextStyle(
                          //       color: Colors.grey,
                          //       fontSize: 8.0,
                          //       fontWeight: FontWeight.w700,
                          //       height: 1.1),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 26.0,
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                            "assets/day9-toolbox-removebg-preview.png"),
                        radius: 26.0,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (detailsIsOpened)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: 65.0,
            color: Colors.white,
            child: Row(
              children:  [
                const SizedBox(
                  width: 10.0,
                ),

                   GestureDetector(
                     onTap: (){
                      navigateWithBack(context, Rating(worker: widget.request.worker!,));
                     },
                     child: Row(
                       children: const[
                          Icon(
                          Icons.arrow_left_sharp,
                          size: 22,
                         ),

                         Text('الانتقال لتقييمه',
                           style: TextStyle(
                               fontSize: 10.0,
                               height: 1.1,
                               fontWeight: FontWeight.bold
                           ),
                         ),

                       ],
                     ),
                   ),
                const Spacer(),

                Expanded(
                  child: Container(

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:   [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:  [
                            Icon(Icons.star_rate,
                              color: Colors.amber,
                              size:18.0 ,
                            ),
                            Text(widget.request.worker!.rating.toString(),
                              style: TextStyle(
                                height: 1.0,
                                fontSize: 11.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            SizedBox(
                              width: 2.0,
                            ),
                            Text(widget.request.worker!.firstName+" "+widget.request.worker!.lastName,
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 11.0,
                                height: 1,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),


                        const Text('الطلب',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 11.0,
                            height: 1,
                          ),
                        ),


                         Text(widget.request.details,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 8.0,
                            height: 0.8,
                          ),
                        ),


                      ],
                    ),
                  ),
                ),
                
                 GestureDetector(
                  onTap: () {

                   // navigateWithBack(context, CraftProfile(workerid: widget.request.workerId,));
                  },
                   child: Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 26.0,
                      child: CircleAvatar(
  backgroundColor: Colors.transparent,
  radius: 20.0,
  child: CircleAvatar(
      
    backgroundImage: widget.request.worker!.image != null
        ? MemoryImage(base64Decode(widget.request.worker!.image!))
        : null,
    radius: 20.0,
    backgroundColor: Colors.grey,
  ),
),
                    ),
                                 ),
                 ),
      ],
    ),
                ),
                ),
    ]
    );
  }
}
