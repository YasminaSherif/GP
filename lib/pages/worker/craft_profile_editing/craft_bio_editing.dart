import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../bloc/workerData/cubit.dart';
import '../../../customized/FormButton.dart';
//import 'cubit/cubit.dart';

class CraftInfoEditing extends StatelessWidget {
  const CraftInfoEditing({super.key});

  @override
  Widget build(BuildContext context) {
    String bio = '';
    return BlocConsumer<workerDataCubit, workerDataStates>(
      listener: (context, state) {
        if (state is UpdateProfileSuccessful) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('تم التغير بنجاح')));
        }
      },
      builder: (context, state) {
        var cubit = workerDataCubit.get(context);

        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              color: Colors.grey[250],
              child: Column(children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                        height: 117.h,
                        color: const Color(0xffD9AD30),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back_outlined,
                                    color: Colors.black,
                                  )),
                            ])),
                  ],
                ),
                SizedBox(
                  height: 100.h,
                ),

                Padding(
                  padding: EdgeInsets.only(left: 15.r, right: 15.r),
                  child: TextFormField(
                    onChanged: (value) {
                      bio = value;
                    },
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                        hintText: 'ادخل معلومات عملك',
                        hintStyle: const TextStyle(color: Colors.black45),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 50.r, horizontal: 10.r),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5).r)),
                  ),
                ),

                SizedBox(
                  height: 45.h,
                ),
                // the button
                Padding(
                  padding:
                      EdgeInsets.only(left: 20.r, right: 20.r, bottom: 150.r),
                  child: FormButton(
                      gradient: LinearGradient(colors: <Color>[
                        const Color(0xffD9AD30),
                        Colors.amber.shade200,
                      ]),
                      onPressed: () {
                        cubit.updateWorker(
                          firstName: null,
                          lastName: null,
                          bio: bio,
                          username: null,
                          location: null,
                          phoneNumber: null,
                          profilePic: null,
                          workImage: null,
                        );
                      },
                      child: const Text(
                        'حفظ',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )),
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}
