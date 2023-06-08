import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        return (cubit.workersToChat == null)
            ? const Center(child: CircularProgressIndicator())
            : (cubit.workersToChat!.isEmpty)
                ? const Text("No Users Found")
                : ListView.builder(
                    itemBuilder: (context, index) =>
                        ChatItem(worker: cubit.workersToChat![index]),
                    itemCount: cubit.workersToChat!.length);
      },
    );
  }
}
