import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fortestpages/models/loginDataResponse.dart';
import 'package:fortestpages/models/reviews.dart';

class ratingItem extends StatelessWidget {
   ratingItem({super.key,required this.review});
reviews review;
  @override
  Widget build(BuildContext context) {
    return Padding(
         padding: const EdgeInsets.only(
           right: 10.0,
         ),
         child: Row(
            children:  [
              const Icon(Icons.star_rate,
                color: Colors.amber,
                size:20.0 ,
              ),
               Text(review.rateOfthisWork.toString(),
                style: TextStyle(
                  height: 1.0,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                width: 40.0,
              ),
              Expanded(
                child: Container(
                  height: 33.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.grey[350],
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children:  [
                      Text(review.user!.firstName+" "+review.user!.lastName,
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 12.0,
                        ),
                      ),
                      Text(review.details,
                        style: TextStyle(
                          color: Colors.black,
                          height: 0.7,
                          fontSize: 8.0,
                          fontWeight: FontWeight.w700,

                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 7,
              ),
              CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 19.0,
            child: CircleAvatar(
              backgroundImage: MemoryImage(review.user!.image != null
                  ? base64Decode(review.user!.image!)
                  : Uint8List(0)),
              radius: 19.0,
              backgroundColor: Colors.grey,
            ),
          ),
            ],
      ),
  );}
}