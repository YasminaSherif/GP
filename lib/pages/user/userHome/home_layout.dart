

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortestpages/bloc/userData/cubit.dart';

import '../../../bloc/mainUser/cubit.dart';
import '../../../bloc/userHome/cubit.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _UserHome();
}

class _UserHome extends State<HomeLayout> {
  @override
  void initState(){
    super.initState();
    userDataCubit usercubit=BlocProvider.of<userDataCubit>(context);
    //  mainCubit maicCubit=BlocProvider.of<mainCubit>(context);
    usercubit.getUserData(); 
    // usercubit.GetRequests();
  }

  @override
  Widget build(BuildContext context) {

      return BlocConsumer<AppCubit , AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state){
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              unselectedItemColor: Colors.grey[400],
              selectedItemColor: Colors.grey[600],
              iconSize: 25,

              currentIndex: cubit.currentIndex,
              onTap:(index)
              {
                cubit.changeIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined,
                  ),
                  label: 'home',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.chat,
                    ),
                    label: 'chats'
                ),
              ],
            ),
          );
        } ,

      );
    
  }
}
