import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:full_screen_image/full_screen_image.dart';

import '../../../models/persons.dart';

class workImages extends StatelessWidget {
  workImages({super.key,required this.image});
imageOfPastWork image;
  @override
  Widget build(BuildContext context) {
    return  FullScreenWidget( disposeLevel: DisposeLevel.High,
    child: ClipRRect(
  borderRadius: BorderRadius.vertical(
    top: const Radius.circular(0).r,
    bottom: const Radius.circular(0).r,
  ),
  child: Container(
    width: 120.0.w,
    height: 85.0.h,
    child: Image.memory(
      image != null ? base64Decode(image.image) : Uint8List(0),
      fit: BoxFit.cover,
    ),
  ),
));

  }
}