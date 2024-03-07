// import 'package:flutter/material.dart';
// import 'package:mosque/screen/login.dart';

// import '../component/components.dart';

// class Register extends StatelessWidget {
//   Register({Key? key}) : super(key: key);

//   final nameController = TextEditingController();
//   final prenomController = TextEditingController();
//   final emailController = TextEditingController();
//   final passController = TextEditingController();
//   final numberController = TextEditingController();
//   final ageController = TextEditingController();
//   final formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Form(
//               key: formKey,
//               child: Column(
//                 children: [
//                   const Text(
//                     'انشاء حساب',
//                     style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(
//                     height: 26,
//                   ),
//                   defaultForm(
//                       context: context,
//                       controller: nameController,
//                       type: TextInputType.text,
//                       lable: const Text(
//                         'الاسم',
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                       valid: (String value) {
//                         if (value.isEmpty) {
//                           return 'name Must Not Be Empty';
//                         }
//                       },
//                       onFieldSubmitted: () {},
//                       prefixIcon: const Icon(
//                         Icons.person,
//                         color: Colors.grey,
//                       ),
//                       textInputAction: TextInputAction.next),
//                   const SizedBox(
//                     height: 18,
//                   ),
//                   defaultForm(
//                       context: context,
//                       controller: prenomController,
//                       type: TextInputType.text,
//                       lable: const Text(
//                         'اللقب',
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                       valid: (String value) {
//                         if (value.isEmpty) {
//                           return 'prenom Must Not Be Empty';
//                         }
//                       },
//                       onFieldSubmitted: () {},
//                       prefixIcon: const Icon(
//                         Icons.person,
//                         color: Colors.grey,
//                       ),
//                       textInputAction: TextInputAction.next),
//                   const SizedBox(
//                     height: 18,
//                   ),
//                   defaultForm(
//                       context: context,
//                       controller: emailController,
//                       type: TextInputType.emailAddress,
//                       lable: const Text(
//                         'البريد الالكتروني',
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                       valid: (String value) {
//                         if (value.isEmpty) {
//                           return 'Email Must Not Be Empty';
//                         }
//                       },
//                       onFieldSubmitted: () {},
//                       prefixIcon: const Icon(
//                         Icons.email,
//                         color: Colors.grey,
//                       ),
//                       textInputAction: TextInputAction.next),
//                   const SizedBox(
//                     height: 18,
//                   ),
//                   defaultForm(
//                       context: context,
//                       controller: ageController,
//                       type: TextInputType.number,
//                       lable: const Text(
//                         'العمر',
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                       valid: (String value) {
//                         if (value.isEmpty) {
//                           return 'Email Must Not Be Empty';
//                         }
//                       },
//                       onFieldSubmitted: () {},
//                       prefixIcon: const Icon(
//                         Icons.format_list_numbered_rounded,
//                         color: Colors.grey,
//                       ),
//                       textInputAction: TextInputAction.next),
//                   const SizedBox(
//                     height: 18,
//                   ),
//                   defaultForm(
//                       context: context,
//                       textInputAction: TextInputAction.done,
//                       controller: passController,
//                       type: TextInputType.visiblePassword,
//                       onFieldSubmitted: () {},
//                       obscureText: true,
//                       valid: (value) {
//                         if (value.isEmpty) {
//                           return 'Password Must Be Not Empty';
//                         }
//                       },
//                       lable: const Text(
//                         'كلمة السر',
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                       prefixIcon: const Icon(
//                         Icons.password,
//                         color: Colors.grey,
//                       ),
//                       sufixIcon: IconButton(
//                         onPressed: () {
//                           // LoginCubit.get(context).showpass();
//                         },
//                         icon: const Icon(Icons.remove_red_eye),
//                         color: Colors.grey,
//                       )),
//                   const SizedBox(
//                     height: 18,
//                   ),
//                   defaultForm(
//                     context: context,
//                     controller: numberController,
//                     type: TextInputType.number,
//                     lable: const Text(
//                       'الهاتف',
//                       style: TextStyle(color: Colors.grey),
//                     ),
//                     valid: (String value) {
//                       if (value.isEmpty) {
//                         return 'name Must Not Be Empty';
//                       }
//                     },
//                     onFieldSubmitted: () {},
//                     prefixIcon: const Icon(
//                       Icons.phone,
//                       color: Colors.grey,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 18,
//                   ),
//                   const SizedBox(
//                     height: 18,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         'لديك حساب من قبل ؟',
//                         style: TextStyle(
//                           fontSize: 15,
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 8,
//                       ),
//                       TextButton(
//                           onPressed: () {
//                             navigatAndReturn(context: context, page: Login());
//                           },
//                           child: const Text('تسجيل الدخول'))
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
