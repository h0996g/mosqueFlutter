import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosque/Api/constApi.dart';
import 'package:mosque/component/components.dart';
import 'package:mosque/component/const.dart';
import 'package:mosque/generated/l10n.dart';
import 'package:mosque/helper/cachhelper.dart';
import 'package:mosque/screen/AdminScreens/home/startPage.dart';
import 'package:mosque/screen/Auth/cubit/auth_cubit.dart';
import 'package:mosque/screen/Auth/register_user.dart';
import 'package:mosque/screen/userScreens/home/home_screen.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenHeight = screenSize.height;
    var screenWidth = screenSize.width;
    double verticalPadding = screenHeight * 0.02;
    double horizontalPadding = screenWidth * 0.05;

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            vertical: verticalPadding, horizontal: horizontalPadding),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.2),
                Text(
                  S.of(context).welcome,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  S.of(context).discover_text,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 20),
                )
              ],
            ),
            Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.04),
                child: Column(
                  children: [
                    defaultForm3(
                      context: context,
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      valid: (String value) {
                        if (value.isEmpty) {
                          return S.of(context).email_empty;
                        }
                      },
                      prefixIcon: const Icon(
                        Icons.keyboard_arrow_right_sharp,
                        color: Colors.grey,
                      ),
                      labelText: S.of(context).email_label,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        return defaultForm3(
                            context: context,
                            textInputAction: TextInputAction.done,
                            controller: passController,
                            type: TextInputType.visiblePassword,
                            onFieldSubmitted: () {},
                            obscureText: AuthCubit.get(context).ishidden,
                            valid: (value) {
                              if (value.isEmpty) {
                                return S.of(context).password_empty;
                              }
                            },
                            labelText: S.of(context).password_label,
                            prefixIcon: const Icon(
                              Icons.password_outlined,
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
                    SizedBox(height: screenHeight * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            return Row(
                              children: [
                                Checkbox(
                                    value: AuthCubit.get(context).checkBox,
                                    onChanged: (value) {
                                      AuthCubit.get(context).changeCheckBox();
                                      PATH = value == true
                                          ? Loginadmin
                                          : Loginuser;
                                      PATH1 = value == true
                                          ? RECOVERPASSWORD
                                          : RECOVERPASSWORDADMIN;
                                      PATH2 = value == true
                                          ? VERIFYJOUEURCODE
                                          : VERIFYADMINCODE;
                                      PATH3 = value == true
                                          ? RESETPASSWORD
                                          : RESETPASSWORDADMIN;
                                    }),
                                TextButton(
                                    child: Text(
                                      S.of(context).teacher,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      AuthCubit.get(context).changeCheckBox();
                                      if (PATH == Loginadmin) {
                                        PATH = Loginuser;
                                      } else {
                                        PATH = Loginadmin;
                                      }
                                    })
                              ],
                            );
                          },
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Text(S.of(context).forgot_password))
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    BlocConsumer<AuthCubit, AuthState>(
                      listener: (BuildContext context, AuthState state) async {
                        if (state is LoginStateGood) {
                          if (PATH == Loginadmin) {
                            navigatAndFinish(
                                context: context, page: const StartPageAdmin());
                          } else if (PATH == Loginuser) {
                            navigatAndFinish(
                                context: context, page: const HomeScreen());
                          }
                          showToast(
                              msg: 'Hi ${state.model.data!.nom!}',
                              state: ToastStates.success);
                          TOKEN = state.model.token!;
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
                        return defaultSubmit(
                            valid: () {
                              if (formKey.currentState!.validate()) {
                                Map<String, dynamic> sendinfologin = {
                                  "email": emailController.text,
                                  'mot_de_passe': passController.text
                                };
                                AuthCubit.get(context).login(
                                  data: sendinfologin,
                                  path: PATH,
                                );
                              }
                            },
                            text: S.of(context).login);
                      },
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                        ),
                        onPressed: () {
                          navigatAndReturn(
                              context: context, page: RegisterUser());
                        },
                        child: Text(
                          S.of(context).create_account,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     const Flexible(
            //       child: Divider(
            //         color: Colors.grey,
            //         thickness: 0.5,
            //         indent: 60,
            //         endIndent: 5,
            //       ),
            //     ),
            //     Text(
            //       S.of(context).or_login_with,
            //       style: Theme.of(context).textTheme.labelMedium,
            //     ),
            //     const Flexible(
            //       child: Divider(
            //         color: Colors.grey,
            //         height: 3,
            //         thickness: 0.5,
            //         indent: 5,
            //         endIndent: 60,
            //       ),
            //     )
            //   ],
            // ),
            // SizedBox(height: screenHeight * 0.015),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Container(
            //       decoration: BoxDecoration(
            //         border: Border.all(color: Colors.grey),
            //         borderRadius: BorderRadius.circular(100),
            //       ),
            //       child: IconButton(
            //         icon: const Image(
            //           width: 24,
            //           height: 24,
            //           image: AssetImage("assets/images/google.png"),
            //         ),
            //         onPressed: () {},
            //       ),
            //     ),
            //     SizedBox(width: screenWidth * 0.015),
            //     Container(
            //       decoration: BoxDecoration(
            //         border: Border.all(color: Colors.grey),
            //         borderRadius: BorderRadius.circular(100),
            //       ),
            //       child: IconButton(
            //         icon: const Image(
            //           width: 24,
            //           height: 24,
            //           image: AssetImage("assets/images/facebook.png"),
            //         ),
            //         onPressed: () {},
            //       ),
            //     )
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
