import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../styles/colors/app_colors.dart';
import '../styles/format_date.dart';
import '../styles/texts/app_text_styles.dart';



class SentMessageItem extends StatelessWidget {
  SentMessageItem({Key? key, required this.message, required this.date})
      : super(key: key);
  String message;
  Timestamp date;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.6,
            minWidth: MediaQuery.of(context).size.width * 0.2),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(217, 173, 48, 1).withOpacity(
            .2,
          ),
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(
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
