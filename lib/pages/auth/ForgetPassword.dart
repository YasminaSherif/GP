import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fortestpages/customized/FormButton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/methods/navigation.dart';
import '../../bloc/signin/cubit.dart';
import 'Send_Code.dart';
import 'buildTextFormField.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  String email = '';

  @override
  Widget build(BuildContext context) {
    //String password = '';

    return BlocConsumer<SignInCubit, SignInStates>(
      listener: (context, state) {
        if (state is ForgetPasswordSuccessfulState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text(' تم ارسال الكود')));
          navigateWithBack(
              context,
              Code(
                email: state.email,
              ));
        }
      },
      builder: (context, state) {
        var cubit = SignInCubit.get(context);
        return Scaffold(
          backgroundColor: const Color(0xffF6F6F6),
          body: Form(
            key: formKey,
            child: ListView(
              children: [
                Expanded(
                  child: Container(
                    width: 500,
                    height: 200,
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            image: AssetImage('assets/Sign-In.png'))),
                  ),
                ),

                const Text(
                  'استرجاع كلمة السر',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Tajawal'),
                ),
                const SizedBox(
                  height: 60,
                ),
                //email
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: buildTextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'يرجى ادخال البريد الالكتروني';
                      }
                      final emailRegex = RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                      );
                      if (!emailRegex.hasMatch(value)) {
                        return 'البريد الالكتروني غير صالح';
                      }
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
                ),

                const SizedBox(
                  height: 50,
                ),
                // Button
                Padding(
                  padding: EdgeInsets.only(left: 30.r, right: 30.r),
                  child: FormButton(
                      width: 300.w,
                      child: const Text(
                        'ارسال الكود',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Tajawal'),
                      ),
                      onPressed: () {
                        var isValid = formKey.currentState!.validate();
                        if (isValid) {
                          formKey.currentState!.save();
                          cubit.ForgetPassword(email);
                        }
                      }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
