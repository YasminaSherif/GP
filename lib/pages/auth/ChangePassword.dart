import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../bloc/userData/cubit.dart';
import 'buildTextFormField.dart';


import '../../customized/FormButton.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  String password = "";
  String confirmP = '';
  String confirmNewP = '';
  var confirmPass;

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<userDataCubit, userDataStates>(
      listener: (context, state){
        if(state is changePasswordSuccessfulState){
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('لقد تم التغيير بنجاح')));
        } else if(state is changePasswordFailState){
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('حدث خطأ ما')));
        }
      },
      builder: (context, state){
        var cubit=userDataCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(217, 173, 48, 1),
            toolbarHeight: 100,
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),

          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height:10),
                Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 15,),
                        const Text('تغيير كلمة المرور',
                          textAlign: TextAlign.right,
                          style: TextStyle(fontFamily: 'Tajawal',fontWeight: FontWeight.w900, fontSize: 20),),
                        const SizedBox(height: 12,),

                        const Text('', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),),
                        const SizedBox(height: 10,),
                        //password
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
                          isSuffix: true,
                          hintText: 'كلمة المرور الحالية',
                          onSaved:(value){
                            password = value!;
                          },
                          obscureText: true,
                          icon: const Icon(Icons.remove_red_eye_outlined, color: Colors.amberAccent,),
                        ),
                        const SizedBox(height: 20,),

                        //new password
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

                          icon: const Icon(
                            Icons.visibility,
                            color: Colors.amberAccent,
                          ),
                        ),
                        // Button
                        const SizedBox(height: 20,),

                        //Confirm New password
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
                          icon: const Icon(
                            Icons.visibility,
                            color: Colors.amberAccent,
                          ),
                        ),
                        const SizedBox(height: 80,),

                        FormButton(
                            width: 250.w,
                            height: 45.h,
                            child: const Text('حفظ', style: TextStyle(fontFamily: 'Tajawal', color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.5),),
                            onPressed: (){
                              var isValid = formKey.currentState!.validate();

                              if(isValid) {
                                formKey.currentState!.save();
                                cubit.changePassword(confirmP, confirmNewP);
                              }
                            }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

  }
}
