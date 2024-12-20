import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mosque/component/cache_network_img.dart';
import 'package:mosque/component/components.dart';
import 'package:mosque/screen/userScreens/home/cubit/home_user_cubit.dart';
import 'package:mosque/screen/userScreens/profile/cubit/profile_cubit.dart';
import 'package:mosque/generated/l10n.dart'; // Import your localization file

class UpdateUserForm extends StatefulWidget {
  final emailController = TextEditingController();

  UpdateUserForm({super.key});

  @override
  State<UpdateUserForm> createState() => _UpdateUserFormState();
}

class _UpdateUserFormState extends State<UpdateUserForm> {
  final TextEditingController _userNameController = TextEditingController();
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
    _userNameController.text = homeUserCubit.userDataModel!.username!;
    _nomController.text = homeUserCubit.userDataModel!.nom!;
    _prenomController.text = homeUserCubit.userDataModel!.prenom!;
    _ageController.text = homeUserCubit.userDataModel!.age!.toString();
    _emailController.text = homeUserCubit.userDataModel!.email!.toString();
    _telephoneController.text =
        homeUserCubit.userDataModel!.telephone!.toString();
    super.initState();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _nomController.dispose();
    _prenomController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _telephoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileUserCubit, ProfileUserState>(
      listener: (context, state) {
        if (state is UpdateUserStateGood) {
          // Updated
          HomeUserCubit.get(context).getMyInfo().then((value) {
            showToast(msg: S.of(context).success, state: ToastStates.success);
          });
          Navigator.pop(context);
          // Navigator.pop(context);
          // Navigator.pushAndRemoveUntil(
          //   context,
          //   MaterialPageRoute(builder: (context) => const ProfileUser()),
          //   (route) => false,
          // );
          // });
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
                title: Text(S.of(context).update), // Updated
                leading: IconButton(
                  color: Colors.black,
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    if (state is! UpdateUserLoadingState) {
                      Navigator.pop(context);
                    }
                  },
                )),
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
                          backgroundImage: ProfileUserCubit.get(context)
                                      .imageCompress !=
                                  null
                              ? FileImage(
                                  ProfileUserCubit.get(context).imageCompress!)
                              : HomeUserCubit.get(context)
                                          .userDataModel!
                                          .photo !=
                                      null
                                  ? CachedNetworkImageWidgetProvider
                                      .getImageProvider(
                                          HomeUserCubit.get(context)
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
                    defaultForm3(
                        controller: _userNameController,
                        textInputAction: TextInputAction.next,
                        labelText: S.of(context).username, // Updated
                        prefixIcon: const Icon(Icons.person),
                        valid: (value) {
                          if (value!.isEmpty) {
                            return S
                                .of(context)
                                .usernameMustNotBeEmpty; // Updated
                          }
                        },
                        context: context),
                    const SizedBox(
                      height: 30,
                    ),
                    defaultForm3(
                        controller: _nomController,
                        textInputAction: TextInputAction.next,
                        labelText: S.of(context).nom, // Updated
                        prefixIcon: const Icon(Icons.person),
                        valid: (value) {
                          if (value!.isEmpty) {
                            return S.of(context).nameMustNotBeEmpty; // Updated
                          }
                        },
                        context: context),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultForm3(
                        controller: _prenomController,
                        textInputAction: TextInputAction.next,
                        labelText: S.of(context).prenom, // Updated
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.transparent,
                        ),
                        type: TextInputType.text,
                        context: context,
                        valid: (value) {
                          if (value!.isEmpty) {
                            return S
                                .of(context)
                                .prenomMustNotBeEmpty; // Updated
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultForm3(
                        controller: _ageController,
                        textInputAction: TextInputAction.next,
                        labelText: S.of(context).age, // Updated
                        prefixIcon: const Icon(Icons.countertops_outlined),
                        type: TextInputType.text,
                        context: context,
                        valid: (value) {
                          if (value!.isEmpty) {
                            return S.of(context).ageMustNotBeEmpty; // Updated
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultForm3(
                        controller: _emailController,
                        textInputAction: TextInputAction.next,
                        context: context,
                        labelText: S.of(context).email, // Updated
                        prefixIcon: const Icon(Icons.email_outlined),
                        type: TextInputType.text,
                        valid: (value) {
                          if (value!.isEmpty) {
                            return S.of(context).emailMustNotBeEmpty; // Updated
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultForm3(
                        controller: _telephoneController,
                        textInputAction: TextInputAction.next,
                        labelText: S.of(context).telephone, // Updated
                        prefixIcon: const Icon(Icons.phone),
                        type: TextInputType.phone,
                        context: context,
                        valid: (value) {
                          if (value!.isEmpty) {
                            return S.of(context).phoneMustNotBeEmpty; // Updated
                          }
                        }),
                    const SizedBox(
                      height: 50,
                    ),
                    defaultSubmit(
                        text: S.of(context).update, // Updated
                        valid: () {
                          if (formkey.currentState!.validate()) {
                            ProfileUserCubit.get(context).updateUser(
                              userName: _userNameController.text,
                              nom: _nomController.text,
                              prenom: _prenomController.text,
                              email: _emailController.text,
                              telephone: _telephoneController.text,
                              age: _ageController.text,
                              deleteOldImage: HomeUserCubit.get(context)
                                  .userDataModel!
                                  .photo,
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
      title: Text(
        S.of(context).chooseSource, // Updated
      ),
      actions: [
        TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await ProfileUserCubit.get(context)
                  .imagePickerProfile(ImageSource.camera);
            },
            child: Text(S.of(context).camera)), // Updated
        TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await ProfileUserCubit.get(context)
                  .imagePickerProfile(ImageSource.gallery);
            },
            child: Text(S.of(context).gallery)) // Updated
      ],
    );
  }
}
