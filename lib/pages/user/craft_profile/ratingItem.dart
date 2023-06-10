import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fortestpages/models/persons.dart';
import 'package:fortestpages/models/reviews.dart';

class ratingItem extends StatelessWidget {
   ratingItem({super.key,required this.review});
reviews review;
  @override
  Widget build(BuildContext context) {
    return Padding(
         padding: EdgeInsets.only(
           right: 10.0.r,
         ),
         child: Row(
            children:  [
              const Icon(Icons.star_rate,
                color: Colors.amber,
                size:20.0 ,
              ),
               Text(review.rateOfthisWork.toString(),
                style: TextStyle(
                  height: 1.0.h,
                  fontSize: 12.0.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Tajawal',
                ),
              ),
               SizedBox(
                width: 40.0.w,
              ),
              Expanded(
                child: Container(
                  height: 30.0.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0).r,
                    color: Colors.grey[250],
                  ),
                
                  child: Padding(
                    padding: EdgeInsets.only(right: 5.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children:  [
                        Text(review.user!.firstName+" "+review.user!.lastName,
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 10.0.sp,
                            fontFamily: 'Tajawal',
                          ),
                        ),
                        Text(review.details,
                          style: TextStyle(
                            color: Colors.black,
                            height: 0.6.h,
                            fontSize: 8.0.sp,
                            fontWeight: FontWeight.w700,
                                  
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
               SizedBox(
                width: 7.w,
              ),
              CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 17.0.r,
            child: CircleAvatar(
              backgroundImage: MemoryImage(review.user!.image != null
                  ? base64Decode(review.user!.image!)
                  : Uint8List(0)),
              radius: 17.0.r,
              backgroundColor: Colors.grey,
            ),
          ),
            ],
      ),
  );}
}