import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fortestpages/bloc/workerData/cubit.dart';
import '../../bloc/chat/chat_cubit.dart';
import '../../bloc/userData/cubit.dart';
import 'components/chat_item_user.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<userDataCubit, userDataStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = userDataCubit.get(context);
        return  Container(
          color: Colors.grey[250],
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
            Stack(
            alignment: AlignmentDirectional.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                  height: 117.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.0).r,
                    color: const Color.fromRGBO(217, 173, 48, 1),
                  ),
              ),

            ],
          ),

          Padding(
                          padding: EdgeInsets.only(
                            right: 10.0.r,
                            top: 10.0.r,
                          ),
                          child: Text(' الرسائل',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18.0.sp,
                              fontFamily: 'Tajawal',
                            ),
                          ),
                        ),

         (cubit.workersToChat == null)
            ? const Center(child: CircularProgressIndicator())
            : (cubit.workersToChat!.isEmpty)
                ? const Text("No Users Found")
                : ListView.separated(
                    itemBuilder: (context, index) =>
                        ChatItem(worker: cubit.workersToChat![index]),
                        separatorBuilder: (context, index) =>
                                             Divider(height: 15.h),
                    itemCount: cubit.workersToChat!.length)


              ]
          ),
       
        );
      },
    );
  }
}
