import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosque/component/components.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mosque/helper/cachhelper.dart';
import 'package:mosque/model/user_model.dart';
import 'package:mosque/screen/Auth/login.dart';
import 'package:mosque/screen/userScreens/home/cubit/home_user_cubit.dart';
import 'package:mosque/screen/userScreens/home/home_screen.dart';
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
            leading: Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
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
          drawer:
              _buildDrawer(context, HomeUserCubit.get(context).userDataModel!),
          body: BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {},
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  // mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
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
                    Text(
                      HomeUserCubit.get(context).userDataModel!.username!,
                      style: GoogleFonts.poppins(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    _buildProfileCard(
                        context, HomeUserCubit.get(context).userDataModel!),
                    const SizedBox(height: 30),
                    // ListTile(
                    //   leading: const Icon(Icons.person),
                    //   title: const Text('Nom'),
                    //   subtitle: Text(
                    //     HomeUserCubit.get(context).userDataModel!.nom!,
                    //   ),
                    //   onTap: () {},
                    // ),
                    // ListTile(
                    //   leading: const Icon(Icons.person),
                    //   title: const Text('Prenom'),
                    //   subtitle: Text(
                    //     HomeUserCubit.get(context).userDataModel!.prenom!,
                    //   ),
                    //   onTap: () {},
                    // ),
                    // ListTile(
                    //   leading: const Icon(Icons.person),
                    //   title: const Text('Age'),
                    //   subtitle: Text(
                    //     HomeUserCubit.get(context)
                    //         .userDataModel!
                    //         .age!
                    //         .toString(),
                    //   ),
                    //   onTap: () {},
                    // ),
                    // ListTile(
                    //   leading: const Icon(Icons.email),
                    //   title: const Text('Email'),
                    //   subtitle: Text(
                    //     HomeUserCubit.get(context).userDataModel!.email!,
                    //   ),
                    //   onTap: () {},
                    // ),
                    // ListTile(
                    //   leading: const Icon(Icons.phone),
                    //   title: const Text('Phone'),
                    //   subtitle: Text(HomeUserCubit.get(context)
                    //       .userDataModel!
                    //       .telephone!
                    //       .toString()),
                    //   onTap: () {},
                    // ),

                    const SizedBox(
                      height: 30,
                    ),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     navigatAndReturn(
                    //         context: context, page: UpdateUserForm());
                    //   },
                    //   child: const Text('Edit Profile'),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: defaultSubmit(
                          text: 'Edit Profile',
                          valid: () {
                            navigatAndReturn(
                                context: context, page: UpdateUserForm());
                          }),
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }

  Widget _buildProfileCard(BuildContext context, DataUserModel joueurModel) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // _buildListTile(
            //   context,
            //   icon: Icons.person_outline,
            //   title: 'username',
            //   subtitle: joueurModel.username!,
            //   trailing: IconButton(
            //     icon: const Icon(Icons.copy),
            //     onPressed: () {
            //       Clipboard.setData(ClipboardData(text: joueurModel.username!))
            //           .then((_) {
            //         showToast(
            //           msg: 'copy_username_success',
            //           state: ToastStates.error,
            //         );
            //       });
            //     },
            //   ),
            // ),

            _buildListTile(context,
                icon: Icons.person, title: 'nom', subtitle: joueurModel.nom!),
            _buildListTile(context,
                icon: Icons.person,
                title: 'prenom',
                subtitle: joueurModel.prenom!),
            // _buildListTile(context,
            //     icon: Icons.location_city,
            //     title: 'wilaya',
            //     subtitle: joueurModel.wilaya!),
            _buildListTile(context,
                icon: Icons.email_outlined,
                title: 'email',
                subtitle: joueurModel.email!),
            _buildListTile(context,
                icon: Icons.phone,
                title: 'phone',
                subtitle: joueurModel.telephone!.toString()),
          ],
        ),
      ),
    );
  }

  ListTile _buildListTile(BuildContext context,
      {required IconData icon,
      required String title,
      required String subtitle,
      Widget? trailing}) {
    return ListTile(
      leading: Icon(icon),
      title:
          Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: GoogleFonts.poppins()),
      trailing: trailing,
      onTap: () {},
    );
  }

  Drawer _buildDrawer(BuildContext context, DataUserModel joueurModel) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            // decoration: BoxDecoration(color: greenConst),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: joueurModel.photo != null
                      ? NetworkImage(joueurModel.photo!)
                      : const AssetImage('assets/images/football.png')
                          as ImageProvider<Object>,
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text('home', style: GoogleFonts.poppins()),
            onTap: () {
              navigatAndFinish(context: context, page: const HomeScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: Text('modify_profile', style: GoogleFonts.poppins()),
            onTap: () {
              navigatAndReturn(context: context, page: UpdateUserForm());
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: Text('modify_password', style: GoogleFonts.poppins()),
            onTap: () {
              // navigatAndReturn(context: context, page: UpdateMdpForm());
            },
          ),
          ListTile(
            leading: const Icon(Icons.translate),
            title: Text('change_language', style: GoogleFonts.poppins()),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('change_language', style: GoogleFonts.poppins()),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: Text('french', style: GoogleFonts.poppins()),
                        onTap: () {
                          // MainCubit.get(context)
                          //     .changeLanguage(const Locale('fr'));
                          // Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: Text('arabic', style: GoogleFonts.poppins()),
                        onTap: () {
                          // MainCubit.get(context)
                          //     .changeLanguage(const Locale('ar'));
                          // Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          ListTile(
            textColor: Colors.red,
            iconColor: Colors.red,
            leading: const Icon(Icons.exit_to_app),
            title: Text('logout', style: GoogleFonts.poppins()),
            onTap: () async {
              navigatAndFinish(context: context, page: Login());
              CachHelper.removdata(key: "TOKEN");
              showToast(msg: "Disconnect", state: ToastStates.error);
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_support),
            title: Text('contact_us', style: GoogleFonts.poppins()),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => ContactUsPage()),
              // );
            },
          ),
        ],
      ),
    );
  }
}
