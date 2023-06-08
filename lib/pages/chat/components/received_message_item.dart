import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/format_date.dart';
import '../styles/texts/app_text_styles.dart';



class ReceivedMessageItem extends StatelessWidget {
  ReceivedMessageItem(
      {Key? key, required this.message, required this.date, this.senderName})
      : super(key: key);
  String? senderName;
  String message;
  Timestamp date;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.6,
            minWidth: MediaQuery.of(context).size.width * 0.20),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(
              15.r,
            ),
            topStart: Radius.circular(
              15.r,
            ),
            topEnd: Radius.circular(
              15.r,
            ),
          ),
        ),
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 3),
        margin: EdgeInsets.only(bottom: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (senderName != null)
              Text(
                senderName!,
                style: AppTextStyle.title().copyWith(height: 0.9),
              ),
            Text(
              message,
            ),
            Text(
              formatDate(date.toDate().toString()),
              style: AppTextStyle.subTitle().copyWith(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
