import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormButton extends StatelessWidget{
   final Widget child;
   final Gradient? gradient;
   double width;
   double height;
   final VoidCallback onPressed;

   FormButton({
     Key? key,
     required this.child,
    this.gradient,
    this.width=300.0,
    this.height=50.0 ,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient:  LinearGradient(colors: <Color>[
                                const Color(0xffD9AD30),
                                Colors.amber.shade200,
                              ]),
        borderRadius: const BorderRadius.all(Radius.circular(11))
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Center(
            child: child,
          ),
        ),
      ),
    );
    throw UnimplementedError();
  }
  
}