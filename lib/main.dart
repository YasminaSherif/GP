//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortestpages/src/app_root.dart';
import 'package:fortestpages/src/const.dart';

import 'bloc/bloc_observer.dart';
void main()async{
WidgetsFlutterBinding.ensureInitialized();
await Constant.init();
//await Firebase.initializeApp();
BlocOverrides.runZoned(
() => runApp(const AppRoot()),
blocObserver: MyBlocObserver()
);

}


