import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';

import '../../../models/persons.dart';

class WorkImageItem extends StatefulWidget {
  WorkImageItem({Key? key,required this.image}) : super(key: key);
   imageOfPastWork image;
  @override
  State<WorkImageItem> createState() => _WorkImageItemState();
}

class _WorkImageItemState extends State<WorkImageItem> {
  bool imageClicked = false;
  @override
  Widget build(BuildContext context) {
    return
          Stack(
            children: [
              FullScreenWidget(
                disposeLevel: DisposeLevel.High,
                child: GestureDetector(
                  onLongPress:() {
                    setState(() {
                      imageClicked = !imageClicked;
                    });
                  },
                  child: Container(
                    width: 120.0,
                    height: 85.0,
                    child:  Image.memory(
                      widget.image != null ? base64Decode(widget.image.image) : Uint8List(0),
                    fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              if (imageClicked)
              Container(
                height: 30.0,
                width: 120,
                color: Colors.grey[350],
                child: Column(
                  children: [
                    // GestureDetector(
                    //   onTap: (){},
                    //   child: Row(
                    //     children: const [
                    //       Icon(Icons.photo),
                    //       SizedBox(width: 2,),
                    //       Text('عرض الصورة',)
                    //     ],
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 6,
                    // ),
                    GestureDetector(
                      onTap: (){},
                      child: Row(
                        children: const [
                          Icon(Icons.delete),
                          SizedBox(width: 2,),
                          Text('حذف الصورة',)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );


  }
}
