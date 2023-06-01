
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortestpages/bloc/signin/cubit.dart';

import '../../pages/chats_screen.dart';
import '../../pages/user/userHome/userHome.dart';
import '../../pages/user/settings.dart';
import '../../models/loginDataResponse.dart';

part 'states.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
   
  int currentIndex=0;
  
  List<Widget> screens= [
    HomeScreen(),
    const UserProfile(),
    const ChatsScreen(),
  ];

void changeIndex(int index)
{
  currentIndex=index;
  emit(AppChangeBottomNavBarState());
}


}
