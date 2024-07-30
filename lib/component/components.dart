import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mosque/component/category/cubit/category_cubit.dart';
import 'package:mosque/component/dialog.dart';
import 'package:mosque/generated/l10n.dart';
import 'package:mosque/model/section_model.dart';

TextFormField defaultForm3(
    {controller,
    int maxline = 1,
    Widget? suffix,
    Widget? prifix,
    required context,
    String? sufixText,
    TextInputType type = TextInputType.text,
    required Function valid,
    Text? lable,
    String? labelText,
    Icon? prefixIcon,
    Widget? sufixIcon,
    TextInputAction? textInputAction,
    bool obscureText = false,
    bool readOnly = false,
    bool enabled = true,
    String? valeurinitial,
    Function? onFieldSubmitted}) {
  return TextFormField(
    enabled: enabled,
    readOnly: readOnly,
    initialValue: valeurinitial,
    textInputAction: textInputAction,
    onFieldSubmitted: (k) {
      onFieldSubmitted!();
    },
    validator: (String? value) {
      return valid(value);
    },
    decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: lable,
        prefixIcon: prefixIcon,
        suffixIcon: sufixIcon,
        prefix: prifix,
        suffix: suffix,
        suffixText: sufixText,
        labelText: labelText),
    controller: controller,
    maxLines: maxline,
    keyboardType: type,
    obscureText: obscureText,
  );
}

SizedBox defaultSubmit({
  required Function valid,
  required String text,
}) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          // textStyle: const TextStyle(fontSize: 19),
          backgroundColor: Colors.blueAccent),
      onPressed: () {
        valid();
      },
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
  );
}

void navigatAndReturn({required context, required page}) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));

void navigatAndFinish({required context, required page}) =>
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => page), (route) => false);

void showToast(
        {required String msg,
        required ToastStates state,
        ToastGravity gravity = ToastGravity.BOTTOM}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: gravity,
        timeInSecForIosWeb: 1,
        backgroundColor: choseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { success, error, warning }

Color choseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;

    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }
  return color;
}

PreferredSizeWidget defaultAppBar(
        {
        // String? title,
        List<Widget>? actions,
        bool canreturn = true,
        Widget? title,
        Widget? leading,
        // Function()? whenBack,
        Function()? onPressed}) =>
    AppBar(
        titleSpacing: 0,
        leading: canreturn
            ? IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ))
            : leading,
        title: title,
        actions: actions);

Widget buildUploadButton({
  required IconData icon,
  required String label,
  required VoidCallback onPressed,
}) {
  return Container(
    width: double.infinity,
    height: 56,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.blue, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.blue),
              const SizedBox(width: 12),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget buildSubmitButton(
    BuildContext context, VoidCallback onPressed, String text) {
  return Container(
    width: double.infinity,
    height: 56,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blue.shade400, Colors.blue.shade700],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withOpacity(0.3),
          spreadRadius: 1,
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onPressed,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  );
}

void showDeleteDialog(BuildContext context, SectionModel section) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialog(
        title: S.of(context).deleteSectionTitle,
        content: S.of(context).deleteSectionContent(section.name!),
        onCancel: () {
          Navigator.of(context).pop();
        },
        onConfirm: () {
          Navigator.of(context).pop();
          showPasswordVerificationDialog(context, section);
        },
      );
    },
  );
}

void showPasswordVerificationDialog(
    BuildContext context, SectionModel section) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return PasswordVerificationDialog(
        onVerify: (password) {
          // Here you should implement the actual password verification
          // For now, we'll just print the password and call the delete function

          CategoryCubit.get(context)
              .deleteSection(sectionId: section.id!, mot_de_passe: password);

          print('Password entered: $password');

          // If password is correct, call the delete function
          // categoryCubit?.deleteSection(section.id!);
        },
      );
    },
  );
}
