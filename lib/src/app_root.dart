import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortestpages/bloc/workerData/cubit.dart';

import '../bloc/craftHome/cubit.dart';
import '../bloc/register/cubit.dart';
import '../bloc/signin/cubit.dart';
import '../bloc/userData/cubit.dart';
import '../bloc/userHome/cubit.dart';
import '../bloc/mainUser/cubit.dart';
import '../pages/auth/SignIn.dart';
import '../pages/starting_page.dart';


class AppRoot extends StatelessWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()),
        BlocProvider(create: (context) => SignInCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => userDataCubit()),
        BlocProvider(create: (context) => mainCubit()),
        BlocProvider(create: (context) => workerDataCubit()),
        BlocProvider(create: (context) => CraftCubit()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StartingPage(),
      ),
    );
  }
}
