import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosque/component/components.dart';
import 'package:mosque/screen/AdminScreens/lesson/cubit/lesson_cubit.dart';

class AddNewLessonPage extends StatefulWidget {
  final String sectionId;
  final bool
      isNavigate; // bh n3ref ida jit mn condition state or mn navigation bh ndir pop wla no
  const AddNewLessonPage(
      {super.key, required this.sectionId, required this.isNavigate});

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
      pdfFile = File(result.files.single.path!);
      print('PDF file selected: ${pdfFile!.path}');
    } else {
      // User canceled the picker
      print('No file selected');
    }
  }

  final titleController = TextEditingController();

  final descriptionController = TextEditingController();

  final urlVideoController = TextEditingController();

  final durationController = TextEditingController();

  // final supplementPdfController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void _submitForm(context, LessonAdminCubit _cubit) {
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> data = {
        'section': widget.sectionId,
        'title': titleController.text,
        'description': descriptionController.text,
        'urlVideo': urlVideoController.text,
        'duration': durationController.text,
        // 'suplemmentPdf': supplementPdfController.text
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
    // supplementPdfController.dispose();
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
      )),
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
                  msg: 'Section created successfully',
                  state: ToastStates.success);
            } else if (state is CreateLessonBad) {
              showToast(
                  msg: 'Failed to create section', state: ToastStates.error);
            }
          },
          builder: (context, state) {
            return Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create a New Lesson',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    "Fill in the details for your new lesson.",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  defaultForm3(
                    context: context,
                    controller: titleController,
                    type: TextInputType.text,
                    valid: (String value) {
                      if (value.isEmpty) {
                        return 'Title must not be empty';
                      }
                    },
                    prefixIcon: const Icon(
                      Icons.title,
                      color: Colors.grey,
                    ),
                    labelText: "Lesson Title",
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  defaultForm3(
                    context: context,
                    controller: descriptionController,
                    type: TextInputType.multiline,
                    valid: (String value) {
                      if (value.isEmpty) {
                        return 'Description must not be empty';
                      }
                    },
                    prefixIcon: const Icon(
                      Icons.description,
                      color: Colors.grey,
                    ),
                    labelText: "Description",
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
                        return 'Video URL must not be empty';
                      }
                    },
                    prefixIcon: const Icon(
                      Icons.video_library,
                      color: Colors.grey,
                    ),
                    labelText: "Video URL",
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  defaultForm3(
                    context: context,
                    controller: durationController,
                    type: TextInputType.text,
                    valid: (String value) {
                      if (value.isEmpty) {
                        return 'Duration must not be empty';
                      }
                    },
                    prefixIcon: const Icon(
                      Icons.timer,
                      color: Colors.grey,
                    ),
                    labelText: "Duration",
                    textInputAction: TextInputAction.done,
                  ),
                  if (pdfFile != null) Text(pdfFile!.path),
                  SizedBox(height: screenHeight * 0.02),
                  buildUploadButton(
                    icon: Icons.upload_file,
                    label: "Upload Supplement PDF",
                    onPressed: () {
                      pickPdfFile();
                      // Implement photo upload logic
                      print('Uploading lesson PDF...');
                    },
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  if (state is CreateLessonLoading)
                    const Center(child: CircularProgressIndicator())
                  else
                    buildSubmitButton(context, () {
                      _submitForm(context, _cubit);
                    }, "Create Lesson"),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
