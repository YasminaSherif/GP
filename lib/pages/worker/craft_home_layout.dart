


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/craftHome/cubit.dart';
import '../../bloc/workerData/cubit.dart';


class CraftHomeLayout extends StatefulWidget {
  const CraftHomeLayout({Key? key}) : super(key: key);
  @override
  State<CraftHomeLayout> createState() => _CraftHome();
}

  class _CraftHome extends State<CraftHomeLayout> {
  @override
  void initState() {
  super.initState();
  workerDataCubit workerCubit = BlocProvider.of<workerDataCubit>(context);
  workerCubit.getworker();
  workerCubit.GetRequests();
}

  @override
  Widget build(BuildContext context) {
  
      return BlocConsumer<CraftCubit , CraftStates>(
        listener: (BuildContext context, CraftStates state) {},
        builder: (BuildContext context, CraftStates state){
          CraftCubit cubit = CraftCubit.get(context);
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
              items:    const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined,
                  ),
                  label: 'home',
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_pin,
                    ),
                    label: 'profile'
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
