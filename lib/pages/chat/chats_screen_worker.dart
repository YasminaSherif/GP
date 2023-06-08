import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fortestpages/bloc/workerData/cubit.dart';


import '../../bloc/chat/chat_cubit.dart';
import '../../bloc/userData/cubit.dart';
import 'components/chat_item_worker.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<workerDataCubit, workerDataStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = workerDataCubit.get(context);
        return (cubit.usersToChat == null)
            ? const Center(child: CircularProgressIndicator())
            : (cubit.usersToChat!.isNotEmpty)
                ? ListView.builder(
                    itemBuilder: (context, index) =>
                        ChatItem(user: cubit.usersToChat![index]),
                    itemCount: cubit.usersToChat!.length)
                : const Text("No Users Found");
      },
    );
  }
}
