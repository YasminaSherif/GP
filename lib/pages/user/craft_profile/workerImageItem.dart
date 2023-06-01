import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';

import '../../../models/loginDataResponse.dart';

class workImages extends StatelessWidget {
  workImages({super.key,required this.image});
imageOfPastWork image;
  @override
  Widget build(BuildContext context) {
    return  FullScreenWidget( disposeLevel: DisposeLevel.High,
    child: ClipRRect(
  borderRadius: BorderRadius.vertical(
    top: Radius.circular(0),
    bottom: Radius.circular(0),
  ),
  child: Container(
    width: 120.0,
    height: 85.0,
    child: Image.memory(
      image != null ? base64Decode(image.image) : Uint8List(0),
      fit: BoxFit.cover,
    ),
  ),
));

  }
}