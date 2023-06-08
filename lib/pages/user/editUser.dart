import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../bloc/editUser/cubit.dart';
import '../../bloc/userData/cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';
import '../../customized/FormButton.dart';
import '../../services/methods/navigation.dart';
import '../auth/buildTextFormField.dart';
import '../auth/ChangePassword.dart';

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
     return BlocConsumer<userDataCubit, userDataStates>(
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
    var cubituser=userDataCubit.get(context);
     firstname=cubituser.userResponse![0].firstName;
     lastname=cubituser.userResponse![0].lastName;
     username = cubituser.userResponse![0].username;
     location = cubituser.userResponse![0].location;
     phoneNum= cubituser.userResponse![0].phonenumber;
    Widget bottomSheet() {
      return Container(
        height: 100.h,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'اختر صوره شخصيه',
                style: TextStyle(fontSize: 20.0),
              ),
               SizedBox(
                height: 20.h,
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
              title: Padding(
                padding: EdgeInsets.only(left: 60.r, right: 5.r),
                child: Text(
                  'معلومات شخصية',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 23.sp,
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
              padding: EdgeInsets.only(left: 15.r, right: 15.r, top: 10.r),

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
  width: 130.w,
  height: 130.w,
  decoration: BoxDecoration(
    border: Border.all(width: 4.w, color: Colors.white),
    boxShadow: [
      BoxShadow(
        spreadRadius: 2,
        blurRadius: 10,
        color: Colors.grey.withOpacity(0.5),
      )
    ],
    shape: BoxShape.circle,
    image: cubit.image == null && cubituser.userResponse![0].image == null
        ? DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/grey_circle.png'),
          )
        : cubit.image == null
            ? DecorationImage(
                fit: BoxFit.cover,
                image: MemoryImage(
                  base64Decode(cubituser.userResponse![0].image!),
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
                                  height: 40.h,
                                  width: 40.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(width: 4.w, color: Colors.white),
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
                       SizedBox(height: 30.h),
                       Text(
                        'عشان تغير اى من معلوماتك الشخصية دوس عليها',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 17.sp, color: Colors.black),
                      ),
                      Form(
                        key: formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                               SizedBox(
                                height: 12.h,
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

                               SizedBox(height: 7.h,),

                              //email
                              buildTextFormField(
                                onSaved: (value) {
                                  username = value?.isEmpty == true ? null : value;
                                },
                                hintText: username ?? "adara@gmail.com",
                                
                                obscureText: false,
                                icon: const Icon(Icons.person_3_outlined , color: Colors.amberAccent,),
                              ),

                               SizedBox(
                                height: 10.h,
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
                               SizedBox(
                                height: 10.h,
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
                               SizedBox(
                                height: 10.h,
                              ),

                              // Button
                               SizedBox(
                                height: 20.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  FormButton(
                                    width:100.w,
                                      height: 50.h,
                                      child: Text('الغاء', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.5.sp),),
                                      onPressed: (){
                                        Navigator.pop(context);
                                      }),

                                  FormButton(
                                      width: 100.w,
                                      height: 50.h,
                                      child: Text(
                                        'حفظ التغيرات',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.5.sp),
                                      ),
                                      onPressed: () {
                                        formKey.currentState!.save();

                                        cubituser.updateUser(firstName: firstname,lastName: lastname,username: username,location: location,phoneNumber: phoneNum,imageFile: cubit.fileImage);
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
