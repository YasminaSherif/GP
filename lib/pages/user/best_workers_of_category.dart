import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortestpages/pages/user/workerItem.dart';

import '../../bloc/mainUser/cubit.dart';
import 'package:flutter/material.dart';

class BestWorkersOfCategory extends StatelessWidget {
  const BestWorkersOfCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<mainCubit, mainStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit=mainCubit.get(context);
    return  Scaffold(
       body: Container(
          color: Colors.grey[250],
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
            Stack(
            alignment: AlignmentDirectional.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                  height: 117,
                  color: const Color(0xffD9AD30),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.arrow_back_outlined,
                              color: Colors.black,
                            )
                        ),
                      ]
                  )
              ),

            ],
          ),
           Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children:  const [
             Padding(
            padding: EdgeInsets.only(
            right: 10.0,
          ),
         child: Text('افضل الصنايعيه المتوفرين',
           style: TextStyle(
             fontWeight: FontWeight.w900,
             fontSize: 20.0,
           ),
         ),
       ),
       ]
       ),

      (state is getWorkersLoadingsState )
                ? const Center(child: CircularProgressIndicator())
         : (  cubit.catResponse == null )
                   ? const Center(
                        child: Text(
                          "لا يوجد عمال في هذه الفئه",
                          style: TextStyle(
                  height: 1.0,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                       ),
                      ))
                   :  Expanded(
                  child: ListView.separated(
                    itemBuilder:(context, index)=> workerOfCate(worker:cubit.catResponse![index]),
                    separatorBuilder:(context, index)=> const SizedBox(height: 5) ,
                    itemCount: cubit.catResponse!.length,
                  ),
                ),

]
       ),
    ),
    );
      }
    );
  
  }
}