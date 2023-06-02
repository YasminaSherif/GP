import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../bloc/editUser/cubit.dart';
import '../../../bloc/workerData/cubit.dart';
import '../../../customized/FormButton.dart';


class CraftWorkImagesEditing extends StatefulWidget {
  CraftWorkImagesEditing({Key? key}) : super(key: key);

  @override
  _CraftWorkImagesEditingState createState() => _CraftWorkImagesEditingState();
}

class _CraftWorkImagesEditingState extends State<CraftWorkImagesEditing> {
  final scaffoldState = GlobalKey<ScaffoldState>();
  @override
   var cubitImage = ImagePickerCubit();
  Widget build(BuildContext context) {
       return BlocConsumer<workerDataCubit, workerDataStates>(
        listener:(context, state){
          if(state is UpdateProfileSuccessful){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text('تم الرفع بنجاح')));
          }
          if(state is UpdateProfileError){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text('حاول مره اخري')));
          }
        } ,
        builder:(context, state){
        var cubit=workerDataCubit.get(context);
       
        Widget bottomSheet() {
      return Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'اختر صوره شخصيه',
                style: TextStyle(fontSize: 20.0),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                      onPressed: () async {
                              await cubitImage.takePhoto(ImageSource.camera);
                              // Call setState to rebuild the widget and show the selected image
                              setState(() {});
                            },
                            icon: const Icon(Icons.camera),
                            label: const Text('Camera')),
                        TextButton.icon(
                            onPressed: () async {
                              await cubitImage.takePhoto(ImageSource.gallery);
                              // Call setState to rebuild the widget and show the selected image
                              setState(() {});
                            },
                      icon: const Icon(Icons.image),
                      label: const Text('Gallery'))
                ],
              )
            ],
          ),
        ),
      );
    }



         return BlocProvider(
      create: (BuildContext context) => ImagePickerCubit(),
      child: BlocConsumer<ImagePickerCubit, ImagePickerStates>(
        listener: (context, state) {
          if(state is UpdateProfileSuccessful){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text('تم الرفع بنجاح')));
          }
        },
        builder: (context, state) {
          return Scaffold(
            
            body: SingleChildScrollView(
              child: Container(
                 color: Colors.grey[300],
                 child: Column(children: [
                  Stack(
                    alignment: AlignmentDirectional.center,
                    clipBehavior: Clip.none,
                    children: [
                      Container(

                          height: 127,
                          color: const Color(0xffD9AD30),
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
                                    )
                                ),
                              ]
                          )
                      ),

                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),

                  Container(
    width: 200,
    height: 200,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
    ),
    child: cubitImage.image == null
        ? IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: ((builder) => bottomSheet()),
                );
            },
          )
        : Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                     image: FileImage(
                       File(cubitImage.image!.path).absolute
                    ),
                ),
            ),
        ),
),
                        

                   const SizedBox(
                    height: 45,
                  ),
                  // the button
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 150),
                    child: FormButton(
                        gradient: LinearGradient(colors: <Color>[
                          const Color(0xffD9AD30),
                          Colors.amber.shade200,
                        ]),
                        onPressed: () {
                        cubit.updateWorker(
  
  firstName: null,
  lastName: null,
  bio: null,
  username: null,
  location: null,
  phoneNumber: null,
  profilePic: null,
  workImage: cubitImage.fileImage,
);
                        },
                        child: const Text(
                          'رفع',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        )),
                  ),
                  ]),
            ))
            );
  }));
            
       }
 );
  }}
  