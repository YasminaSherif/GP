import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fortestpages/customized/FormButton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/methods/navigation.dart';
import '../../bloc/signin/cubit.dart';
import 'Send_Code.dart';



class ForgetPassword extends StatelessWidget {
   ForgetPassword({Key? key}) : super(key: key);
   final formKey = GlobalKey<FormState>();
   String email = '';
  @override
  Widget build(BuildContext context) {

    //String password = '';

      return BlocConsumer<SignInCubit, SignInStates>
        (
        listener: (context, state){
          if(state is ForgetPasswordSuccessfulState){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text(' تم ارسال الكود')));
            navigateWithBack(context, Code(email: state.email,));
          }
        },
        builder: (context, state){
          var cubit=SignInCubit.get(context);
          return Scaffold(
            backgroundColor:Colors.grey[250],
            body: Padding(
              padding: EdgeInsets.only(left: 10.r, right: 10.r),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
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
                              padding:  EdgeInsets.only(top: 10.r, bottom: 40.r),
                              child: Text(
                               'نسيت كلمة المرور',
                                style: TextStyle( fontWeight: FontWeight.bold, fontSize: 25.sp ),),
                            )),
                    //email
                    Padding(
                      padding: EdgeInsets.only(left: 10.r, right: 10.r),
                      child: TextFormField(
                        validator: (email){
                          if (email!.isEmpty || !email.contains('@') || !email.contains('.com')){
                            return 'Invalid E-mail';  } },
                        onSaved: (value){
                          email = value!;
                          //print(email);
                        },
                        decoration: InputDecoration(
                            hintText: 'الايميل',
                            hintStyle: const TextStyle(color: Colors.black26,),
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: IconButton(
                              icon: const Icon(Icons.email_rounded, color: Colors.grey,),
                              onPressed: (){
                                // setState(() {
                                // });
                              },
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical:20.r ,horizontal:10.r),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10).r
                            )
                        ),
                      ),
                    ),
                     SizedBox(height: 10.h,),

                    //password
                     SizedBox(height: 20.h,),

                    // Button
                    Padding(
                      padding: EdgeInsets.only(left: 30.r, right: 30.r),
                      child: FormButton(
                          width: 300.w,
                         gradient: LinearGradient(colors: <Color>[
                                const Color(0xffD9AD30),
                                Colors.amber.shade200,
                              ]),
child:
                            const Text('ارسال الكود',
                            style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),),                       
                       onPressed: (){
                            formKey.currentState!.save();
                            cubit.ForgetPassword(email);
                          }),
                    ),

                  ],
                ),
              ),
            ),
          );
        },
      );
  }
}
