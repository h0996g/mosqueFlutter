import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mosque/Model/admin_medel.dart';
import 'package:mosque/component/components.dart';
import 'package:mosque/cubit/main_cubit.dart';
import 'package:mosque/generated/l10n.dart';
import 'package:mosque/helper/cachhelper.dart';
import 'package:mosque/screen/AdminScreens/home/cubit/home_admin_cubit.dart';
import 'package:mosque/screen/AdminScreens/home/startPage.dart';
import 'package:mosque/screen/AdminScreens/profile/cubit/profile_admin_cubit.dart';
import 'package:mosque/screen/AdminScreens/profile/update_form.dart';
import 'package:mosque/screen/Auth/login.dart';
import 'package:mosque/screen/AdminScreens/profile/update_mdp.dart';

class ProfileAdmin extends StatelessWidget {
  const ProfileAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    // final DataAdminModel adminModel = HomeAdminCubit.get(context).adminModel!;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          // Navigator.pop(context);
          navigatAndFinish(context: context, page: const StartPageAdmin());
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
          title: Text(S.of(context).profile),
        ),
        drawer: _buildDrawer(context, HomeAdminCubit.get(context).adminModel!),
        body: BlocConsumer<HomeAdminCubit, HomeAdminState>(
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
                    radius: 50,
                    backgroundImage:
                        HomeAdminCubit.get(context).adminModel!.photo != null
                            ? NetworkImage(
                                HomeAdminCubit.get(context).adminModel!.photo!)
                            : const AssetImage('assets/images/user.png')
                                as ImageProvider<Object>,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    HomeAdminCubit.get(context).adminModel!.username!,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildProfileCard(
                      context, HomeAdminCubit.get(context).adminModel!),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: defaultSubmit(
                      text: S.of(context).editProfile,
                      valid: () {
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
      color: Colors.white,
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
              title: S.of(context).name,
              subtitle: adminModel.nom!,
            ),
            _buildListTile(
              context,
              icon: Icons.person,
              title: S.of(context).surname,
              subtitle: adminModel.prenom!,
            ),
            _buildListTile(
              context,
              icon: Icons.email_outlined,
              title: S.of(context).email,
              subtitle: adminModel.email!,
            ),
            _buildListTile(
              context,
              icon: Icons.phone,
              title: S.of(context).phone,
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
            title: Text(S.of(context).home, style: GoogleFonts.poppins()),
            onTap: () {
              // navigatAndFinish(context: context, page: const StartPageAdmin());
              Navigator.pop(context);
              Navigator.pop(context);
              // Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title:
                Text(S.of(context).modifyProfile, style: GoogleFonts.poppins()),
            onTap: () {
              navigatAndReturn(
                context: context,
                page: const UpdateAdminForm(),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: Text(S.of(context).modifyPassword,
                style: GoogleFonts.poppins()),
            onTap: () {
              navigatAndReturn(context: context, page: UpdateMdpForm());
            },
          ),
          ListTile(
            leading: const Icon(Icons.translate),
            title: Text(S.of(context).changeLanguage,
                style: GoogleFonts.poppins()),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(S.of(context).changeLanguage,
                      style: GoogleFonts.poppins()),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: Text("English", style: GoogleFonts.poppins()),
                        onTap: () {
                          MainCubit.get(context)
                              .changeLanguage(const Locale('fr'));
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: Text("العربية", style: GoogleFonts.poppins()),
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
            title: Text(S.of(context).logout, style: GoogleFonts.poppins()),
            onTap: () async {
              navigatAndFinish(context: context, page: Login());
              CachHelper.removdata(key: "TOKEN");
              HomeAdminCubit.get(context).resetValues();
              ProfileAdminCubit.get(context).resetValues();
              showToast(
                  msg: S.of(context).disconnect, state: ToastStates.error);
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_support),
            title: Text(S.of(context).contactUs, style: GoogleFonts.poppins()),
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
