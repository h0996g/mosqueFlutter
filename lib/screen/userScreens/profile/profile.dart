import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosque/component/cache_network_img.dart';
import 'package:mosque/component/components.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mosque/cubit/main_cubit.dart';
import 'package:mosque/helper/cachhelper.dart';
import 'package:mosque/model/user_model.dart';
import 'package:mosque/screen/Auth/login.dart';
import 'package:mosque/screen/userScreens/home/cubit/home_user_cubit.dart';
import 'package:mosque/screen/userScreens/lesson/cubit/lesson_cubit.dart';
import 'package:mosque/screen/userScreens/profile/cubit/profile_cubit.dart';
// import 'package:mosque/screen/userScreens/profile/cubit/profile_cubit.dart';
import 'package:mosque/screen/userScreens/profile/update_form.dart';
import 'package:mosque/generated/l10n.dart';
import 'package:mosque/screen/userScreens/profile/update_mdp.dart'; // Import your localization file

class ProfileUser extends StatelessWidget {
  const ProfileUser({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          // navigatAndFinish(context: context, page: const HomeScreen());
          Navigator.pop(context);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            leading: Builder(
              builder: (context) {
                return IconButton(
                  color: Colors.black,
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
            title: Text(S.of(context).profile), // Updated
          ),
          drawer:
              _buildDrawer(context, HomeUserCubit.get(context).userDataModel!),
          body: BlocConsumer<HomeUserCubit, HomeUserState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is GetMyInformationLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 50,
                      backgroundImage: HomeUserCubit.get(context)
                                  .userDataModel!
                                  .photo !=
                              null
                          ? CachedNetworkImageWidgetProvider.getImageProvider(
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
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: defaultSubmit(
                          text: S.of(context).edit_profile, // Updated
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
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildListTile(context,
                icon: Icons.person,
                title: S.of(context).nom,
                subtitle: joueurModel.nom!), // Updated
            _buildListTile(context,
                icon: Icons.person,
                title: S.of(context).prenom, // Updated
                subtitle: joueurModel.prenom!),
            _buildListTile(context,
                icon: Icons.email_outlined,
                title: S.of(context).email, // Updated
                subtitle: joueurModel.email!),
            _buildListTile(context,
                icon: Icons.phone,
                title: S.of(context).phone, // Updated
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 40,
                  backgroundImage: joueurModel.photo != null
                      ? CachedNetworkImageWidgetProvider.getImageProvider(
                          joueurModel.photo!)
                      : const AssetImage('assets/images/user.png'),
                )
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text(S.of(context).home,
                style: GoogleFonts.poppins()), // Updated
            onTap: () {
              // navigatAndFinish(context: context, page: const HomeScreen());
              // Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: Text(S.of(context).modify_profile,
                style: GoogleFonts.poppins()), // Updated
            onTap: () {
              navigatAndReturn(context: context, page: UpdateUserForm());
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: Text(S.of(context).modify_password,
                style: GoogleFonts.poppins()), // Updated
            onTap: () {
              navigatAndReturn(context: context, page: UpdateMdpForm());
            },
          ),
          ListTile(
            leading: const Icon(Icons.translate),
            title: Text(S.of(context).change_language,
                style: GoogleFonts.poppins()), // Updated
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(S.of(context).change_language,
                      style: GoogleFonts.poppins()), // Updated
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: Text("English",
                            style: GoogleFonts.poppins()), // Updated
                        onTap: () {
                          MainCubit.get(context)
                              .changeLanguage(const Locale('fr'));
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: Text("العربية",
                            style: GoogleFonts.poppins()), // Updated
                        onTap: () {
                          MainCubit.get(context)
                              .changeLanguage(const Locale('ar'));
                          Navigator.pop(context);
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
            title: Text(S.of(context).logout,
                style: GoogleFonts.poppins()), // Updated
            onTap: () async {
              navigatAndFinish(context: context, page: Login());
              CachHelper.removdata(key: "TOKEN");
              HomeUserCubit.get(context).resetValues();
              LessonCubit.get(context).resetValues();
              ProfileUserCubit.get(context).resetValues();
              showToast(
                  msg: S.of(context).disconnect,
                  state: ToastStates.error); // Updated
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_support),
            title: Text(S.of(context).contact_us,
                style: GoogleFonts.poppins()), // Updated
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
