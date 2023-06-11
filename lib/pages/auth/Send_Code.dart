import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fortestpages/customized/FormButton.dart';
import 'package:fortestpages/pages/auth/SignIn.dart';
import '../../bloc/signin/cubit.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../services/methods/navigation.dart';
import 'buildTextFormField.dart';

class Code extends StatelessWidget {
  Code({Key? key,required this.email}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  String email;
  String password = '';
  String confirmPassword = '';
  var requiredValue = '';
  var confirmPass;
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SignInCubit, SignInStates>(
      listener: (context, state){
        if(state is resetPasswordCodeSuccessfulState){
          navigateWithBack(context, SignIn());
        }
      },
      builder: (context, state){
        var cubit=SignInCubit.get(context);
        return Scaffold(
          backgroundColor: const Color(0xffF6F6F6),
          body: Form(
            key: formKey,
            child: ListView(
              children: [
                Container(
                  width: 400.w,
                  height: 200.h,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 20.r),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage('assets/Sign-In.png'))
                  ),
                ),

                const SizedBox(height: 12,),
                const Text('ادخل الكود المرسل',
                  textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w700 ,fontSize: 20, fontFamily: 'Tajawal'),),
                const SizedBox(height: 15,),
                // Code Style
                Container(
                  padding:  EdgeInsets.only(left: 10.r, right: 10.r),

                  child: PinCodeTextField(
                    autoFocus: true,
                    appContext: context,
                    pastedTextStyle: TextStyle(
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 6,
                    obscuringCharacter: '*',
                    obscuringWidget: const FlutterLogo(
                      size: 24,
                    ),
                    blinkWhenObscuring: true,
                    animationType: AnimationType.fade,
                    validator: (v) {
                      if (v!.length < 3) {
                        return "ادخل الكود المرسل";
                      } else {
                        return null;
                      }
                    },
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50.h,
                        fieldWidth: 45.w,
                        inactiveColor: Colors.white,
                        activeColor: Colors.greenAccent,
                        selectedColor: Colors.amberAccent,
                        inactiveFillColor: Colors.amber,
                        activeFillColor: Colors.purple

                    ),
                    onCompleted: (value){
                      if(value == requiredValue){
                        formKey.currentState!.validate();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Code is right')));
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('invalid Code')));
                      }
                    },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(6),
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9!]')),
                      FilteringTextInputFormatter.deny(RegExp(r'[/\\!@#^&*()_+$]'))],
                    onChanged: (value) {
                      debugPrint(value);
                      cubit.setValue(value);
                    },),
                ),
                const SizedBox(height: 15,),

                //Current Password
                buildTextFormField
                  (
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
                  isSuffix: false,
                  hintText: 'كلمة السر الحالية',
                  onSaved:(value){
                    password = value!;
                  },
                  obscureText: false,
                  icon: const Icon(Icons.remove_red_eye_outlined, color: Colors.amberAccent,),
                ),
                const SizedBox(height: 15,),
                // CONFIRM PASSWORD
                buildTextFormField
                  (
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
                  onPressed: (){

                  },
                  hintText: 'تاكيد كلمة السر',
                  onSaved:(value){
                    confirmPassword = value!;
                  },
                  obscureText: false,
                  icon: const Icon(Icons.remove_red_eye_outlined, color: Colors.amberAccent,),
                ),
                const SizedBox(height: 20,),

                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 50.r, right: 50.r),
                  child: FormButton(
                    width: 60.w,
                    height: 45.h,
                    child: const Text(
                      'ارسال',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17.5,fontFamily: 'Tajawal'),
                    ),
                    onPressed: () {
                      var isValid = formKey.currentState!.validate();
                      if (isValid) {
                        formKey.currentState!.save();
                        cubit.checkForgetCode(email, password, confirmPassword);
                      }
                    },
                  ),
                ),

                const SizedBox(height: 12,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {

                      },
                      child: const Text(
                        "ارسال مجددا",
                        style: TextStyle(
                            color: Color(0xFF91D3B3),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,fontFamily: 'Tajawal'),
                      ),
                    ),
                    Text(
                      "لم تستلم الكود؟",
                      style: TextStyle(color: Colors.black54, fontSize: 15.sp,fontFamily: 'Tajawal'),
                    ),

                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}