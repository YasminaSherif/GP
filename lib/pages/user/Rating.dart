import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortestpages/customized/FormButton.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fortestpages/pages/user/craft_profile/craft_profile.dart';
import '../../bloc/mainUser/cubit.dart';
import '../../bloc/userData/cubit.dart';
import '../../models/loginDataResponse.dart';
import '../../services/methods/navigation.dart';


class Rating extends StatelessWidget {
Rating({Key? key, required this.worker}) : super(key: key);
  workerData worker;
  String feedback='';
  @override
  double rating=0.0;
  Widget build(BuildContext context) {
  
    return BlocConsumer<userDataCubit, userDataStates>(
        listener:(context, state){
          if(state is sendReviewSuccessState){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text('تم ارسال التقييم،شكرا لك')));
            
          }
          if(state is sendReviewFaillState){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text('حدث خطاء ما حاول مره اخري')));
            
          }
        } ,
        builder:(context, state) {
           var cubit=userDataCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.center,
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                            width: 700,
                            height: 140,
                            color: const Color(0xffD9AD30),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  IconButton(
                                      onPressed: (){
                                        Navigator.of(context).pop();
                                      },
                                      icon: const Icon(Icons.arrow_back_outlined, color: Colors.black,)),
                                ])
                        ),

                        Positioned(

                          bottom: -110,
                          child: SizedBox(
                            height: 200,
                            width: 300,
                            child: Image.asset('assets/rating.png'),

                          ),
                        )

                      ],
                    ),
                    const SizedBox(height: 100,),
                    const Text('تقييم و تعليق',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),


                    const Text('تستطع مشاركتنا رايك الان عن طريق اختيار النجوم',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey),),

                    RatingBar.builder(
                        initialRating: rating,
                        minRating: 1,
                        allowHalfRating: true,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 2),
                        glowColor: Colors.yellow,
                        glowRadius: 3,
                        updateOnDrag: true,
                        //ignoreGestures: true,
                        itemCount: 5,
                        itemBuilder: (context,index ) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                         onRatingUpdate: (newRating) {
                         rating = newRating;
                         print('New rating: $rating');
                         },
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 15 , right: 15),
                      child: TextField(
                        onChanged:(newValue) {
                          feedback=newValue;
                        },
                        textAlign: TextAlign.end,
                        // validator: (email){
                        //   if (email!.isEmpty || !email.contains('@') || !email.contains('.com')){
                        //     return 'Invalid E-mail';  } },
                        // onSaved: (value){
                        //   email = value!;
                        //   print(email);
                        // },
                        decoration: InputDecoration(
                            hintText: 'ارسل تعليقك',
                            hintStyle: const TextStyle(color: Colors.black45),
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.2),
                            contentPadding: const EdgeInsets.symmetric(vertical:50 ,horizontal:10 ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(5)
                            )
                        ),
                      ),
                    ),

                    const SizedBox(height: 25,),
                    // the button
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: FormButton(
                          gradient: LinearGradient(
                              colors: <Color>[const Color(0xffD9AD30),Colors.amber.shade200,]
                          ),
                          onPressed: (){
                            //formKey.currentState!.save();
                            cubit.sendReview(rating,feedback, worker);
                          },
                          child:
                          const Text('ارسال التقييم', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)),
                    ),

                    // SizedBox(
                    //   height: 200,
                    //   width: 300,
                    //   child: Image.asset('assets/rating.png'),

                    // ),

                  ]
              ),
            ),
          );
        },
      );
  }
}

