import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../bloc/mainUser/cubit.dart';
import '../../../bloc/workerData/cubit.dart';
import 'waited_request_item.dart';

class WaitedTap extends StatelessWidget {
  const WaitedTap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<workerDataCubit, workerDataStates>(
      listener: (context, state) {
        // TODO: Implement listener
      },
      builder: (context, state) {
        var cubit = workerDataCubit.get(context);
        return Container(
          color: Colors.grey[250],
          child: (state is getRequestLoadingsState)
              ? const Center(child: CircularProgressIndicator())
              : ( cubit.panding != null && cubit.panding!.isNotEmpty)
                  ? Column(
                    children: [
                      Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) =>
                                WaitedRequestItem(request: cubit.panding![index]),
                            separatorBuilder: (context, index) =>  SizedBox(height: 5.h),
                            itemCount: cubit.panding!.length,
                          ),
                        ),
                    ],
                  )
                  : Center(
                      child: Text(
                        "لا يوجد طلبات",
                        style: TextStyle(
                          height: 1.0.h,
                          fontSize: 12.0.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
        );
      },
    );
  }
}