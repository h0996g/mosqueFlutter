import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosque/component/components.dart';
import 'package:mosque/generated/l10n.dart';
import 'package:mosque/screen/AdminScreens/profile/cubit/profile_admin_cubit.dart';
import 'package:mosque/screen/AdminScreens/profile/profile.dart';

class UpdateMdpForm extends StatelessWidget {
  UpdateMdpForm({super.key});
  final TextEditingController _oldController = TextEditingController();
  final TextEditingController _new1Controller = TextEditingController();
  final TextEditingController _new2Controller = TextEditingController();

  final formkey = GlobalKey<FormState>();

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
          title: Text(S.of(context).changePassword),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              if (canPop == true) {
                Navigator.pop(context);
              }
            },
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
                      if (state is UpdateMdpAdminLoadingState) {
                        return const LinearProgressIndicator();
                      }
                      return const SizedBox();
                    },
                  ),
                  const SizedBox(height: 30),
                  BlocBuilder<ProfileAdminCubit, ProfileAdminState>(
                    builder: (context, state) {
                      return defaultForm3(
                        context: context,
                        textInputAction: TextInputAction.done,
                        controller: _oldController,
                        type: TextInputType.visiblePassword,
                        onFieldSubmitted: () {},
                        obscureText:
                            ProfileAdminCubit.get(context).isHidden['pass']!,
                        valid: (value) {
                          if (value!.isEmpty) {
                            return S.of(context).passwordMustNotBeEmpty;
                          }
                        },
                        labelText: S.of(context).oldPassword,
                        prefixIcon: const Icon(
                          Icons.password_outlined,
                          color: Colors.grey,
                        ),
                        sufixIcon: IconButton(
                          onPressed: () {
                            ProfileAdminCubit.get(context)
                                .togglePasswordVisibility('pass');
                          },
                          icon: Icon(
                            ProfileAdminCubit.get(context).isHidden['pass']!
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<ProfileAdminCubit, ProfileAdminState>(
                    builder: (context, state) {
                      return defaultForm3(
                        context: context,
                        textInputAction: TextInputAction.done,
                        controller: _new1Controller,
                        type: TextInputType.visiblePassword,
                        onFieldSubmitted: () {},
                        valid: (value) {
                          if (value!.isEmpty) {
                            return S.of(context).passwordMustNotBeEmpty;
                          }
                          if (value != _new2Controller.text) {
                            return S.of(context).passwordsDoNotMatch;
                          }
                        },
                        obscureText:
                            ProfileAdminCubit.get(context).isHidden['pass1']!,
                        labelText: S.of(context).newPassword,
                        prefixIcon: const Icon(
                          Icons.password_outlined,
                          color: Colors.grey,
                        ),
                        sufixIcon: IconButton(
                          onPressed: () {
                            ProfileAdminCubit.get(context)
                                .togglePasswordVisibility('pass1');
                          },
                          icon: Icon(
                            ProfileAdminCubit.get(context).isHidden['pass1']!
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<ProfileAdminCubit, ProfileAdminState>(
                    builder: (context, state) {
                      return defaultForm3(
                        context: context,
                        textInputAction: TextInputAction.done,
                        controller: _new2Controller,
                        type: TextInputType.visiblePassword,
                        onFieldSubmitted: () {},
                        obscureText:
                            ProfileAdminCubit.get(context).isHidden['pass2']!,
                        valid: (value) {
                          if (value!.isEmpty) {
                            return S.of(context).passwordMustNotBeEmpty;
                          }
                          if (value != _new1Controller.text) {
                            return S.of(context).passwordsDoNotMatch;
                          }
                        },
                        labelText: S.of(context).confirmNewPassword,
                        prefixIcon: const Icon(
                          Icons.password_outlined,
                          color: Colors.grey,
                        ),
                        sufixIcon: IconButton(
                          onPressed: () {
                            ProfileAdminCubit.get(context)
                                .togglePasswordVisibility('pass2');
                          },
                          icon: Icon(
                            ProfileAdminCubit.get(context).isHidden['pass2']!
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 50),
                  BlocConsumer<ProfileAdminCubit, ProfileAdminState>(
                    listener: (context, state) {
                      if (state is UpdateMdpAdminLoadingState) {
                        canPop = false;
                      } else {
                        canPop = true;
                      }
                      if (state is UpdateMdpAdminStateGood) {
                        showToast(
                            msg: S.of(context).passwordChangedSuccessfully,
                            state: ToastStates.success);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfileAdmin()),
                          (route) => false,
                        );
                      } else if (state is UpdateMdpAdminStateBad) {
                        showToast(
                            msg: S.of(context).serverCrashed,
                            state: ToastStates.error);
                      } else if (state is ErrorState) {
                        String errorMessage = state.errorModel.message!;
                        showToast(msg: errorMessage, state: ToastStates.error);
                      }
                    },
                    builder: (context, state) {
                      return defaultSubmit(
                        text: S.of(context).update,
                        valid: () {
                          if (formkey.currentState!.validate()) {
                            ProfileAdminCubit.get(context).updateMdpAdmin(
                              old: _oldController.text,
                              newPassword: _new1Controller.text,
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
