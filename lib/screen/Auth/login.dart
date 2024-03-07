import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosque/component/components.dart';
import 'package:mosque/component/const.dart';
import 'package:mosque/helper/cachhelper.dart';
import 'package:mosque/screen/Auth/cubit/auth_cubit.dart';
import 'package:mosque/screen/Auth/register.dart';
import 'package:mosque/screen/home/home.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
                      "تسجيل الدخول",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    const SizedBox(
                      height: 26,
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
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return defaultForm(
                            context: context,
                            textInputAction: TextInputAction.done,
                            controller: passController,
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
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (BuildContext context, AuthState state) {
                        if (state is LoginStateGood) {
                          navigatAndFinish(
                              context: context, page: const Home());
                          showToast(
                              msg: 'Hi ${state.model.data!.nom!}',
                              state: ToastStates.success);
                          TOKEN = state.model.token!;
                          print(TOKEN);
                          CachHelper.putcache(key: "TOKEN", value: TOKEN);
                        } else if (state is ErrorState) {
                          showToast(
                              msg: ' ${state.errorModel.message}',
                              state: ToastStates.error);
                        } else if (state is LoginStateBad) {
                          showToast(msg: "Error", state: ToastStates.error);
                        }
                      },
                      builder: (context, state) {
                        if (state is LoginLoadingState) {
                          return const CircularProgressIndicator();
                        }
                        return buttonSubmit(
                            text: 'تسجيل الدخول',
                            context: context,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                Map<String, dynamic> sendinfologin = {
                                  "email": emailController.text,
                                  'mot_de_passe': passController.text
                                };
                                AuthCubit.get(context).login(
                                  data: sendinfologin,
                                );
                              }
                            });
                      },
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "ليس لديك حساب من قبل",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        TextButton(
                            onPressed: () {
                              navigatAndReturn(
                                  context: context, page: Register());
                            },
                            child: const Text('انشاء حساب'))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
