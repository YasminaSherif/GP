import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fortestpages/pages/worker/craft_profile_editing/pastWorkItem.dart';
import 'package:fortestpages/pages/worker/craft_profile_editing/work_image_item.dart';

import '../../../bloc/workerData/cubit.dart';
import '../../../customized/FormButton.dart';
import '../../user/craft_profile/ratingItem.dart';
import 'craft_bio_editing.dart';
import 'craft_work_images_editing.dart';

class CraftProfileEditing extends StatelessWidget {
  const CraftProfileEditing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<workerDataCubit, workerDataStates>(
        listener: (context, state) {
      // TODO: implement listener
    }, builder: (context, state) {
      late double _minTextAdapt = 0.0;
      var cubit = workerDataCubit.get(context);

      return (cubit.workerResponse == null)
          ? const Center(child: CircularProgressIndicator())
          : Container(
              color: Colors.grey[250],
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.0),
                            color: const Color.fromRGBO(217, 173, 48, 1),
                          ),
                          height: 117.0.h,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(5.0.r),
                                child: IconButton(
                                  onPressed: () {
                                     Navigator.of(context).pop();
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back_sharp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 140.0.r,
                          top: 85.0.r,
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 32.0.r,
                                child: CircleAvatar(
                                  backgroundImage: cubit
                                              .workerResponse![0].image !=
                                          null
                                      ? MemoryImage(base64Decode(
                                          cubit.workerResponse![0].image!))
                                      : null,
                                  radius: 32.0.r,
                                  backgroundColor: Colors.grey,
                                ),
                              ),
                              
                              Text(
                                cubit.workerResponse![0].firstName +
                                    ' ' +
                                    cubit.workerResponse![0].lastName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Tajawal',
                                ),
                              ),
                              Text(
                                cubit.workerResponse![0].cate!.name!,
                                style: TextStyle(
                                  color: Colors.grey,
                                  height: 0.7.h,
                                  fontSize: 12.0.sp,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Tajawal',
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.star_rate,
                                    color: Colors.amber,
                                    size: 20.0,
                                  ),
                                  Text(
                                    cubit.workerResponse![0].rating.toString(),
                                    style: TextStyle(
                                      height: 1.0.h,
                                      fontSize: 12.0.sp,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Tajawal',
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                     SizedBox(height: 90.h),
                    Expanded(
                      child: Container(
                        color: const Color.fromRGBO(255, 255, 255, 1),
                        child: Padding(
                          padding: EdgeInsets.only(right: 10.r),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const CraftInfoEditing(),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.grey,
                                      size: 16.0,
                                    ),
                                  ),
                                  const Spacer(),
                                   Text(
                                     'عني',
                                     textAlign: TextAlign.end,
                                     style: TextStyle(
                                       fontSize: 17.0.sp,
                                       fontWeight: FontWeight.w900,
                                       fontFamily: 'Tajawal',
                                     ),
                                   ),
                                ],
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Text(
                                        cubit.workerResponse![0].bio ??
                                            "لم يتم اضافة تفاصيل بعد",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          height: 1.h,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Tajawal',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                     SizedBox(
                      height: 7.0.h,
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: Colors.white,
                        width: double.infinity,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            CraftWorkImagesEditing(),
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.drive_folder_upload,
                                    color: Colors.grey,
                                    size: 16.0,
                                  ),
                                ),
                                const Spacer(),
                                 Padding(
                                  padding: EdgeInsets.only(right: 10.0.r),
                                  child: Text(
                                    'اعمالي',
                                    style: TextStyle(
                                      fontSize: 17.0.sp,
                                      fontWeight: FontWeight.w900,
                                      fontFamily: 'Tajawal',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (cubit.workerResponse![0].pastWorkImages == null)
                               Center(
                                  child: Text(
                                "لا يوجد",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16.0.sp,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Tajawal',
                                ),
                              ))
                            else
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 15.0.r,
                                ),
                                child: Container(
                                  height: 70.0.h,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) =>
                                        WorkImageItem(
                                            image: cubit.workerResponse![0]
                                                .pastWorkImages![index]),
                                    separatorBuilder: (context, index) =>
                                         SizedBox(width: 8.0.w),
                                    itemCount: cubit.workerResponse![0]
                                        .pastWorkImages!.length,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                     SizedBox(
                      height: 7.0.h,
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        color: Colors.white,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                             Padding(
                              padding: EdgeInsets.only(
                                right: 10.0.r,
                              ),
                              child: Text(
                                'التقييمات و التعليقات',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 17.0.sp,
                                  fontFamily: 'Tajawal',
                                ),
                              ),
                            ),
                            if (cubit.workerResponse![0].review == null)
                               Center(
                                  child: Text(
                                "لا يوجد",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16.0.sp,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Tajawal',
                                ),
                              ))
                            else
                              Expanded(
                                child: MediaQuery.removePadding(
                                  removeTop: true,
                                  context: context,
                                  child: ListView.separated(
                                    itemBuilder: (context, index) => ratingItem(
                                        review: cubit
                                            .workerResponse![0].review![index]),
                                    separatorBuilder: (context, index) =>
                                         Divider(height: 15.h),
                                    itemCount:
                                        cubit.workerResponse![0].review!.length,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                     SizedBox(
                      height: 7.0.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0.r,
                      ),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0).r,
                          color: const Color.fromRGBO(217, 173, 48, 1),
                        ),
                      ),
                    )
                  ],
                ),
  
            );
    });
  }
}
