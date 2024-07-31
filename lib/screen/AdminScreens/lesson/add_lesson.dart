import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosque/component/components.dart';
import 'package:mosque/generated/l10n.dart'; // Import your localization file
import 'package:mosque/screen/AdminScreens/lesson/cubit/lesson_cubit.dart';

class AddNewLessonPage extends StatefulWidget {
  final String sectionId;
  final bool isNavigate;

  const AddNewLessonPage({
    super.key,
    required this.sectionId,
    required this.isNavigate,
  });

  @override
  State<AddNewLessonPage> createState() => _AddNewLessonPageState();
}

class _AddNewLessonPageState extends State<AddNewLessonPage> {
  late LessonAdminCubit _cubit;

  File? pdfFile;

  Future<void> pickPdfFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        pdfFile = File(result.files.single.path!);
      });
      print('PDF file selected: ${pdfFile!.path}');
    } else {
      print('No file selected');
    }
  }

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final urlVideoController = TextEditingController();
  final durationController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void _submitForm(context, LessonAdminCubit _cubit) {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> data = {
        'section': widget.sectionId,
        'title': titleController.text,
        'description': descriptionController.text,
        'urlVideo': urlVideoController.text,
        'duration': durationController.text,
      };
      _cubit.createLesson(data: data, pdfFile: pdfFile);
    }
  }

  @override
  void initState() {
    _cubit = LessonAdminCubit.get(context);
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    urlVideoController.dispose();
    durationController.dispose();
    pdfFile = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenHeight = screenSize.height;
    var screenWidth = screenSize.width;
    double verticalPadding = screenHeight * 0.02;
    double horizontalPadding = screenWidth * 0.05;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
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
            if (state is CreateLessonGood) {
              if (widget.isNavigate) {
                Navigator.pop(context);
              }
              showToast(
                msg: S.of(context).lessonCreatedSuccess,
                state: ToastStates.success,
              );
            } else if (state is CreateLessonBad) {
              showToast(
                msg: S.of(context).lessonCreationFailed,
                state: ToastStates.error,
              );
            }
          },
          builder: (context, state) {
            return Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).createNewLesson,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    S.of(context).fillInLessonDetails,
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
                        return S.of(context).videoUrlEmptyError;
                      }
                    },
                    prefixIcon: const Icon(
                      Icons.video_library,
                      color: Colors.grey,
                    ),
                    labelText: S.of(context).videoUrl,
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
                    },
                    prefixIcon: const Icon(
                      Icons.timer,
                      color: Colors.grey,
                    ),
                    labelText: S.of(context).duration,
                    textInputAction: TextInputAction.done,
                  ),
                  if (pdfFile != null)
                    Padding(
                      padding: EdgeInsets.only(top: 0.02 * screenHeight),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.picture_as_pdf,
                              size: 50,
                              color: Colors.red,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'PDF file selected',
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  Text(
                                    pdfFile!.path.split('/').last,
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  pdfFile = null;
                                });
                              },
                              icon: Icon(
                                Icons.close,
                                color: Colors.red[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(height: screenHeight * 0.02),
                  buildUploadButton(
                    icon: Icons.upload_file,
                    label: S.of(context).uploadSupplementPdf,
                    onPressed: () {
                      pickPdfFile();
                      print(S.of(context).uploadingPdf);
                    },
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  if (state is CreateLessonLoading)
                    const Center(child: CircularProgressIndicator())
                  else
                    buildSubmitButton(
                      context,
                      () {
                        _submitForm(context, _cubit);
                      },
                      S.of(context).createLesson,
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
