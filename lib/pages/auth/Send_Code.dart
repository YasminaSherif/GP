import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                    width: 400,
                    height: 200,
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            image: AssetImage('assets/Sign-In.png'))
                    ),
                  ),

                  const SizedBox(height: 15,),
                  const Text('Enter the sent code',
                    textAlign: TextAlign.center ,style: TextStyle(fontSize: 20),),
                  const SizedBox(height: 15,),
                  // Code Style
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),

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
                          return "I'm from validator";
                        } else {
                          return null;
                        }
                      },
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 45,
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
                    validator: (password){
                      if(password!.isEmpty || password.length < 6 ){
                        return 'Password should be at least 6 char ';}
                      return 'well done'; },
                    isSuffix: false,
                    hintText: 'Current Password',
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
                    validator: (confirmPassword){
                      if(confirmPassword!.isEmpty || confirmPassword.length < 6 ){
                        return 'Password should be at least 6 char ';}
                      return 'well done'; },
                    isSuffix: false,
                    hintText: 'Confirm Password',
                    onSaved:(value){
                      confirmPassword = value!;
                    },
                    obscureText: false,
                    icon: const Icon(Icons.remove_red_eye_outlined, color: Colors.amberAccent,),
                  ),
                  const SizedBox(height: 20,),



                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: FormButton(
                        gradient: LinearGradient(
                            colors: <Color>[ const Color.fromRGBO(217, 173, 48, 1) ,Colors.amber.shade200,]
                        ),
                        child: const Text('Send', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                        onPressed: (){
                          formKey.currentState!.save();
                          cubit.checkForgetCode(email, password, confirmPassword);
                        },),
                  ),

                  const SizedBox(height: 12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Didn't receive the code? ",
                        style: TextStyle(color: Colors.black54, fontSize: 15),
                      ),
                      TextButton(
                        onPressed: () {
                          
                        },
                        child: const Text(
                          "RESEND",
                          style: TextStyle(
                              color: Color(0xFF91D3B3),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      )
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
