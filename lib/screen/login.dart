import 'package:flutter/material.dart';
import 'package:mosque/screen/register.dart';

import '../component/components.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
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

                  defaultForm(
                      context: context,
                      textInputAction: TextInputAction.done,
                      controller: passController,
                      type: TextInputType.visiblePassword,
                      onFieldSubmitted: () {},
                      obscureText: true,
                      valid: (value) {
                        if (value.isEmpty) {
                          return 'Password Must Be Not Empty';
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
                          // LoginCubit.get(context).showpass();
                        },
                        icon: const Icon(Icons.remove_red_eye),
                        color: Colors.grey,
                      )),
                  const SizedBox(
                    height: 18,
                  ),

                  // ConditionalBuilder(
                  //   condition: state is! ConditionalLodinState,
                  //   builder: (BuildContext context) {
                  //     return Container(
                  //       width: double.infinity,
                  //       decoration: BoxDecoration(
                  //         color: CupitHome.get(context).dartSwitch
                  //             ? Colors.blueGrey
                  //             : Colors.blue,
                  //         borderRadius: const BorderRadius.only(
                  //             topLeft: Radius.circular(15),
                  //             topRight: Radius.circular(5),
                  //             bottomLeft: Radius.circular(5),
                  //             bottomRight: Radius.circular(15)),
                  //       ),
                  //       child: Center(
                  //         child: Container(
                  //           padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  //           width: double.infinity,
                  //           child: MaterialButton(
                  //             highlightColor:
                  //                 CupitHome.get(context).dartSwitch
                  //                     ? Colors.blueGrey
                  //                     : Colors.blue,
                  //             splashColor: Colors.transparent,
                  //             onPressed: () {
                  //               if (formKeyy.currentState!.validate()) {
                  //                 sendinfoclient = {
                  //                   'name': nameController.text,
                  //                   'prenom': prenomController.text,
                  //                   'email': emailController.text,
                  //                   'password': passController.text,
                  //                   'phone': numberController.text
                  //                 };
                  //                 LoginCubit.get(context).registerUser(
                  //                     data: sendinfoclient,
                  //                     path: REGISTERCLIENT);
                  //               }
                  //             },
                  //             child: const Text(
                  //               'SIGN UP',
                  //               style: TextStyle(color: Colors.white),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  //   },
                  //   fallback: (BuildContext context) {
                  //     return const Center(
                  //       child: CircularProgressIndicator(),
                  //     );
                  //   },
                  // ),

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
                            Changepage(context, Register());
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
    );
  }
}
