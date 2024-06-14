import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosque/component/components.dart';
import 'package:mosque/helper/cachhelper.dart';
import 'package:mosque/screen/Auth/cubit/auth_cubit.dart';
import 'package:mosque/screen/userScreens/home/home.dart';

class RegisterUser extends StatelessWidget {
  RegisterUser({super.key});

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final ageController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var sizedBoxSpacing = screenHeight * 0.015;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: screenHeight * 0.02, horizontal: screenWidth * 0.05),
          child: Column(
            children: [
              Text(
                'Let\'s create your account',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: screenHeight * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: defaultForm3(
                                context: context,
                                controller: firstNameController,
                                type: TextInputType.text,
                                labelText: "First Name",
                                valid: (String value) {
                                  if (value.isEmpty) {
                                    return 'First Name must not be empty';
                                  }
                                },
                                onFieldSubmitted: () {},
                                prefixIcon: const Icon(
                                  Icons.person_outlined,
                                ),
                                textInputAction: TextInputAction.next),
                          ),
                          SizedBox(width: screenWidth * 0.04),
                          Expanded(
                            child: defaultForm3(
                                context: context,
                                controller: lastNameController,
                                type: TextInputType.text,
                                labelText: "Last Name",
                                valid: (String value) {
                                  if (value.isEmpty) {
                                    return 'Last Name must not be empty';
                                  }
                                },
                                onFieldSubmitted: () {},
                                prefixIcon: const Icon(
                                  Icons.person_outlined,
                                ),
                                textInputAction: TextInputAction.next),
                          ),
                        ],
                      ),
                      SizedBox(height: sizedBoxSpacing),
                      defaultForm3(
                          context: context,
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          labelText: "Email",
                          valid: (String value) {
                            if (value.isEmpty) {
                              return 'Email must not be empty';
                            }
                          },
                          onFieldSubmitted: () {},
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                          ),
                          textInputAction: TextInputAction.next),
                      SizedBox(height: sizedBoxSpacing),
                      defaultForm3(
                        context: context,
                        controller: phoneController,
                        type: TextInputType.number,
                        labelText: "Phone",
                        valid: (String value) {
                          if (value.isEmpty) {
                            return 'Phone must not be empty';
                          }
                        },
                        onFieldSubmitted: () {},
                        prefixIcon: const Icon(
                          Icons.phone,
                        ),
                      ),
                      SizedBox(height: sizedBoxSpacing),
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          return defaultForm3(
                              context: context,
                              textInputAction: TextInputAction.done,
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              onFieldSubmitted: () {},
                              obscureText: AuthCubit.get(context).ishidden,
                              valid: (value) {
                                if (value.isEmpty) {
                                  return 'Password must not be empty';
                                }
                              },
                              labelText: "Password",
                              prefixIcon: const Icon(
                                Icons.password_outlined,
                              ),
                              sufixIcon: IconButton(
                                onPressed: () {
                                  AuthCubit.get(context).showpass();
                                },
                                icon: AuthCubit.get(context).iconhidden,
                              ));
                        },
                      ),
                      SizedBox(height: sizedBoxSpacing),
                      defaultForm3(
                          context: context,
                          controller: ageController,
                          type: TextInputType.number,
                          labelText: "Age",
                          valid: (String value) {
                            if (value.isEmpty) {
                              return 'Age must not be empty';
                            }
                          },
                          onFieldSubmitted: () {},
                          prefixIcon: const Icon(
                            Icons.format_list_numbered_rounded,
                          ),
                          textInputAction: TextInputAction.next),
                      SizedBox(height: screenHeight * 0.03),
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (BuildContext context, AuthState state) {
                          if (state is RegisterStateGood) {
                            navigatAndFinish(
                                context: context, page: const HomeUser());
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
                          return defaultSubmit(
                              valid: () {
                                if (formKey.currentState!.validate()) {
                                  Map<String, dynamic> sendinfologin = {
                                    'nom': firstNameController.text,
                                    "prenom": lastNameController.text,
                                    "email": emailController.text,
                                    "age": ageController.text,
                                    'mot_de_passe': passwordController.text,
                                    "telephone": phoneController.text,
                                  };
                                  AuthCubit.get(context)
                                      .registerUser(data: sendinfologin);
                                }
                              },
                              text: "Create Account");
                        },
                      ),
                      SizedBox(height: screenHeight * 0.02),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Flexible(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                      indent: 60,
                      endIndent: 5,
                    ),
                  ),
                  Text(
                    "Or sign in with",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const Flexible(
                    child: Divider(
                      color: Colors.grey,
                      height: 3,
                      thickness: 0.5,
                      indent: 5,
                      endIndent: 60,
                    ),
                  )
                ],
              ),
              SizedBox(height: screenHeight * 0.015),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: IconButton(
                      icon: const Image(
                        width: 24,
                        height: 24,
                        image: AssetImage("assets/images/google.png"),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.015),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: IconButton(
                      icon: const Image(
                        width: 24,
                        height: 24,
                        image: AssetImage("assets/images/facebook.png"),
                      ),
                      onPressed: () {},
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
