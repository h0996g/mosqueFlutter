import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mosque/component/category/cubit/category_cubit.dart';
import 'package:mosque/component/components.dart';
import 'package:flutter/material.dart';
import 'package:mosque/screen/AdminScreens/home/cubit/home_admin_cubit.dart';
import 'package:mosque/screen/AdminScreens/lesson/cubit/lesson_cubit.dart';

class AddSectionScreen extends StatefulWidget {
  const AddSectionScreen({super.key});

  @override
  _AddSectionScreenState createState() => _AddSectionScreenState();
}

class _AddSectionScreenState extends State<AddSectionScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  // String? _photoUrl;
  LessonAdminCubit? _cubit;
  @override
  void initState() {
    _cubit = LessonAdminCubit.get(context);
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _cubit!.resetImageSection();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> data = {
        'admin': HomeAdminCubit.get(context).adminModel!.id,
        'name': _nameController.text,
        'description': _descriptionController.text,
      };
      _cubit!.createSection(data: data);
    }
  }

  void _removePhoto() {
    _cubit!.resetImageSection();
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
          if (LessonAdminCubit.get(context).state is! CreateSectionLoading) {
            Navigator.pop(context);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
          onPressed: () {
            if (LessonAdminCubit.get(context).state is! CreateSectionLoading) {
              Navigator.pop(context);
            }
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        )),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              vertical: verticalPadding, horizontal: horizontalPadding),
          child: Form(
            key: _formKey,
            child: BlocConsumer<LessonAdminCubit, LessonAdminState>(
              listener: (context, state) {
                if (state is CreateSectionGood) {
                  CategoryCubit.get(context).getAllSection();
                  Navigator.pop(context);
                  showToast(
                      msg: 'Section created successfully',
                      state: ToastStates.success);
                } else if (state is CreateSectionBad) {
                  showToast(
                      msg: 'Failed to create section',
                      state: ToastStates.error);
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create a New Section',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      "Fill in the details for your new section.",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    defaultForm3(
                      context: context,
                      controller: _nameController,
                      type: TextInputType.text,
                      valid: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Section name must not be empty';
                        }
                        return null;
                      },
                      prefixIcon: const Icon(
                        Icons.title,
                        color: Colors.grey,
                      ),
                      labelText: "Section Name",
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    defaultForm3(
                      context: context,
                      controller: _descriptionController,
                      type: TextInputType.multiline,
                      valid: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Description must not be empty';
                        }
                        return null;
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
                    if (_cubit!.imageCompress != null)
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          SizedBox(
                              height: 200,
                              child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(15.0),
                                  ),
                                  child: Image.file(_cubit!.imageCompress!))),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            onPressed: _removePhoto,
                          ),
                        ],
                      )
                    else
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.photo,
                            size: 50, color: Colors.grey),
                      ),
                    SizedBox(height: screenHeight * 0.02),
                    buildUploadButton(
                      icon: Icons.photo,
                      label: "Upload Section Photo",
                      onPressed: () {
                        _cubit!.imagePickerSection(ImageSource.gallery);
                      },
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    if (state is CreateSectionLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      buildSubmitButton(context, _submitForm, 'Add Section'),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}