import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosque/component/components.dart';
import 'package:mosque/helper/cachhelper.dart';
import 'package:mosque/screen/Auth/login.dart';
import 'package:mosque/screen/userScreens/home/cubit/home_user_cubit.dart';
import 'package:mosque/screen/userScreens/home_screen.dart';
import 'package:mosque/screen/userScreens/profile/cubit/profile_cubit.dart';
import 'package:mosque/screen/userScreens/profile/update_form.dart';

class ProfileUser extends StatelessWidget {
  const ProfileUser({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          navigatAndFinish(context: context, page: const HomeScreen());
        }
      },
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                // navigatAndFinish(context: context, page: const HomeUser());
                Navigator.pop(context);
              },
            ),
            title: const Text('Profile'),
            actions: [
              TextButton(
                  onPressed: () {
                    navigatAndFinish(context: context, page: Login());
                    CachHelper.removdata(key: "TOKEN");
                    showToast(msg: "Disconnect", state: ToastStates.error);
                  },
                  child: const Text(
                    "Disconnect",
                    style: TextStyle(color: Colors.red),
                  ))
            ],
          ),
          body: BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {},
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  // mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: HomeUserCubit.get(context)
                                  .userDataModel!
                                  .photo !=
                              null
                          ? NetworkImage(
                              HomeUserCubit.get(context).userDataModel!.photo!)
                          : const AssetImage('assets/images/user.png')
                              as ImageProvider<Object>,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Nom'),
                      subtitle: Text(
                        HomeUserCubit.get(context).userDataModel!.nom!,
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Prenom'),
                      subtitle: Text(
                        HomeUserCubit.get(context).userDataModel!.prenom!,
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Age'),
                      subtitle: Text(
                        HomeUserCubit.get(context)
                            .userDataModel!
                            .age!
                            .toString(),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.email),
                      title: const Text('Email'),
                      subtitle: Text(
                        HomeUserCubit.get(context).userDataModel!.email!,
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.phone),
                      title: const Text('Phone'),
                      subtitle: Text(HomeUserCubit.get(context)
                          .userDataModel!
                          .telephone!
                          .toString()),
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        navigatAndReturn(
                            context: context, page: UpdateUserForm());
                      },
                      child: const Text('Edit Profile'),
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }
}
