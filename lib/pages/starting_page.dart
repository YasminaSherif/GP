import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fortestpages/pages/auth/SignIn.dart';

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
      () => navigateAndNotBack(context, SignIn()),
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

            height: 120,
            width: 170,

            child: Image(
            fit: BoxFit.cover,
            image: AssetImage('assets/ficraft-removebg-preview.png',
    ),
            ),
          ),
            const Text('حرفي',
              style: TextStyle(

                fontSize: 36,
                fontWeight: FontWeight.w600,
                height: 0.8
              ),
            ),
          ],
        ),
      ),
    );
  }

}