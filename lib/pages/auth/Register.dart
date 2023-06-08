import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fortestpages/customized/FormButton.dart';
import 'package:fortestpages/pages/auth/SignIn.dart';
import 'package:image_picker/image_picker.dart';
import '../../bloc/editUser/cubit.dart';
import '../../bloc/register/cubit.dart';
import '../../services/methods/navigation.dart';
import '../../src/const.dart';
import '../user/userHome/home_layout.dart';
import '../worker/craft_home_layout.dart';
import 'buildTextFormField.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final scaffoldState = GlobalKey<ScaffoldState>();
  @override
  var cubitImage = ImagePickerCubit();

  final formKey = GlobalKey<FormState>();
  String firstname = '';
  String lastname = '';
  String username = '';
  String location = '';
  String email = '';
  String password = '';
  String confirmP = '';
  String phoneNumber = '';
  int? value;
  int? value2;

  // DropDown 1
  final items = ['مستخدم', 'صنايعى'];

  DropdownMenuItem<int> buildMenuItem(String item) => DropdownMenuItem(
        value: items.indexOf(item),
        child: Text(
          item,
          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
        ),
      );

  final special = [
    'نجار',
    'حداد',
    'كهربائي',
    'تعقيم',
    'سباك',
    'نقاش',
    'زجاج',
    'محاره',
    'ستائر'
  ];

  DropdownMenuItem<int> buildMenuItem2(String item) => DropdownMenuItem(
      value: special.indexOf(item),
      child: Text(
        item,
        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
      ));

  RegisterCubit cubit = RegisterCubit();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is AlreadyRegisteredState) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('الحساب مسجل بالفعل')));
          navigateAndNotBack(context, SignIn());
        } else if (state is RegisterUserSuccessfulState) {
          Constant.saveData(key: "id", value: state.userResponse.data!.id);
          navigateAndNotBack(context, const HomeLayout());
        } else if (state is RegisterWorkerSuccessfulState) {
          Constant.saveData(key: "id", value: state.workerResponse.data!.id);
          navigateAndNotBack(context, const CraftHomeLayout());
        } else if (state is RegisterFailState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('حدث خطأ ما')));
        }
      },
      builder: (context, state) {
        var cubit = RegisterCubit.get(context);

        Widget bottomSheet() {
          return Container(
            height: 100.h,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 20.r, vertical: 20.r),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'اختر صوره شخصيه',
                    style: TextStyle(fontSize: 20.0.sp),
                  ),
                  SizedBox(
                    height: 20.h,
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

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppBar(
              title: const Text(
                'انشاء حساب',
              ),
              centerTitle: true,
              backgroundColor: const Color.fromRGBO(217, 173, 48, 1),
              elevation: 0,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Form(
                key: formKey,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    // Container(
                    //   width: 400,
                    //   height: 200,
                    //   margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    //   decoration: const BoxDecoration(
                    //       color: Colors.white,
                    //       image: DecorationImage(
                    //           image: AssetImage('assets/Sign-In.png'))
                    //   ),
                    // ),
                    const SizedBox(
                      height: 3,
                    ),
                    // photo
                    Center(
                      child: Stack(
                        children: [
                          //the img
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
                              image: cubitImage.image == null
                                  ? DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage('assets/OIP.jpg'),
                                    )
                                  : DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(
                                          File(cubitImage.image!.path).absolute
                                          //File(cubit.image?.path ?? '')
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
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        //Last name
                        Expanded(
                          child: buildTextFormField(
                            validator: (lastName) {
                              if (lastName!.isEmpty ||
                                  lastName.length < 2 ||
                                  lastName.length > 15) {
                                return 'الاسم يجب ان لا يزيد عن 8 احرف';
                              }
                            },
                            hintText: 'الاسم الاخير',
                            onSaved: (value) {
                              lastname = value!;
                              print(lastname);
                            },
                            obscureText: false,
                            icon: const Icon(
                              Icons.person,
                              color: Colors.amberAccent,
                            ),
                          ),
                        ),

                        // first name
                        Expanded(
                          child: buildTextFormField(
                            validator: (firstName) {
                              if (firstName!.isEmpty ||
                                  firstName.length < 2 ||
                                  firstName.length > 15) {
                                return 'الاسم الاول يجب ان يكون بين حرفين حتى 8 احرف';
                              }
                            },
                            hintText: 'الاسم الاول',
                            onSaved: (value) {
                              firstname = value!;
                              print(firstname);
                            },
                            obscureText: false,
                            icon: const Icon(
                              Icons.person,
                              color: Colors.amberAccent,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 6,
                    ),
                    // User Name
                    buildTextFormField(
                      validator: (username) {
                        if (username!.isEmpty ||
                            username.length < 2 ||
                            username.length > 15) {
                          return 'Enter a username';
                        }
                      },
                      hintText: 'اسم المستخدم',
                      onSaved: (value) {
                        username = value!;
                      },
                      obscureText: false,
                      icon: const Icon(
                        Icons.person_pin,
                        color: Colors.amberAccent,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    // Location
                    buildTextFormField(
                      validator: (location) {
                        if (location!.isEmpty ||
                            location.length < 3 ||
                            location.length > 15) {
                          return 'Enter valid location';
                        }
                      },
                      hintText: 'موقعك',
                      onSaved: (value) {
                        location = value!;
                      },
                      obscureText: false,
                      icon: const Icon(
                        Icons.location_on,
                        color: Colors.amberAccent,
                      ),
                    ),

                    const SizedBox(
                      height: 6,
                    ),
                    // email
                    buildTextFormField(
                      validator: (email) {
                        if (email!.isEmpty ||
                            !email.contains('@') ||
                            !email.contains('.com')) {
                          return 'Invalid E-mail';
                        }
                      },
                      hintText: 'الايميل',
                      onSaved: (value) {
                        email = value!;
                      },
                      obscureText: false,
                      icon: const Icon(
                        Icons.email_outlined,
                        color: Colors.amberAccent,
                      ),
                    ),

                    const SizedBox(
                      height: 6,
                    ),
                    // PASSWORD
                    buildTextFormField(
                      validator: (password) {
                        if (password!.isEmpty || password.length < 6) {
                          return 'Password should be at least 6 char ';
                        }
                      },
                      isSuffix: true,
                      hintText: 'كلمة السر',
                      onSaved: (value) {
                        password = value!;
                      },
                      obscureText: true,
                      icon: const Icon(
                        Icons.remove_red_eye_outlined,
                        color: Colors.amberAccent,
                      ),
                    ),

                    const SizedBox(
                      height: 6,
                    ),
                    //Confirm
                    buildTextFormField(
                      validator: (confirm) {
                        if (confirm!.isEmpty ||
                            confirm.length < 6 /*|| password != confirmP*/) {
                          return 'Password should be match ';
                        }
                      },
                      isSuffix: true,
                      hintText: 'تأكيد كلمة السر',
                      onSaved: (value) {
                        confirmP = value!;
                      },
                      obscureText: true,
                      icon: const Icon(
                        Icons.remove_red_eye_outlined,
                        color: Colors.amberAccent,
                      ),
                    ),

                    const SizedBox(
                      height: 6,
                    ),
                    // PHONE NUMBER
                    buildTextFormField(
                      validator: (phone) {
                        if (phone!.isEmpty ||
                            RegExp(r'^01[0-2,5]{1}[0-9]{8}$').hasMatch(phone)) {
                          return 'phone number should be 12';
                        }
                      },
                      isSuffix: false,
                      hintText: 'رقم المحمول',
                      onSaved: (value) {
                        phoneNumber = value!;
                      },
                      obscureText: false,
                      icon: const Icon(
                        Icons.phone,
                        color: Colors.amberAccent,
                      ),
                    ),

                    // DropDown 1
                    const SizedBox(height: 6),
                    DropdownButtonFormField<int>(
                      validator: (value) =>
                          value == null ? 'Please select user type' : null,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'نوع المستخدم',
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.orange,
                        ),
                      ),
                      value: value,
                      items: items.map(buildMenuItem).toList(),
                      onChanged: (value) {
                        cubit.userTypeChanged(value!);
                        this.value = value;
                      },
                      onSaved: (value) {
                        cubit.userTypeChanged(value!);
                        this.value = value;
                      },
                    ),

                    //DropDown 2
                    const SizedBox(
                      height: 2,
                    ),
                    DropdownButtonFormField<int>(
                      // validator: (value) =>
                      //     value == null ? 'Please select a speciality' : null,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'اختصاصك',
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 18, horizontal: 10),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(
                          Icons.medical_services,
                          color: Colors.orange,
                        ),
                      ),
                      value: value2,
                      items: special.map(buildMenuItem2).toList(),
                      onChanged: (value) {
                        cubit.specialityChanged(value!);
                        this.value2 = value;
                      },
                      onSaved: (value) {
                        cubit.specialityChanged(value);
                        this.value2 = value;
                      },
                    ),

                    const SizedBox(height: 20, width: 0),
                    (state is RegisterLoadingState)
                        ? const Center(child: CircularProgressIndicator())
                        : FormButton(
                            width: 300.w,
                            gradient: LinearGradient(colors: <Color>[
                              const Color(0xffD9AD30),
                              Colors.amber.shade200,
                            ]),
                            child: const Text(
                              'تسجيل',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              formKey.currentState!.save();
                              final isValid = formKey.currentState!.validate();
                              if (isValid) {
                                cubit.Register(
                                    firstname,
                                    lastname,
                                    username,
                                    location,
                                    email,
                                    password,
                                    confirmP,
                                    phoneNumber,
                                    value!,
                                    value2,
                                    cubitImage.fileImage);

                                formKey.currentState!.save();

                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //       const SnackBar(
                                //           content: Text('يوجد خطأ بالمعلومات المدخله')));
                              }
                              print(firstname);
                            },
                          ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              navigateAndNotBack(context, SignIn());
                            },
                            child: const Text('تسجيل الدخول',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    decoration: TextDecoration.underline))),
                        const Text('لديك حساب؟'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
