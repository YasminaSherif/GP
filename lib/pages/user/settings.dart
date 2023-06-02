//import 'package:crafts/modules/user_profile/cubit/states.dart';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortestpages/pages/user/user_requests.dart';
import 'package:fortestpages/services/methods/navigation.dart';
//import '../../models/userModel.dart';
//import '../bloc/userProfile/cubit.dart';

import '../../bloc/userData/cubit.dart';
import '../auth/SignIn.dart';
import 'editUser.dart';
//import '../models/loginDataResponse.dart';



class UserProfile extends StatelessWidget {
    const UserProfile({Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
        return BlocConsumer<userDataCubit , userDataStates>(
          listener: ( context, state) {},
          builder: ( context, state){
            var cubit=userDataCubit.get(context);
            return Container(
              color: Colors.grey[300],
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          color: const Color.fromRGBO(217, 173, 48, 1),
                        ),
                        height: 117.0,

                        child: Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Icon(
                                Icons.arrow_back_sharp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (cubit.userResponse == null) const Center(child: CircularProgressIndicator()) 
                      else Positioned(
                        left: 110.0,
                        top: 75.0,
                        child: Column(
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children:
                              [

// CircleAvatar(
//   backgroundColor: Colors.transparent,
//   radius: 35.0,
//   child: CircleAvatar(
//     backgroundImage: MemoryImage(base64Decode(cubit.userResponse!.data!.image)),
//     radius: 35.0,
//     backgroundColor: Colors.transparent,
//   ),
// ),

//                                 CircleAvatar(
//   backgroundColor: Colors.transparent,
//   radius: 35.0,
//   child: CircleAvatar(
    
//     backgroundImage: MemoryImage(base64Decode(cubit.userResponse![0].image!)),
//     radius: 35.0,
//     backgroundColor: Colors.grey,
//   ),
// ),  

CircleAvatar(
  backgroundColor: Colors.transparent,
  radius: 35.0,
  child: CircleAvatar(
      
    backgroundImage: cubit.userResponse![0].image != null
        ? MemoryImage(base64Decode(cubit.userResponse![0].image!))
        : null,
    radius: 35.0,
    backgroundColor: Colors.grey,
  ),
),
                          

                              ],
                            ),

                            Text(cubit.userResponse![0].username,
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(cubit.userResponse![0].email,
                              style: const TextStyle(
                                color: Colors.grey,
                                height: 1.0,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 90),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: MaterialButton(onPressed: (){
                            navigateWithBack(context, ImagePicker());
                          },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children:  const [
                                Icon(
                                  Icons.navigate_before_outlined,
                                  size: 30,
                                  color: Colors.grey,
                                ),
                                Spacer(),
                                Text('معلومات شخصية',

                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w900,

                                  ),
                                ),
                                SizedBox(width: 8,),
                                Icon(
                                  Icons.person_3_outlined,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: MaterialButton(onPressed: (){
                            cubit.GetRequests();
                             navigateWithBack(context, UserRequests());
                          },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children:  const [
                                Icon(
                                  Icons.navigate_before_outlined,
                                  size:30,
                                  color: Colors.grey,

                                ),
                                Spacer(),
                                Text('طلباتي',

                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w900,

                                  ),
                                ),
                                SizedBox(width: 8,),
                                Icon(
                                  Icons.account_box_outlined,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: MaterialButton(onPressed: (){
                           
                          },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children:  const [
                                Icon(
                                  Icons.navigate_before_outlined,
                                  size: 30,
                                  color: Colors.grey,

                                ),
                                Spacer(),
                                Text('الاشعارات',

                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w900,

                                  ),
                                ),
                                SizedBox(width: 8,),
                                Icon(
                                  Icons.notifications_none_outlined,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: MaterialButton(onPressed: (){
                            cubit.logout();
                            navigateAndNotBack(context, SignIn());
                          },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children:  const [
                                Text('تسجيل خروج',

                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w900,

                                  ),
                                ),
                                SizedBox(width: 8,),
                                Icon(
                                  Icons.login_outlined,
                                  size: 18,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      

  }
}


















  



