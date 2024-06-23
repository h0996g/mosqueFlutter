import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mosque/component/components.dart';
import 'package:mosque/screen/userScreens/home/cubit/home_user_cubit.dart';
import 'package:mosque/screen/userScreens/profile/cubit/profile_cubit.dart';
import 'package:mosque/screen/userScreens/profile/profile.dart';

class UpdateUserForm extends StatefulWidget {
  final emailController = TextEditingController();

  UpdateUserForm({super.key});

  @override
  State<UpdateUserForm> createState() => _UpdateUserFormState();
}

class _UpdateUserFormState extends State<UpdateUserForm> {
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();
  HomeUserCubit homeUserCubit = HomeUserCubit();
  final formkey = GlobalKey<FormState>();
  @override
  void initState() {
    homeUserCubit = HomeUserCubit.get(context);
    _nomController.text = HomeUserCubit.get(context).userDataModel!.nom!;
    _prenomController.text = HomeUserCubit.get(context).userDataModel!.prenom!;
    _ageController.text =
        HomeUserCubit.get(context).userDataModel!.age!.toString();
    _emailController.text =
        HomeUserCubit.get(context).userDataModel!.email!.toString();
    _telephoneController.text =
        HomeUserCubit.get(context).userDataModel!.telephone!.toString();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nomController.dispose();
    _prenomController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _telephoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is UpdateUserStateGood) {
          HomeUserCubit.get(context).getMyInfo().then((value) {
            showToast(msg: "Succes", state: ToastStates.success);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const ProfileUser()),
              (route) => false,
            );
          });
        }
      },
      builder: (context, state) {
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) async {
            if (!didPop) {
              if (state is! UpdateUserLoadingState) {
                Navigator.pop(context);
              }
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Update"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: formkey,
                child: SingleChildScrollView(
                  child: Column(children: [
                    if (state is UpdateUserLoadingState)
                      const LinearProgressIndicator(),
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: ProfileCubit.get(context)
                                      .imageCompress !=
                                  null
                              ? FileImage(
                                  ProfileCubit.get(context).imageCompress!)
                              : HomeUserCubit.get(context)
                                          .userDataModel!
                                          .photo !=
                                      null
                                  ? NetworkImage(HomeUserCubit.get(context)
                                      .userDataModel!
                                      .photo!)
                                  : const AssetImage('assets/images/user.png')
                                      as ImageProvider<Object>,
                          radius: 60,
                        ),
                        IconButton(
                          splashRadius: double.minPositive,
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => const SelectPhotoAlert());
                          },
                          icon: const CircleAvatar(
                            child: Icon(
                              Icons.camera,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    defaultForm2(
                        controller: _nomController,
                        textInputAction: TextInputAction.next,
                        label: 'Nom',
                        prefixIcon: const Icon(Icons.person),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Name Must Be Not Empty";
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultForm2(
                        controller: _prenomController,
                        textInputAction: TextInputAction.next,
                        label: 'Prenom',
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.transparent,
                        ),
                        type: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Prenom Must Be Not Empty";
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultForm2(
                        controller: _ageController,
                        textInputAction: TextInputAction.next,
                        label: 'Age',
                        prefixIcon: const Icon(Icons.countertops_outlined),
                        type: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Age Must Be Not Empty";
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultForm2(
                        controller: _emailController,
                        textInputAction: TextInputAction.next,
                        label: 'Email',
                        prefixIcon: const Icon(Icons.email_outlined),
                        type: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email Must Be Not Empty";
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultForm2(
                        controller: _telephoneController,
                        textInputAction: TextInputAction.next,
                        label: 'Telephone',
                        prefixIcon: const Icon(Icons.phone),
                        type: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Phone Must Be Not Empty";
                          }
                        }),
                    const SizedBox(
                      height: 50,
                    ),
                    defaultSubmit3(
                        text: 'Update',
                        // background: Colors.grey,
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            // if (state is LodinUpdateResponsableState) {
                            //   return null;
                            // }
                            ProfileCubit.get(context).updateUser(
                              nom: _nomController.text,
                              prenom: _prenomController.text,
                              email: _emailController.text,
                              telephone: _telephoneController.text,
                              age: _ageController.text,
                            );
                          }
                        }),
                  ]),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SelectPhotoAlert extends StatelessWidget {
  const SelectPhotoAlert({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Choose the source :"),
      actions: [
        TextButton(
            onPressed: () async {
              // if (state
              //     is LodinUpdateResponsableState) {
              //   return null;
              // }
              Navigator.pop(context);
              await ProfileCubit.get(context)
                  .imagePickerProfile(ImageSource.camera);
            },
            child: const Text("Camera")),
        TextButton(
            onPressed: () async {
              // if (state
              //     is LodinUpdateResponsableState) {
              //   return null;
              // }
              Navigator.pop(context);
              await ProfileCubit.get(context)
                  .imagePickerProfile(ImageSource.gallery);
            },
            child: const Text("Gallery"))
      ],
    );
  }
}
