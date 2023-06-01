import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/editUser/cubit.dart';
import '../../../bloc/workerData/cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';
import '../../../customized/FormButton.dart';
import '../../../services/methods/navigation.dart';
import '../../auth/buildTextFormField.dart';
import '../../auth/ChangePassword.dart';

class ImagePicker extends StatefulWidget{
   ImagePicker({Key? key}) : super(key: key);

  @override
  _ImagePickerState createState() => _ImagePickerState();
}



class _ImagePickerState extends State<ImagePicker> {
  final scaffoldState = GlobalKey<ScaffoldState>();

  final formKey = GlobalKey<FormState>();
  String? username;
  String? password;
  String? firstname ;
  String? lastname;
  String? location ;
  String? phoneNum;

  //Info c = Info();


  var cubit = ImagePickerCubit();

  @override
  Widget build(BuildContext context) {
     return BlocConsumer<workerDataCubit, workerDataStates>(
        listener:(context, state){
          if(state is UpdateProfileSuccessful){
            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('لقد تم التغيير بنجاح')));
          } else if ( state is UpdateProfileError){
            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('حدث خطأ ما')));
          }
        },
        builder: (context, state)
        {
    var cubituser=workerDataCubit.get(context);
     firstname=cubituser.workerResponse![0].firstName;
     lastname=cubituser.workerResponse![0].lastName;
     username = cubituser.workerResponse![0].username;
     location = cubituser.workerResponse![0].location;
     phoneNum= cubituser.workerResponse![0].phonenumber;
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
                              await cubit.takePhoto(ImageSource.camera);
                              // Call setState to rebuild the widget and show the selected image
                              setState(() {});
                            },
                            icon: const Icon(Icons.camera),
                            label: const Text('Camera')),
                        TextButton.icon(
                            onPressed: () async {
                              await cubit.takePhoto(ImageSource.gallery);
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
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromRGBO(217, 173, 48, 1),
              toolbarHeight: 100,
              elevation: 0,
              title: const Padding(
                padding: EdgeInsets.only(left: 60, right: 5),
                child: Text(
                  'معلومات شخصية',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 23,
                      color: Colors.black),
                ),
              ),
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  )),
            ),
            body: Container(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10),

              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // photo
                      Center(
                        child: Stack(
                          children: [
                           Container(
  width: 130,
  height: 130,
  decoration: BoxDecoration(
    border: Border.all(width: 4, color: Colors.white),
    boxShadow: [
      BoxShadow(
        spreadRadius: 2,
        blurRadius: 10,
        color: Colors.grey.withOpacity(0.5),
      )
    ],
    shape: BoxShape.circle,
    image: cubit.image == null && cubituser.workerResponse![0].image == null
        ? DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/grey_circle.png'),
          )
        : cubit.image == null
            ? DecorationImage(
                fit: BoxFit.cover,
                image: MemoryImage(
                  base64Decode(cubituser.workerResponse![0].image!),
                ),
              )
            : DecorationImage(
                fit: BoxFit.cover,
                image: FileImage(
                  File(cubit.image!.path).absolute,
                ),
              ),
  ),
),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(width: 4, color: Colors.white),
                                    color: Colors.amber,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: ((builder) => bottomSheet()),
                                      );
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'عشان تغير اى من معلوماتك الشخصية دوس عليها',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 17, color: Colors.black),
                      ),
                      Form(
                        key: formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 12,
                              ),
                              //Name
                              Row(
                                children: [
                                  //Last name
                                  Expanded(
                                    child: buildTextFormField
                                      (
                                      validator: (lastName) {
                                        if (lastName!.isEmpty ||
                                            lastName.length < 2 ||
                                            lastName.length > 15) {
                                          return 'الاسم يجب ان لا يزيد عن 8 احرف';
                                        }
                                      },
                                      onSaved: (value) {
                                        if (value!.isEmpty){
                                          lastname = null;
                                        }else{
                                          lastname = value;
                                        }
                                      },
                                      hintText: lastname ?? "ادارة",
                                      obscureText: false,
                                      icon: const Icon(Icons.person, color: Colors.amberAccent,),
                                    ),
                                  ),

                                  // first name
                                  Expanded(
                                    child: buildTextFormField(
                                      validator: (firstName) {
                                        if (firstName!.isEmpty || firstName.length < 2 || firstName.length > 15) {
                                          return 'الاسم الاول يجب ان يكون بين حرفين حتى 8 احرف';
                                        }
                                      },
                                      onSaved: (value) {
                                        if (value!.isEmpty){
                                          firstname = null;
                                        }else{
                                          firstname = value;
                                        }
                                      },
                                      hintText: firstname ?? "مصطفى",
                                      obscureText: false,
                                      icon: const Icon(Icons.person, color: Colors.amberAccent,),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 7,),

                              //email
                              buildTextFormField(
                                onSaved: (value) {
                                  username = value?.isEmpty == true ? null : value;
                                },
                                hintText: username ?? "adara@gmail.com",
                                
                                obscureText: false,
                                icon: const Icon(Icons.person_3_outlined , color: Colors.amberAccent,),
                              ),

                              const SizedBox(
                                height: 10,
                              ),
                              buildTextFormField(
                                onSaved: (value) {
                                  phoneNum = value?.isEmpty == true ? null : value;
                                },
                                hintText: phoneNum ?? "0121596678",
                                obscureText: false,
                                icon: const Icon(Icons.phone, color: Colors.amberAccent,),
                              ),
                              //phone number
                              const SizedBox(
                                height: 10,
                              ),

                              //location
                              buildTextFormField(
                                onSaved: (value) {
                                  location = value?.isEmpty == true ? null : value;
                                },
                                hintText: location ?? "شبراااا",

                                obscureText: false,
                                icon: const Icon(Icons.location_on_outlined, color: Colors.amberAccent,),
                              ),
                              const SizedBox(
                                height: 10,
                              ),

                              // Button
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  FormButton(
                                    width:100,
                                      height: 50,
                                      child: const Text('الغاء', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.5),),
                                      onPressed: (){
                                        Navigator.pop(context);
                                      }),

                                  FormButton(
                                      width: 100,
                                      height: 50,
                                      child: const Text(
                                        'حفظ التغيرات',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.5),
                                      ),
                                      onPressed: () {
                                        formKey.currentState!.save();

                                        cubituser.updateWorker(firstName: firstname,lastName: lastname,username: username,location: location,phoneNumber: phoneNum,profilePic: cubit.fileImage);
                                        // final isValid =
                                        //     formKey.currentState!.validate();
                                        // if (isValid) {
                                        //   formKey.currentState!.save();
                                        //   ScaffoldMessenger.of(context)
                                        //       .showSnackBar(const SnackBar(
                                        //           content: Text(
                                        //               'You have registered')));
                                        // } else {
                                        //   ScaffoldMessenger.of(context)
                                        //       .showSnackBar(const SnackBar(
                                        //           content: Text(
                                        //               'invalid Credentials')));
                                        // }
                                      }),
                                ],
                              ),

                              TextButton(onPressed: (){
                                navigateWithBack(context,ChangePassword());
                              }, child: const Text('تغير كلمة المرور'))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  });}
}