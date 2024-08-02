import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mosque/component/components.dart';
import 'package:mosque/generated/l10n.dart';
import 'package:mosque/model/user_model.dart';
import 'package:mosque/screen/userScreens/profile/cubit/profile_cubit.dart';
import 'package:mosque/screen/userScreens/profile/progress_user.dart';

class ProfileOtherStudent extends StatefulWidget {
  final String id;
  const ProfileOtherStudent({super.key, required this.id});

  @override
  State<ProfileOtherStudent> createState() => _ProfileOtherStudentState();
}

class _ProfileOtherStudentState extends State<ProfileOtherStudent> {
  late final DataUserModel user;
  ProfileUserCubit? _cubit;
  // ProfileUserCubit.get(context).getOtherUser(id: widget.id);
  @override
  void initState() {
    _cubit = ProfileUserCubit.get(context);
    _cubit!.getOtherUser(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileUserCubit, ProfileUserState>(
      listener: (context, state) {
        if (state is GetOtherUserStateGood) {
          user = state.model;
        }
      },
      builder: (context, state) {
        if (state is GetOtherUserLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
            appBar: AppBar(
              title: Text(S.of(context).profile), // Updated
              leading: IconButton(
                color: Colors.black,
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: user.photo != null
                        ? NetworkImage(user.photo!)
                        : const AssetImage('assets/images/user.png')
                            as ImageProvider<Object>,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    user.username!,
                    style: GoogleFonts.poppins(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  _buildProfileCard(context, user),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: buildSubmitButton(context, () {
                      navigatAndReturn(
                          context: context,
                          page: ProgressUserDetails(id: user.id!));
                    }, S.of(context).show_progress),
                  ),
                ],
              ),
            ));
      },
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
}
