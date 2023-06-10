import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fortestpages/pages/auth/SignIn.dart';
import 'package:fortestpages/pages/user/userHome/home_layout.dart';
import 'package:fortestpages/pages/worker/craft_home_layout.dart';
import 'package:fortestpages/src/const.dart';
import '../services/methods/navigation.dart';

class StartingPage extends StatefulWidget {
 const StartingPage({Key? key}) : super(key: key);
  @override
   State<StartingPage> createState() => _StartingPage();
   
  }


class _StartingPage extends State<StartingPage>  {
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () => navigateAndNotBack(context, chooseNextScreen()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width:double.infinity,
        color: const Color.fromRGBO(217, 173, 48, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
          Container(

            height: 120.h,
            width: 170.w,

            child: Image(
            fit: BoxFit.cover,
            image: AssetImage('assets/ficraft-removebg-preview.png',
    ),
            ),
          ),
             Text('حرفي',
              style: TextStyle(

                fontSize: 30.sp,
                fontWeight: FontWeight.w600,
                height: 0.8.h,
                fontFamily: 'Lemonada',
  
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget chooseNextScreen() {
    String? userId = Constant.getData(key: "userId");
    String? workerId = Constant.getData(key: "workerId");
    if (userId != null) {
      return const HomeLayout();
    }
    else if(workerId !=null){
      return const CraftHomeLayout();
    }
     else {
      return SignIn();
    }
  }
}
