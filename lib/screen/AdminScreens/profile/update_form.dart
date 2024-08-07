import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mosque/Model/admin_medel.dart';
import 'package:mosque/component/cache_network_img.dart';
import 'package:mosque/component/components.dart';
import 'package:mosque/generated/l10n.dart';
import 'package:mosque/screen/AdminScreens/home/cubit/home_admin_cubit.dart';
import 'package:mosque/screen/AdminScreens/profile/cubit/profile_admin_cubit.dart';

class UpdateAdminForm extends StatefulWidget {
  const UpdateAdminForm({super.key});

  @override
  State<UpdateAdminForm> createState() => _UpdateAdminFormState();
}

class _UpdateAdminFormState extends State<UpdateAdminForm> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  late final DataAdminModel homeAdminCubit;

  @override
  void initState() {
    super.initState();
    homeAdminCubit = HomeAdminCubit.get(context).adminModel!;
    _userNameController.text = homeAdminCubit.username!;
    _nomController.text = homeAdminCubit.nom!;
    _prenomController.text = homeAdminCubit.prenom!;
    _ageController.text = homeAdminCubit.age!.toString();
    _telephoneController.text = homeAdminCubit.telephone!.toString();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _nomController.dispose();
    _prenomController.dispose();
    _ageController.dispose();
    _telephoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool canPop = true;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          if (canPop == true) {
            Navigator.pop(context);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).update),
          leading: IconButton(
            onPressed: () {
              if (canPop == true) {
                Navigator.pop(context);
              }
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BlocBuilder<ProfileAdminCubit, ProfileAdminState>(
                    builder: (context, state) {
                      if (state is UpdateAdminLoadingState) {
                        return const LinearProgressIndicator();
                      }
                      return const SizedBox();
                    },
                  ),
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      BlocBuilder<ProfileAdminCubit, ProfileAdminState>(
                        builder: (context, state) {
                          return CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: ProfileAdminCubit.get(context)
                                        .imageCompress !=
                                    null
                                ? FileImage(ProfileAdminCubit.get(context)
                                    .imageCompress!)
                                : homeAdminCubit.photo != null
                                    ? CachedNetworkImageWidgetProvider
                                        .getImageProvider(homeAdminCubit.photo!)
                                    : const AssetImage('assets/images/user.png')
                                        as ImageProvider<Object>,
                            radius: 60,
                          );
                        },
                      ),
                      IconButton(
                        splashRadius: double.minPositive,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => const SelectPhotoAlert(),
                          );
                        },
                        icon: const CircleAvatar(
                          child: Icon(
                            Icons.camera,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  defaultForm3(
                    controller: _userNameController,
                    textInputAction: TextInputAction.next,
                    labelText: S.of(context).username,
                    prefixIcon: const Icon(Icons.person),
                    valid: (value) {
                      if (value!.isEmpty) {
                        return S.of(context).usernameMustNotBeEmpty;
                      }
                    },
                    context: context,
                  ),
                  const SizedBox(height: 30),
                  defaultForm3(
                    controller: _nomController,
                    textInputAction: TextInputAction.next,
                    labelText: S.of(context).nom,
                    prefixIcon: const Icon(Icons.person),
                    valid: (value) {
                      if (value!.isEmpty) {
                        return S.of(context).nameMustNotBeEmpty;
                      }
                    },
                    context: context,
                  ),
                  const SizedBox(height: 20),
                  defaultForm3(
                    controller: _prenomController,
                    textInputAction: TextInputAction.next,
                    labelText: S.of(context).prenom,
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.transparent,
                    ),
                    type: TextInputType.text,
                    context: context,
                    valid: (value) {
                      if (value!.isEmpty) {
                        return S.of(context).prenomMustNotBeEmpty;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  defaultForm3(
                    controller: _ageController,
                    textInputAction: TextInputAction.next,
                    labelText: S.of(context).age,
                    prefixIcon: const Icon(Icons.location_city),
                    type: TextInputType.text,
                    valid: (value) {
                      if (value!.isEmpty) {
                        return S.of(context).ageMustNotBeEmpty;
                      }
                    },
                    context: context,
                  ),
                  const SizedBox(height: 20),
                  defaultForm3(
                    controller: _telephoneController,
                    textInputAction: TextInputAction.next,
                    labelText: S.of(context).telephone,
                    prefixIcon: const Icon(Icons.phone),
                    type: TextInputType.phone,
                    valid: (value) {
                      if (value!.isEmpty) {
                        return S.of(context).phoneMustNotBeEmpty;
                      }
                    },
                    context: context,
                  ),
                  const SizedBox(height: 50),
                  BlocConsumer<ProfileAdminCubit, ProfileAdminState>(
                    listener: (context, state) {
                      if (state is UpdateAdminLoadingState) {
                        canPop = false;
                      } else {
                        canPop = true;
                      }

                      if (state is UpdateAdminStateGood) {
                        HomeAdminCubit.get(context).getMyInfo().then((value) {
                          showToast(
                              msg: S.of(context).success,
                              state: ToastStates.success);
                          // Navigator.pushAndRemoveUntil(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const ProfileAdmin(),
                          //   ),
                          //   (route) => false,
                          // );
                        });
                        Navigator.pop(context);
                      }
                    },
                    builder: (context, state) {
                      return defaultSubmit(
                        text: S.of(context).update,
                        valid: () {
                          if (formkey.currentState!.validate()) {
                            if (state is UpdateAdminLoadingState) {
                              return null;
                            }
                            ProfileAdminCubit.get(context).updateAdmin(
                              userName: _userNameController.text,
                              nom: _nomController.text,
                              prenom: _prenomController.text,
                              telephone: _telephoneController.text,
                              age: _ageController.text,
                              deleteOldImage: homeAdminCubit.photo,
                            );
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SelectPhotoAlert extends StatelessWidget {
  const SelectPhotoAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).chooseSource),
      actions: [
        TextButton(
          onPressed: () async {
            Navigator.pop(context);
            await ProfileAdminCubit.get(context)
                .imagePickerProfile(ImageSource.camera);
          },
          child: Text(S.of(context).camera),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context);
            await ProfileAdminCubit.get(context)
                .imagePickerProfile(ImageSource.gallery);
          },
          child: Text(S.of(context).gallery),
        ),
      ],
    );
  }
}
