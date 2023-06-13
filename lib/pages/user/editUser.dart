import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../bloc/editUser/cubit.dart';
import '../../bloc/userData/cubit.dart';
import 'package:image_picker/image_picker.dart';
import '../../customized/FormButton.dart';
import '../../services/methods/navigation.dart';
import '../auth/buildTextFormField.dart';
import '../auth/ChangePassword.dart';

class ImagePicker extends StatefulWidget {
  ImagePicker({Key? key}) : super(key: key);

  @override
  _ImagePickerState createState() => _ImagePickerState();
}
class _ImagePickerState extends State<ImagePicker> {
  final scaffoldState = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  String? username;
  String? password;
  String? firstname;
  String? lastname;
  String? area;
  String? phoneNum;
  String? _selectedCity ;
  final ourCity = ['القاهره', 'الاسكندرية', 'الجيزة', 'حلوان'];
  DropdownMenuItem<String> buildMenuItem3(String inCity) => DropdownMenuItem(
      value: inCity,
      child: Text(
        inCity,
        style:  TextStyle(fontWeight: FontWeight.w400, fontSize: 15.sp ,fontFamily: 'Tajawal'),
      ));
  var cubit = ImagePickerCubit();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<userDataCubit, userDataStates>(
        listener: (context, state) {
      if (state is UpdateProfileSuccessful) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('لقد تم التغيير بنجاح')));
      } else if (state is UpdateProfileError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('حدث خطأ ما')));
      }
    }, builder: (context, state) {
      var cubituser = userDataCubit.get(context);
      firstname = cubituser.userResponse![0].firstName;
      lastname = cubituser.userResponse![0].lastName;
      username = cubituser.userResponse![0].username;
      area = cubituser.userResponse![0].area;
      phoneNum = cubituser.userResponse![0].phonenumber;
      Widget bottomSheet() {
        return Container(
          height: 100.h,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'اختر صورة شخصية',
                  style: TextStyle(fontSize: 20.0.sp ,fontFamily: 'Tajawal'),
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
                        label:  const Text('الكاميرا', style: TextStyle(fontFamily: 'Tajawal'),)),
                    TextButton.icon(
                        onPressed: () async {
                          await cubit.takePhoto(ImageSource.gallery);
                          // Call setState to rebuild the widget and show the selected image
                          setState(() {});
                        },
                        icon: const Icon(Icons.image),
                        label: const Text('المعرض', style: TextStyle(fontFamily: 'Tajawal')))
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
                        color: Colors.black,fontFamily: 'Tajawal'),
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
                                height: 130.h,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 4, color: Colors.white),
                                  boxShadow: [
                                    BoxShadow(
                                      spreadRadius: 2.r,
                                      blurRadius: 7.r,
                                      color: Colors.grey.withOpacity(0.5),
                                    )
                                  ],
                                  shape: BoxShape.circle,
                                  image: cubit.image == null &&
                                          cubituser.userResponse![0].image ==
                                              null
                                      ? const DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              'assets/images/grey_circle.png'),
                                        )
                                      : cubit.image == null
                                          ? DecorationImage(
                                              fit: BoxFit.cover,
                                              image: MemoryImage(
                                                base64Decode(cubituser
                                                    .userResponse![0].image!),
                                              ),
                                            )
                                          : DecorationImage(
                                              fit: BoxFit.cover,
                                              image: FileImage(
                                                File(cubit.image!.path)
                                                    .absolute,
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
                                      border: Border.all(
                                          width: 4, color: Colors.white),
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
                        SizedBox(height: 20.h),
                        Text(
                          'لتغيير اي من المعلومات برجاء الضغط عليها',
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 17.sp, color: Colors.black,fontFamily: 'Tajawal'),
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
                                      flex: 1,
                                      child: buildTextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'يرجى ادخال اسم عائلتك';
                                          }
                                          if (value.length < 2) {
                                            return 'الاسم يجب ان يحتوي على حرفين على الأقل';
                                          }
                                          if (value.length > 15) {
                                            return 'الاسم يجب ان لا يزيد عن 15 حرف';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          if (value!.isEmpty) {
                                            lastname = null;
                                          } else {
                                            lastname = value;
                                          }
                                        },
                                        hintText: lastname ?? "الاسم",
                                        obscureText: false,
                                        icon: const Icon(
                                          Icons.person,
                                          color: Colors.amberAccent,
                                        ),
                                      ),
                                    ),

                                    // first name
                                    Expanded(
                                      flex: 1,
                                      child: buildTextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'يرجى ادخال اسمك الاول';
                                          }
                                          if (value.length < 2) {
                                            return 'الاسم يجب ان يحتوي على حرفين على الأقل';
                                          }
                                          if (value.length > 15) {
                                            return 'الاسم يجب ان لا يزيد عن 15 حرف';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          if (value!.isEmpty) {
                                            firstname = null;
                                          } else {
                                            firstname = value;
                                          }
                                        },
                                        hintText: firstname ?? "مصطفى",
                                        obscureText: false,
                                        icon: const Icon(
                                          Icons.person,
                                          color: Colors.amberAccent,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                //email
                                buildTextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'يرجى ادخال البريد الالكتروني';
                                    }
                                    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',);
                                    // if (!emailRegex.hasMatch(value)) {
                                    //   return 'البريد الالكتروني غير صالح';
                                    // }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    username =
                                        value?.isEmpty == true ? null : value;
                                  },
                                  hintText: username ?? "name@gmail.com",
                                  obscureText: false,
                                  icon: const Icon(
                                    Icons.person_3_outlined,
                                    color: Colors.amberAccent,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                //phone number
                                buildTextFormField(
                                  validator: (phone) {
                                    if (phone == null || phone.isEmpty) {
                                      return 'يرجى ادخال رقم المحمول';
                                    }
                                    if (!RegExp(r'^01[0-2,5]{1}[0-9]{8}$').hasMatch(phone)) {
                                      return 'يرجى ادخال رقم محمول صحيح';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    phoneNum =
                                        value?.isEmpty == true ? null : value;
                                  },
                                  hintText: phoneNum ?? "0121596678",
                                  obscureText: false,
                                  icon: const Icon(
                                    Icons.phone,
                                    color: Colors.amberAccent,
                                  ),
                                ),

                                SizedBox(
                                  height: 10.h,
                                ),

                                Row(
                                  children: [
                                    //location
                                    Expanded(
                                      flex: 1,
                                      child: buildTextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'يرجى ادخال موقعك';
                                          }
                                          if (value.length < 2) {
                                            return 'موقعك يجب ان يحتوي على حرفين على الأقل';
                                          }
                                          if (value.length > 15) {
                                            return 'الاسم يجب ان لا يزيد عن 15 حرف';
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          area =
                                          value?.isEmpty == true ? null : value;
                                        },
                                        hintText: area ?? "شبراااا",
                                        obscureText: false,
                                        icon: const Icon(
                                          Icons.location_on_outlined,
                                          color: Colors.amberAccent,
                                        ),
                                      ),
                                    ),
                                    //dropdown
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 10.r),
                                        child: DropdownButtonFormField<String>(
                                          validator: (value) =>
                                          value == null ? 'اختر مدينه من فضلك' : null,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                             hintText: cubituser.userResponse![0].city!,
                                            contentPadding: const EdgeInsets.symmetric(
                                                vertical: 15, horizontal: 10),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius: BorderRadius.circular(12),
                                            ),

                                            suffixIcon: const Icon(
                                              Icons.location_city_sharp,
                                              color: Colors.orange,
                                            ),
                                          ),
                                          value: _selectedCity,
                                          items: ourCity.map(buildMenuItem3).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              _selectedCity = value;
                                            });
                                          },
                                          onSaved: (value) {
                                            _selectedCity = value;
                                          },
                                        ),
                                      ),
                                    ),

                                  ],
                                ),

                                const SizedBox(height: 10,),
                                //location
                                const SizedBox(height: 10,),
                                // Button
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    FormButton(
                                        width: 100.w,
                                        height: 50.h,
                                        child: Text(
                                          'الغاء',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.5.sp,
                                              fontFamily: 'Tajawal'),),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }),
                                    FormButton(
                                        width: 110.w,
                                        height: 50.h,
                                        child: Text(
                                          'حفظ التغيرات',
                                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.5.sp,fontFamily: 'Tajawal'),
                                        ),
                                        onPressed: () {
                                          //var isValid = formKey.currentState!.validate();
                                         
                                            formKey.currentState!.save();
                                            cubituser.updateUser(
                                                firstName: firstname,
                                                lastName: lastname,
                                                username: username,
                                                area: area,
                                                city: _selectedCity,
                                                phoneNumber: phoneNum,
                                                imageFile: cubit.fileImage);
                                          
                                          
                                        }),
                                  ],
                                ),
                                TextButton(
                                    onPressed: () {
                                      navigateWithBack(
                                          context, ChangePassword());
                                    },
                                    child: Text('تغير كلمة المرور',style: TextStyle(fontSize: 15.sp,decoration: TextDecoration.underline,),))
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
    });
  }
}
