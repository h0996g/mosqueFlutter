import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosque/helper/cachhelper.dart';
import 'package:mosque/screen/Auth/cubit/auth_cubit.dart';
import 'package:mosque/screen/Auth/login.dart';
import 'package:mosque/screen/home/home.dart';

import '../../../component/components.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);

  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  final emailController = TextEditingController();
  final motDePasseController = TextEditingController();
  final telephoneController = TextEditingController();
  final ageController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  // late final Map<String, dynamic> sendinfologin;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AuthCubit(),
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const Text(
                        'انشاء حساب',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                      defaultForm(
                          context: context,
                          controller: nomController,
                          type: TextInputType.text,
                          lable: const Text(
                            'الاسم',
                            style: TextStyle(color: Colors.grey),
                          ),
                          valid: (String value) {
                            if (value.isEmpty) {
                              return 'Nom Must Not Be Empty';
                            }
                          },
                          onFieldSubmitted: () {},
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.grey,
                          ),
                          textInputAction: TextInputAction.next),
                      const SizedBox(
                        height: 18,
                      ),
                      defaultForm(
                          context: context,
                          controller: prenomController,
                          type: TextInputType.text,
                          lable: const Text(
                            'اللقب',
                            style: TextStyle(color: Colors.grey),
                          ),
                          valid: (String value) {
                            if (value.isEmpty) {
                              return 'prenom Must Not Be Empty';
                            }
                          },
                          onFieldSubmitted: () {},
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.grey,
                          ),
                          textInputAction: TextInputAction.next),
                      const SizedBox(
                        height: 18,
                      ),
                      defaultForm(
                          context: context,
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          lable: const Text(
                            'البريد الالكتروني',
                            style: TextStyle(color: Colors.grey),
                          ),
                          valid: (String value) {
                            if (value.isEmpty) {
                              return 'Email Must Not Be Empty';
                            }
                          },
                          onFieldSubmitted: () {},
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.grey,
                          ),
                          textInputAction: TextInputAction.next),
                      const SizedBox(
                        height: 18,
                      ),
                      defaultForm(
                          context: context,
                          controller: ageController,
                          type: TextInputType.number,
                          lable: const Text(
                            'العمر',
                            style: TextStyle(color: Colors.grey),
                          ),
                          valid: (String value) {
                            if (value.isEmpty) {
                              return 'Age Must Not Be Empty';
                            }
                          },
                          onFieldSubmitted: () {},
                          prefixIcon: const Icon(
                            Icons.format_list_numbered_rounded,
                            color: Colors.grey,
                          ),
                          textInputAction: TextInputAction.next),
                      const SizedBox(
                        height: 18,
                      ),
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          return defaultForm(
                              context: context,
                              textInputAction: TextInputAction.done,
                              controller: motDePasseController,
                              type: TextInputType.visiblePassword,
                              onFieldSubmitted: () {},
                              obscureText: AuthCubit.get(context).ishidden,
                              valid: (value) {
                                if (value.isEmpty) {
                                  return 'mot_de_passe Must Be Not Empty';
                                }
                              },
                              lable: const Text(
                                'كلمة السر',
                                style: TextStyle(color: Colors.grey),
                              ),
                              prefixIcon: const Icon(
                                Icons.password,
                                color: Colors.grey,
                              ),
                              sufixIcon: IconButton(
                                onPressed: () {
                                  AuthCubit.get(context).showpass();
                                },
                                icon: AuthCubit.get(context).iconhidden,
                                color: Colors.grey,
                              ));
                        },
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      defaultForm(
                        context: context,
                        controller: telephoneController,
                        type: TextInputType.number,
                        lable: const Text(
                          'الهاتف',
                          style: TextStyle(color: Colors.grey),
                        ),
                        valid: (String value) {
                          if (value.isEmpty) {
                            return 'telephone Must Not Be Empty';
                          }
                        },
                        onFieldSubmitted: () {},
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (BuildContext context, AuthState state) {
                          if (state is RegisterStateGood) {
                            navigatAndFinish(
                                context: context, page: const Home());
                            showToast(
                                msg: 'Hi ${state.model.data!.nom!}',
                                state: ToastStates.success);
                            CachHelper.putcache(
                                key: "TOKEN", value: state.model.token);
                          } else if (state is ErrorState) {
                            showToast(
                                msg: ' ${state.errorModel.message}',
                                state: ToastStates.error);
                          } else if (state is RegisterStateBad) {
                            showToast(msg: "Error", state: ToastStates.error);
                          }
                        },
                        builder: (context, state) {
                          if (state is RegisterLodinState) {
                            return const CircularProgressIndicator();
                          }
                          return buttonSubmit(
                              text: 'انشاء حساب',
                              context: context,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  Map<String, dynamic> sendinfologin = {
                                    'nom': nomController.text,
                                    "prenom": prenomController.text,
                                    "email": emailController.text,
                                    "age": ageController.text,
                                    'mot_de_passe': motDePasseController.text,
                                    "telephone": telephoneController.text,
                                  };
                                  AuthCubit.get(context)
                                      .registerUser(data: sendinfologin);
                                }
                              });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      haveAccount(context)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Row haveAccount(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'لديك حساب من قبل ؟',
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        TextButton(
            onPressed: () {
              navigatAndReturn(context: context, page: Login());
            },
            child: const Text('تسجيل الدخول'))
      ],
    );
  }
}
