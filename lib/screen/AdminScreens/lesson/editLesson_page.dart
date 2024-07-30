import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosque/component/components.dart';
import 'package:mosque/model/section_model.dart';
import 'package:mosque/screen/AdminScreens/lesson/cubit/lesson_cubit.dart';
import 'package:mosque/generated/l10n.dart'; // Ensure this path matches your setup

class EditLessonPage extends StatefulWidget {
  final Lesson lesson;
  const EditLessonPage({super.key, required this.lesson});

  @override
  State<EditLessonPage> createState() => _EditLessonPageState();
}

class _EditLessonPageState extends State<EditLessonPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final urlVideoController = TextEditingController();
  final durationController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> updatedLesson = {
        'title': titleController.text,
        'description': descriptionController.text,
        'urlVideo': urlVideoController.text,
        'duration': durationController.text,
      };
      LessonAdminCubit.get(context)
          .updateLesson(lessonId: widget.lesson.id!, data: updatedLesson);
    }
  }

  @override
  void initState() {
    titleController.text = widget.lesson.title ?? '';
    descriptionController.text = widget.lesson.description ?? '';
    urlVideoController.text = widget.lesson.urlVideo ?? '';
    durationController.text = widget.lesson.duration ?? '';
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    urlVideoController.dispose();
    durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenHeight = screenSize.height;
    var screenWidth = screenSize.width;
    double verticalPadding = screenHeight * 0.02;
    double horizontalPadding = screenWidth * 0.05;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          if (LessonAdminCubit.get(context).state is! UpdateLessonLoading) {
            Navigator.pop(context);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              if (LessonAdminCubit.get(context).state is! UpdateLessonLoading) {
                Navigator.pop(context);
              }
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              vertical: verticalPadding, horizontal: horizontalPadding),
          child: BlocConsumer<LessonAdminCubit, LessonAdminState>(
            listener: (context, state) {
              if (state is UpdateLessonGood) {
                Navigator.pop(context);
                showToast(
                    msg: S.of(context).lessonUpdatedSuccess,
                    state: ToastStates.success);
              } else if (state is UpdateLessonBad) {
                showToast(
                    msg: S.of(context).lessonUpdateFailed,
                    state: ToastStates.error);
              }
            },
            builder: (context, state) {
              return Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).editLesson,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      S.of(context).updateLessonDetails,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    defaultForm3(
                      context: context,
                      controller: titleController,
                      type: TextInputType.text,
                      valid: (String value) {
                        if (value.isEmpty) {
                          return S.of(context).titleEmptyError;
                        }
                      },
                      prefixIcon: const Icon(
                        Icons.title,
                        color: Colors.grey,
                      ),
                      labelText: S.of(context).lessonTitle,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    defaultForm3(
                      context: context,
                      controller: descriptionController,
                      type: TextInputType.multiline,
                      valid: (String value) {
                        if (value.isEmpty) {
                          return S.of(context).descriptionEmptyError;
                        }
                      },
                      prefixIcon: const Icon(
                        Icons.description,
                        color: Colors.grey,
                      ),
                      labelText: S.of(context).description,
                      maxline: 3,
                      textInputAction: TextInputAction.newline,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    defaultForm3(
                      context: context,
                      controller: urlVideoController,
                      type: TextInputType.url,
                      valid: (String value) {
                        if (value.isEmpty) {
                          return S.of(context).videoURLEmptyError;
                        }
                        return null;
                      },
                      prefixIcon: const Icon(
                        Icons.video_library,
                        color: Colors.grey,
                      ),
                      labelText: S.of(context).videoURL,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    defaultForm3(
                      context: context,
                      controller: durationController,
                      type: TextInputType.text,
                      valid: (String value) {
                        if (value.isEmpty) {
                          return S.of(context).durationEmptyError;
                        }
                        return null;
                      },
                      prefixIcon: const Icon(
                        Icons.timer,
                        color: Colors.grey,
                      ),
                      labelText: S.of(context).duration,
                      textInputAction: TextInputAction.done,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    buildUploadButton(
                      icon: Icons.upload_file,
                      label: S.of(context).uploadSupplementPDF,
                      onPressed: () {
                        // Implement PDF upload logic
                        print('Uploading lesson PDF...');
                      },
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    if (state is UpdateLessonLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      buildSubmitButton(
                          context, _submitForm, S.of(context).updateLesson),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
