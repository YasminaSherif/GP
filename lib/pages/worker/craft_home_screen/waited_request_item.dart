import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortestpages/bloc/workerData/cubit.dart';

import '../../../models/request.dart';

class WaitedRequestItem extends StatefulWidget {
  final requests request;

  const WaitedRequestItem({Key? key, required this.request}) : super(key: key);

  @override
  State<WaitedRequestItem> createState() => _State();
}

class _State extends State<WaitedRequestItem> {
  bool detailsIsOpened = false;
  @override
  Widget build(BuildContext context) {
   
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            color: Colors.white,
            height: 96,
            child: Row(
              children: [
                const SizedBox(
                  width: 10.0,
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Row(
                        children: [
                          IconButton(
                              icon: const Icon(
                                Icons.check,
                                size: 26,
                                color: Colors.green,
                              ),
                              onPressed: () {
                                var cubit = BlocProvider.of<workerDataCubit>(context);
                                cubit.acceptRequest(widget.request.workerId,widget.request);
                              }),
                          IconButton(
                              icon: const Icon(
                                Icons.close,
                                size: 26,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                 var cubit = BlocProvider.of<workerDataCubit>(context);
                                cubit.declineRequest(widget.request.workerId,widget.request.id);
                              }),
                        ],
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
                    ]),
                    
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.request.id.toString()+'#'+'طلب',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 13.0,
                              height: 1),
                        ),
                        
                        Text(widget.request.details,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 10.0,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 30.0,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                          "assets/day9-toolbox-removebg-preview.png"),
                      radius: 30.0,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),


        if (detailsIsOpened)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 50,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children:  [
                          Text(widget.request.user!.name,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                         
                        ],
                      ),

                      Row(
                        children:  [

                          Text(widget.request.user!.location,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          
                        ],
                      ),
                    ],
                  ),

                   Padding(
                    padding: EdgeInsets.only(right: 15),
                    child:  CircleAvatar(
  backgroundColor: Colors.transparent,
  radius: 18.0,
  child: CircleAvatar(
      
    backgroundImage: widget.request.user!.image != null
        ? MemoryImage(base64Decode(widget.request.user!.image!))
        : null,
    radius: 18.0,
    backgroundColor: Colors.grey,
  ),
),
                  ),
                ],
              ),
            ),
          ),
      ],
    );


  }
}