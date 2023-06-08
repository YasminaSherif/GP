import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fortestpages/bloc/workerData/cubit.dart';

import '../../../models/request.dart';

class WaitedRequestItem extends StatefulWidget {
  WaitedRequestItem({Key? key, required this.request}) : super(key: key);
  requests request;
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
            height: 96.h,
            child: Row(
              children: [
                SizedBox(
                  width: 10.0.w,
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    children: [
                      IconButton(
                          icon: const Icon(
                            Icons.check,
                            size: 22,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            var cubit =
                                BlocProvider.of<workerDataCubit>(context);
                            cubit.acceptRequest(
                                widget.request.workerId, widget.request);
                          }),
                      IconButton(
                          icon: const Icon(
                            Icons.close,
                            size: 22,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            var cubit =
                                BlocProvider.of<workerDataCubit>(context);
                            cubit.declineRequest(
                                widget.request.workerId, widget.request.id);
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
                      borderRadius: BorderRadius.circular(5.0).r,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.request.id.toString() + '#' + 'طلب',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 13.0.sp,
                              height: 1.h),
                        ),
                        Text(
                          widget.request.details,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 10.0.sp,
                            height: 1.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15).r,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 30.0.r,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                          "assets/day9-toolbox-removebg-preview.png"),
                      radius: 30.0.r,
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
            padding: EdgeInsets.symmetric(horizontal: 20.r),
            child: Container(
              height: 55.h,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.request.user!.name,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          widget.request.user!.location,
                          style: TextStyle(
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 15.r),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 22.0.r,
                      child: CircleAvatar(
                        backgroundImage: widget.request.user!.image != null
                            ? MemoryImage(
                                base64Decode(widget.request.user!.image!))
                            : null,
                        radius: 22.0.r,
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
