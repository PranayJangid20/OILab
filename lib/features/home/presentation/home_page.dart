import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oilab_task/features/auth/cubit/auth_cubit.dart';
import 'package:oilab_task/features/home/cubit/home_cubit.dart';
import 'package:oilab_task/features/home/widget/info_card.dart';
import 'package:oilab_task/utils/app_constant.dart';
import 'package:oilab_task/utils/healper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeCubit>().fetchUsers(1);
  }

  ScrollController scrollableController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppConstant.appName,
          style: Theme.of(context)
              .textTheme
              .displayLarge!
              .copyWith(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                context.read<AuthCubit>().logOutUser(context);
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: NotificationListener(
                onNotification: (ScrollNotification t) {
                  if (t.metrics.atEdge) {
                    if (t.metrics.pixels == t.metrics.maxScrollExtent) {
                      context.read<HomeCubit>().fetchUsers(
                          context.read<HomeCubit>().currentPage + 1);
                      'At bottom'.log();
                    } else {
                      'At top'.log();
                    }
                  }
                  return false;
                },
                child: ListView.builder(
                  controller: scrollableController,
                  itemCount: context.read<HomeCubit>().allUsers.length,
                  itemBuilder: (context, index) {
                    return InfoCard(
                        imageUrl:
                            context.read<HomeCubit>().allUsers[index].avatar,
                        email: context.read<HomeCubit>().allUsers[index].email,
                        firstName:
                            context.read<HomeCubit>().allUsers[index].firstName,
                        lastName:
                            context.read<HomeCubit>().allUsers[index].lastName);
                  },
                ),
              ),
            ),
            state is HomePageLoading
                ? const CircularProgressIndicator()
                : Container()
          ],
        );
      }),
    );
  }
}
