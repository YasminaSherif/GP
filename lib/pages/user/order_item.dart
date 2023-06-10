import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fortestpages/bloc/userData/cubit.dart';
import 'package:fortestpages/models/request.dart';
import 'package:fortestpages/services/methods/navigation.dart';

import '../../bloc/workerData/cubit.dart';
import 'Rating.dart';
import 'craft_profile/craft_profile.dart';

class PandingOrderItem extends StatefulWidget {
  PandingOrderItem({Key? key, required this.request}) : super(key: key);
  requests request;
  @override
  _PandingOrderItemState createState() => _PandingOrderItemState();
}

class _PandingOrderItemState extends State<PandingOrderItem > {
  bool detailsIsOpened = false;
  @override
  Widget build(BuildContext context) {
    var cubit = userDataCubit();
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Slidable(
        startActionPane: ActionPane(
          motion: const BehindMotion(),
          children: [
            SlidableAction(
              icon: Icons.delete,
              backgroundColor: Colors.red,
              onPressed: (BuildContext context) {
                var cubit = BlocProvider.of<userDataCubit>(context);

                cubit.deleteRequest(widget.request.customerId, widget.request);
              },
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          child: Container(
            height: 45.0.h,
            color: Colors.white,
            child: Row(
              children: [
                 SizedBox(
                  width: 10.0.w,
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
                              height: 1,
                              fontFamily: 'Tajawal',
                              ),
                        ),
                      
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                 Padding(
                  padding: EdgeInsets.only(right: 15.r),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 26.0.r,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                          "assets/day9-toolbox-removebg-preview.png"),
                      radius: 26.0.r,
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
          padding: EdgeInsets.symmetric(horizontal: 20.r),
          child: Container(
            height: 65.0.h,
            color: Colors.white,
            child: Row(
              children: [ 
               const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0).r,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.star_rate,
                            color: Colors.amber,
                            size: 18.0,
                          ),
                          Text(
                            widget.request.worker!.rating.toString(),
                            style: TextStyle(
                              height: 1.0.h,
                              fontSize: 11.0.sp,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Tajawal',
                            ),
                          ),
                           SizedBox(
                            width: 5.0.w,
                          ),
                          Text(
                            widget.request.worker!.firstName +
                                " " +
                                widget.request.worker!.lastName,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 11.0.sp,
                              height: 1.h,
                              fontFamily: 'Tajawal',
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                       Text(
                        'الطلب',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 11.0.sp,
                          height: 1.h,
                          fontFamily: 'Tajawal',
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                width: 200.w,
                                child: Text(
                                  widget.request.details,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 10.0.sp,
                                    height: 0.8.h,
                                    fontFamily: 'Tajawal',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
                      radius: 26.0.r,
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 20.0.r,
                        child: CircleAvatar(
                          backgroundImage: widget.request.worker!.image != null
                              ? MemoryImage(
                                  base64Decode(widget.request.worker!.image!))
                              : null,
                          radius: 20.0.r,
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
    ]);
  }
}




class DoneOrderItem extends StatefulWidget {
  DoneOrderItem({Key? key, required this.request}) : super(key: key);
  requests request;
  @override
  State<DoneOrderItem> createState() => _DoneOrderItemState();
}

class _DoneOrderItemState extends State<DoneOrderItem> {
  bool detailsIsOpened = false;
  @override
  Widget build(BuildContext context) {
    var cubit = userDataCubit();
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: 45.0.h,
          color: Colors.white,
          child: Row(
            children: [
               SizedBox(
                width: 10.0.w,
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
                            height: 1.h,
                            fontFamily: 'Tajawal',
                            ),
                      ),
                    ],
                  ),
                ),
              ),
               SizedBox(
                width: 2.w,
              ),
               Padding(
                padding: EdgeInsets.only(right: 15.r),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 26.0.r,
                  child: CircleAvatar(
                    backgroundImage: const AssetImage(
                        "assets/day9-toolbox-removebg-preview.png"),
                    radius: 26.0.r,
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
            height: 65.0.h,
            color: Colors.white,
            child: Row(
              children: [
                 SizedBox(
                  width: 10.0.w,
                ),
                GestureDetector(
                  onTap: () {
                    navigateWithBack(
                        context,
                        Rating(
                          worker: widget.request.worker!,
                        ));
                  },
                  child: Row(
                    children:  [
                      const Icon(
                        Icons.arrow_left_sharp,
                        size: 22,
                      ),
                      Text(
                        'الانتقال لتقييمه',
                        style: TextStyle(
                            fontSize: 10.0.sp,
                            height: 1.1.h,
                            fontFamily: 'Tajawal',
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0).r,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.star_rate,
                              color: Colors.amber,
                              size: 18.0,
                            ),
                            Text(
                              widget.request.worker!.rating.toString(),
                              style: TextStyle(
                                height: 1.0.h,
                                fontSize: 11.0.sp,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Tajawal',
                              ),
                            ),
                            SizedBox(
                              width: 2.0.w,
                            ),
                            Text(
                              widget.request.worker!.firstName +
                                  " " +
                                  widget.request.worker!.lastName,
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 11.0.sp,
                                height: 1.h,
                                fontFamily: 'Tajawal',
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                         Text(
                          'الطلب',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 11.0.sp,
                            height: 1.h,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                        Text(
                          widget.request.details,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 10.0.sp,
                            height: 0.8.h,
                            fontFamily: 'Tajawal',
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
                    padding: EdgeInsets.only(right: 15.r),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 26.0.r,
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 20.0.r,
                        child: CircleAvatar(
                          backgroundImage: widget.request.worker!.image != null
                              ? MemoryImage(
                                  base64Decode(widget.request.worker!.image!))
                              : null,
                          radius: 20.0.r,
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
    ]);
  }
}







class RejectedOrderItem extends StatefulWidget {
  RejectedOrderItem({Key? key, required this.request}) : super(key: key);
  requests request;
  @override
  State<RejectedOrderItem> createState() => _RejectedOrderItemState();
}

class _RejectedOrderItemState extends State<RejectedOrderItem> {
  bool detailsIsOpened = false;
  @override
  Widget build(BuildContext context) {
    var cubit = userDataCubit();
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: 45.0.h,
          color: Colors.white,
          child: Row(
            children: [
               SizedBox(
                width: 10.0.w,
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
                            height: 1.h,
                            fontFamily: 'Tajawal',
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 2,
              ),
               Padding(
                padding: EdgeInsets.only(right: 15.r),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 26.0.r,
                  child: CircleAvatar(
                    backgroundImage: const AssetImage(
                        "assets/day9-toolbox-removebg-preview.png"),
                    radius: 26.0.r,
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
            height: 65.0.h,
            color: Colors.white,
            child: Row(
              children: [
                const Spacer(),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0).r,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.star_rate,
                              color: Colors.amber,
                              size: 18.0,
                            ),
                            Text(
                              widget.request.worker!.rating.toString(),
                              style: TextStyle(
                                height: 1.0.h,
                                fontSize: 11.0.sp,
                                fontFamily: 'Tajawal',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              width: 2.0.w,
                            ),
                            Text(
                              widget.request.worker!.firstName +
                                  " " +
                                  widget.request.worker!.lastName,
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 11.0.sp,
                                height: 1.h,
                                fontFamily: 'Tajawal',
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                         Text(
                          'الطلب',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 11.0.sp,
                            height: 1.h,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                        Text(
                          widget.request.details,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 10.0.sp,
                            height: 0.8.h,
                            fontFamily: 'Tajawal',
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
                      radius: 26.0.r,
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 20.0.r,
                        child: CircleAvatar(
                          backgroundImage: widget.request.worker!.image != null
                              ? MemoryImage(
                                  base64Decode(widget.request.worker!.image!))
                              : null,
                          radius: 20.0.r,
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
    ]);
  }
}
