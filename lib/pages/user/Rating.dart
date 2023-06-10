import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fortestpages/customized/FormButton.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fortestpages/pages/user/craft_profile/craft_profile.dart';

import '../../bloc/userData/cubit.dart';
import '../../models/persons.dart';
import '../../services/methods/navigation.dart';

class Rating extends StatelessWidget {
  Rating({Key? key, required this.workerId}) : super(key: key);
  String workerId;
  String feedback = '';
  @override
  double rating = 0.0;
  Widget build(BuildContext context) {
    return BlocConsumer<userDataCubit, userDataStates>(
      listener: (context, state) {
        if (state is sendReviewSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم ارسال التقييم،شكرا لك')));
        }
        if (state is sendReviewFaillState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('حدث خطاء ما حاول مره اخري')));
        }
      },
      builder: (context, state) {
        var cubit = userDataCubit.get(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              color: Colors.grey[250],
              child: Column(children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                        height: 117.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0).r,
                          color: const Color.fromRGBO(217, 173, 48, 1),
                        ),
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
                                  )),
                            ])),
                    Positioned(
                     left: 60.0.r,
                     top: 50.0.r,
                      child: Container(
                        height: 150.h,
                        width: 240.w,
                        child: Image.asset('assets/rating.png'),
                      ),
                    )
                  ],
                ),
                 SizedBox(
                  height: 80.h,
                ),
                 Text(
                  'تقييم و تعليق',
                  style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold,fontFamily: 'Tajawal',),
                ),

                 SizedBox(
                  height: 5.h,
                ),

                 Text(
                  'تستطع مشاركتنا رايك الان عن طريق اختيار النجوم',
                  style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Tajawal',
                      color: Colors.black45),
                ),

                SizedBox(
                  height: 5.h,
                ),

                RatingBar.builder(
                  initialRating: rating,
                  minRating: 1,
                  allowHalfRating: true,
                  itemPadding: EdgeInsets.symmetric(horizontal: 2.r),
                  glowColor: Colors.yellow,
                  glowRadius: 3,
                  updateOnDrag: true,
                  //ignoreGestures: true,
                  itemCount: 5,
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (newRating) {
                    rating = newRating;
                    print('New rating: $rating');
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.r, right: 15.r),
                  child: TextField(
                    onChanged: (newValue) {
                      feedback = newValue;
                    },
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                        hintText: 'اخبرنا المزيد عن تقييمك',
                        hintStyle: TextStyle(color: Colors.black,fontFamily: 'Tajawal',fontSize: 13.sp),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 50.r, horizontal: 10.r),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5).r)),
                  ),
                ),

                 SizedBox(
                  height: 25.h,
                ),
                // the button
                Padding(
                  padding: EdgeInsets.only(left: 10.r, right: 10.r),
                  child: FormButton(
                      gradient: LinearGradient(colors: <Color>[
                        const Color(0xffD9AD30),
                        Colors.amber.shade200,
                      ]),
                      onPressed: () {
                        //formKey.currentState!.save();
                        cubit.sendReview(rating, feedback, workerId);
                      },
                      child: const Text(
                        'ارسال التقييم',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold,fontFamily: 'Tajawal',),
                      )),
                ),
              ]
              ),
            ),
          ),
        );
      },
    );
  }
}
