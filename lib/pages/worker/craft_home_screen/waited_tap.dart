import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          color: Colors.grey[350],
          child: (state is getRequestLoadingsState)
              ? const Center(child: CircularProgressIndicator())
              : ( cubit.panding != null && cubit.panding!.isNotEmpty)
                  ? Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) =>
                            WaitedRequestItem(request: cubit.panding![index]),
                        separatorBuilder: (context, index) => const SizedBox(height: 5),
                        itemCount: cubit.panding!.length,
                      ),
                    )
                  : Center(
                      child: Text(
                        "لا يوجد طلبات",
                        style: TextStyle(
                          height: 1.0,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
        );
      },
    );
  }
}