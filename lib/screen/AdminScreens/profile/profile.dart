import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosque/Model/admin_medel.dart';
import 'package:mosque/component/components.dart';
import 'package:mosque/helper/cachhelper.dart';
import 'package:mosque/screen/AdminScreens/home/cubit/home_admin_cubit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mosque/screen/AdminScreens/home/home.dart';
import 'package:mosque/screen/AdminScreens/profile/cubit/profile_admin_cubit.dart';
import 'package:mosque/screen/AdminScreens/profile/update_form.dart';
import 'package:mosque/screen/Auth/login.dart';
import 'package:mosque/screen/AdminScreens/profile/update_mdp.dart';

class ProfileAdmin extends StatelessWidget {
  const ProfileAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final DataAdminModel adminModel = HomeAdminCubit.get(context).adminModel!;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          // Navigator.pop(context);
          navigatAndFinish(context: context, page: const HomeAdmin());
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
              ),
            ),
          ],
        ),
        drawer: _buildDrawer(context, adminModel),
        body: BlocConsumer<ProfileAdminCubit, ProfileAdminState>(
          listener: (context, state) {},
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: adminModel.photo != null
                        ? NetworkImage(adminModel.photo!)
                        : const AssetImage('assets/images/user.png')
                            as ImageProvider<Object>,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    adminModel.username!,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildProfileCard(context, adminModel),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: defaultSubmit3(
                      text: 'Edit Profile',
                      onPressed: () {
                        navigatAndReturn(
                          context: context,
                          page: const UpdateAdminForm(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context, DataAdminModel adminModel) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildListTile(
              context,
              icon: Icons.person,
              title: 'nom',
              subtitle: adminModel.nom!,
            ),
            _buildListTile(
              context,
              icon: Icons.person,
              title: 'prenom',
              subtitle: adminModel.prenom!,
            ),
            _buildListTile(
              context,
              icon: Icons.email_outlined,
              title: 'email',
              subtitle: adminModel.email!,
            ),
            _buildListTile(
              context,
              icon: Icons.phone,
              title: 'phone',
              subtitle: adminModel.telephone!.toString(),
            ),
          ],
        ),
      ),
    );
  }

  ListTile _buildListTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(subtitle, style: GoogleFonts.poppins()),
      trailing: trailing,
      onTap: () {},
    );
  }

  Drawer _buildDrawer(BuildContext context, DataAdminModel adminModel) {
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
                  radius: 40,
                  backgroundImage: adminModel.photo != null
                      ? NetworkImage(adminModel.photo!)
                      : const AssetImage('assets/images/user.png')
                          as ImageProvider<Object>,
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text('home', style: GoogleFonts.poppins()),
            onTap: () {
              navigatAndFinish(context: context, page: const HomeAdmin());
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: Text('modify_profile', style: GoogleFonts.poppins()),
            onTap: () {
              navigatAndReturn(
                context: context,
                page: const UpdateAdminForm(),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: Text('modify_password', style: GoogleFonts.poppins()),
            onTap: () {
              navigatAndReturn(context: context, page: UpdateMdpForm());
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
              HomeAdminCubit.get(context).resetValues();
              ProfileAdminCubit.get(context).resetValues();
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
