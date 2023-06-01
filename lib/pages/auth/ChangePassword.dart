import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/userData/cubit.dart';
import 'buildTextFormField.dart';


import '../../customized/FormButton.dart';

class ChangePassword extends StatelessWidget {
   ChangePassword({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
   String password = "";
   String confirmP = '';
   String confirmNewP = '';

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
                          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),),
                        const SizedBox(height: 12,),
                        //email


                        const Text('', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),),
                        const SizedBox(height: 10,),
                        //password
                        buildTextFormField
                          (
                          validator: (password){
                            if(password!.isEmpty || password.length < 6 ){
                              return 'Password should be at least 6 char ';}
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

                        //Confirm
                        buildTextFormField(
                          validator: (confirm) {
                            if (confirm!.isEmpty ||
                                confirm.length < 6 /*|| password != confirmP*/) {
                              return 'Password should be match ';
                            }
                          },
                          isSuffix: true,
                          hintText: 'كلمة المرور الجديدة',
                          onSaved:(value){
                            confirmP = value!;
                          },
                          obscureText: true,
                          icon: const Icon(Icons.remove_red_eye_outlined, color: Colors.amberAccent,),
                        ),
                        // Button
                        const SizedBox(height: 20,),

                        //Confirm New password
                        buildTextFormField(
                          validator: (confirm) {
                            if (confirm!.isEmpty ||
                                confirm.length < 6 /*|| password != confirmP*/) {
                              return 'Password should be match ';
                            }
                          },
                          isSuffix: true,
                          hintText: 'تأكيد كلمة المرور الجديدة',
                          onSaved:(value){
                            confirmNewP = value!;
                          },
                          obscureText: true,
                          icon: const Icon(Icons.remove_red_eye_outlined, color: Colors.amberAccent,),
                        ),
                        const SizedBox(height: 80,),

                        FormButton(
                            width: 250,
                            height: 45,
                            child: const Text('حفظ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18.5),),
                            onPressed: (){
                              formKey.currentState!.save();
                              cubit.changePassword(confirmP, confirmNewP);
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
