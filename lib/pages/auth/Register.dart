import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  String city = '';
  String email = '';
  String password = '';
  String confirmP = '';
  String phoneNumber = '';
  int? value;
  int? value2;
  String? value3;
  var confirmPass;
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // DropDown 1
  final items = ['مستخدم', 'صنايعى'];

  DropdownMenuItem<int> buildMenuItem(String item) => DropdownMenuItem(
        value: items.indexOf(item),
        child: Text(
          item,
          style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
        ),
      );

  // DropDown 2
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

  // DropDown 3
  final ourCity = ['القاهره', 'الاسكندرية', 'الجيزة', 'حلوان'];
  DropdownMenuItem<String> buildMenuItem3(String inCity) => DropdownMenuItem(
    value: inCity,
      child: Text(
        inCity,
        style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
      ));

  RegisterCubit cubit = RegisterCubit();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is AlreadyRegisteredState) {
          ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content: Text(state.msg)));
        } else if (state is RegisterUserSuccessfulState) {
          Constant.saveData(key: "userId", value: state.userResponse.id);
          navigateAndNotBack(context, const HomeLayout());
        } else if (state is RegisterWorkerSuccessfulState) {
          Constant.saveData(key: "workerId", value: state.workerResponse.id);
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

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppBar(
              title: const Text('انشاء حساب'),
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
                  children: <Widget>[

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
                                  ? const DecorationImage(
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
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        //Last name
                        Expanded(
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
                            hintText: 'الاسم الاخير',
                            onSaved: (value) {
                              lastname = value!;
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
                            hintText: 'الاسم الاول',
                            onSaved: (value) {
                              firstname = value!;
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
                      height: 8,
                    ),
                    // User Name
                    buildTextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'يرجى ادخال اسم المستخدم';
                        }
                        if (value.length < 2) {
                          return 'الاسم يجب ان يحتوي على حرفين على الأقل';
                        }
                        if (value.length > 20) {
                          return 'الاسم يجب ان لا يزيد عن 15 حرف';
                        }
                        return null;
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
                      height: 8,
                    ),

                    Row(
                      children: [

                        // CITY
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            validator: (value) =>
                            value == null ? 'اختر مدينه من فضلك' : null,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'المدينة',
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(12),
                              ),

                              icon: const Icon(
                                Icons.location_on_outlined,
                                color: Colors.black,
                              ),
                              suffixIcon: const Icon(
                                Icons.location_city_sharp,
                                color: Colors.orange,
                              ),
                            ),

                            value: value3,
                            items: ourCity.map(buildMenuItem3).toList(),

                            onChanged: (value) {
                              cubit.registerCityChanged(value!);
                              this.value3 = value;
                            },

                            onSaved: (value) {
                              cubit.registerCityChanged(value!);
                              this.value3 = value;
                            },
                          ),
                        ),

                        // Location
                        Expanded(
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
                        ),

                      ],
                    ),



                    const SizedBox(
                      height: 8,
                    ),
                    // email
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
                      height: 8,
                    ),
                    // PASSWORD
                    buildTextFormField(
                      validator: (value) {
                        confirmPass = value;
                        if (value == null || value.isEmpty) {
                          return 'يرجى ادخال كلمة المرور';
                        }
                        if (value.length < 6 || value.length > 15) {
                          return 'يجب أن تكون كلمة المرور بين 6 و 15 حرفًا';
                        }
                        final capitalRegex = RegExp(r'[A-Z]');
                        final lowercaseRegex = RegExp(r'[a-z]');
                        final numberRegex = RegExp(r'[0-9]');
                        if (!capitalRegex.hasMatch(value) ) {
                          return 'يجب أن تحتوي كلمة المرور على حرف كبير';
                        }
                        if (!lowercaseRegex.hasMatch(value)) {
                          return 'يجب أن تحتوي كلمةعلى حرف صغير ';
                        }
                        if (!numberRegex.hasMatch(value)) {
                          return 'يجب أن تحتوي كلمة المرور على رقم واحد على الأقل';
                        }
                        return null;
                      },
                      isSuffix: true,
                      hintText: 'كلمة السر',
                      onSaved: (value) {
                        password = value!;
                      },
                      obscureText: true,

                      icon: Icon(
                            _obscureText
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.amberAccent,
                      ),
                      onPressed: _toggle,
                    ),

                    const SizedBox(
                      height: 8,
                    ),
                    //Confirm
                    buildTextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى ادخال تأكيد كلمة المرور';
                        }
                        if (value != confirmPass) {
                          return 'كلمة المرور غير متطابقة';
                        }

                        return null;
                      },
                      isSuffix: true,
                      hintText: 'تأكيد كلمة السر',
                      onSaved: (value) {
                        confirmP = value!;
                      },
                      obscureText: true,
                      icon: Icon(
                        _obscureText
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.amberAccent,
                      ),
                      onPressed: _toggle,
                    ),

                    const SizedBox(
                      height: 8,
                    ),
                    // PHONE NUMBER
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
                            width: 300,
                            height: 50,
                            child: const Text(
                              'تسجيل',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              final isValid = formKey.currentState!.validate();
                              if (isValid) {
                                formKey.currentState!.save();
                                cubit.Register(
                                    firstname,
                                    lastname,
                                    username,
                                    location,
                                    value3!,
                                    email,
                                    password,
                                    confirmP,
                                    phoneNumber,
                                    value!,
                                    value2,
                                    cubitImage.fileImage);

                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('يوجد خطأ بالمعلومات المدخله')));
                              }
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