
////////////////////////////////////////// SIGN IN PAGE //////////////////////////////////////

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fortestpages/customized/FormButton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortestpages/services/methods/navigation.dart';
import 'package:fortestpages/pages/user/userHome/home_layout.dart';
import 'package:fortestpages/src/const.dart';
import '../../bloc/signin/cubit.dart';
import '../worker/craft_home_layout.dart';
import 'ForgetPassword.dart';
import 'buildTextFormField.dart';
import 'Register.dart';

class SignIn extends StatelessWidget {

  //late SignInDetails info;

  bool isObscurePassword = true;
  String email="";
  String password="" ;


  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInStates>(
        listener:(context, state){
          if(state is SignInUserSuccessfulState){
            Constant.saveData(
                    key: "id", value: state.userResponse.data!.id);
            navigateAndNotBack(context,const HomeLayout());
          }
          if(state is SignInWorkerSuccessfulState){
            Constant.saveData(
                    key: "id", value: state.workerResponse.data!.id);
            navigateAndNotBack(context,const CraftHomeLayout());
          }
          if(state is SignInFailState){
             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text('invalid Credentials')));
          }
          
        },
        builder: (context, state)
        {
          var cubit=SignInCubit.get(context);
          return Scaffold(
            body: Container(
              height: double.infinity,
              color: Colors.grey[250],
             // padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
              child: Form(
                key: formKey,
                child: GestureDetector(
                  onTap: (){
                    FocusScope.of(context).unfocus();
                  },

                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Center(
                        //   child: Stack(
                        //     children: [
                        //       Container(
                        //         width: 130,
                        //         height: 130,
                        //         decoration: BoxDecoration(
                        //             border: Border.all(width: 4, color: Colors.white),
                        //             image: const DecorationImage(
                        //               fit: BoxFit.cover,
                        //               image: AssetImage('assets/og-sign-in.png'),
                        //             )
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        Container(
                          width: 400.w,
                          height: 200.h,
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              image: DecorationImage(
                                  image: AssetImage('assets/Sign-In.png'))
                          ),
                        ),

                         
                         Center(
                            child: Padding(
                              padding:  EdgeInsets.only(top: 11.r, bottom: 25.r),
                              child: Text(
                                'تسجيل الدخول',
                                style: TextStyle( fontWeight: FontWeight.bold, fontSize: 25.sp ),),
                            )),
                        
                        // email
                        buildTextFormField(
                            validator: (email){
                              if (email!.isEmpty || !email.contains('@') || !email.contains('.com')){
                                return 'بريد الالكترونى غير صحيح';  } },
                            hintText:  'البريد الالكترونى',
                            obscureText: false,
                            onSaved: (value){
                              email = value!;
                            },
                            icon: const Icon(Icons.email_outlined, color: Colors.amber)),

                         SizedBox(height: 25.h,),
                        // password
                        buildTextFormField(
                            validator: (password){
                              if(password!.isEmpty || password.length < 6 ){
                                return 'Password should be at least 6 char ';}},
                            hintText:  'كلمة المرور',
                            obscureText: true,
                            onSaved: (value){
                              password = value!;
                            },
                            icon: const Icon(Icons.remove_red_eye_outlined, color: Colors.amber,)
                        ),
                         SizedBox(height: 30.h,), (state is SignInLoadingState)
                       ?const Center(
                       child: CircularProgressIndicator())
                       
                       :FormButton(
                      
                        
                      onPressed: (){
                            final isValid = formKey.currentState!.validate();
                            if(isValid){
                              formKey.currentState!.save();
                              cubit.login(email, password);
                            }
                          },
                            child:
                            const Text('تسجيل',
                            style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),)
                        ),

                         SizedBox(height: 10.h,),
                        TextButton(
                          onPressed: (){
                           navigateWithBack(context,ForgetPassword());
                          },
                          child:  Text('نسيت كلمة المرور', style: TextStyle(fontSize: 16.sp, color: Colors.black,decoration: TextDecoration.underline),),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [

                            TextButton(
                              onPressed: (){
                                navigateWithBack(context, RegisterForm());
                              },
                              child:  Text('انشاء حساب جديد', style: TextStyle(fontSize: 14.sp, color: Colors.black,decoration: TextDecoration.underline),),
                            ),
                            const Text('عندك حساب ؟'),
                          ],
                        )


                      ],
                    ),
                  ),

                ),
              ),
            ),
          );
        },
      );
    
  }
}

