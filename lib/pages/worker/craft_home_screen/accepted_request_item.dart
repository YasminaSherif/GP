import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortestpages/bloc/workerData/cubit.dart';
import '../../../models/request.dart';
import '../../../services/methods/navigation.dart';
import '../../chat/messages_screen_Worker.dart';

class AcceptedRequestItem extends StatefulWidget {
  
   AcceptedRequestItem ({Key? key,required this.request}) : super(key: key);
requests request;
  @override
  State<AcceptedRequestItem> createState() => _State();
}

class _State extends State<AcceptedRequestItem> {
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      const Text(
                        'تم القبول',
                        style: TextStyle(
                          color: Colors.green,
                            fontWeight: FontWeight.w900,
                            fontSize: 16.0,

                        ),
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
                      children:  [
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

                children: [
                  const SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(icon:  Icon(Icons.chat),
                      
                      onPressed: () { 
                        var cubit = BlocProvider.of<workerDataCubit>(context);
                        navigateWithBack(context, MessagesScreen(
                receiverId: widget.request.customerId,
                receiverName: widget.request.user!.name,
                worker:cubit.workerResponse![0],
              ));
                       },
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        Text(widget.request.user!.name,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(widget.request.user!.location,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                   Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 32.0,
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
),)
                  ),
                ],
              ),
            ),
          ),
      ],
    );


  }
}