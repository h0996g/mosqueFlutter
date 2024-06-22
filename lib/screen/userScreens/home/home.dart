import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosque/component/components.dart';
import 'package:mosque/screen/userScreens/home/cubit/home_user_cubit.dart';
import 'package:mosque/screen/userScreens/profile/profile.dart';

class HomeUser extends StatefulWidget {
  const HomeUser({super.key});

  @override
  State<HomeUser> createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  HomeUserCubit homeUserCubit = HomeUserCubit();
  @override
  void initState() {
    homeUserCubit = HomeUserCubit.get(context);
    homeUserCubit.getMyInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeUserCubit, HomeUserState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('HomeJouer'),
            actions: [
              // TextButton(
              //     onPressed: () {
              //       navigatAndReturn(context: context, page: const ProfileUser());
              //     },
              //     child: const Text("Profile"))

              state is GetMyInformationLoading
                  ? const Center(child: CircularProgressIndicator())
                  : InkWell(
                      onTap: () {
                        navigatAndReturn(
                            context: context, page: const ProfileUser());
                      },
                      child:
                          // Container(
                          //   padding: const EdgeInsets.all(8),
                          //   child: const Icon(Icons.person),
                          // ),
                          CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            HomeUserCubit.get(context).userDataModel!.photo !=
                                    null
                                ? NetworkImage(HomeUserCubit.get(context)
                                    .userDataModel!
                                    .photo!)
                                : const AssetImage('assets/images/user.png')
                                    as ImageProvider<Object>,
                      ),
                    ),
              const SizedBox(
                width: 16,
              )
            ],
          ),
          body: const Text('homeJoueur'),
        );
      },
    );
  }
}
