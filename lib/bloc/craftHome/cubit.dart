
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../pages/chat/chats_screen_worker.dart';
import '../../pages/worker/craft_home_screen/craft_home_screen.dart';
import '../../pages/worker/craft_profile_editing/craft_profile_editing.dart';
import '../../pages/worker/craft_profile_editing/settings.dart';


part 'states.dart';
class CraftCubit extends Cubit<CraftStates>
{
  CraftCubit() : super(CraftInitialState());

  static CraftCubit get(context) => BlocProvider.of(context);

  int currentIndex=0;

  List<Widget> screens= [
    const CraftHomeScreen(),
    const UserProfile(),
    ChatsScreen(),
  ];

  void changeIndex(int index)
  {
    currentIndex=index;
    emit(CraftChangeBottomNavBarState());
  }


}