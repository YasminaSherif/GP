import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/mainUser/cubit.dart';
import '../../../bloc/workerData/cubit.dart';
import 'accepted_request_item.dart';

class AcceptedTap extends StatelessWidget {
  const AcceptedTap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<workerDataCubit, workerDataStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = workerDataCubit.get(context);
        return Container(
          color: Colors.grey[350],
          child: (state is getRequestLoadingsState)
              ? const Center(child: CircularProgressIndicator())
              : (state is getRequestSuccessState || cubit.accepted != null && cubit.accepted!.isNotEmpty)
                  ? Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) =>
                            AcceptedRequestItem(request: cubit.accepted![index]),
                        separatorBuilder: (context, index) => const SizedBox(height: 5),
                        itemCount: cubit.accepted!.length,
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