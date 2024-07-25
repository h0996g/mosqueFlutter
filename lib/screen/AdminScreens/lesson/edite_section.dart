import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mosque/component/category/cubit/category_cubit.dart';
import 'package:mosque/component/components.dart';
import 'package:mosque/model/section_model.dart';
import 'package:mosque/screen/AdminScreens/lesson/cubit/lesson_cubit.dart';

class EditSectionPage extends StatefulWidget {
  final SectionModel section;
  const EditSectionPage({super.key, required this.section});

  @override
  // ignore: library_private_types_in_public_api
  _EditSectionPageState createState() => _EditSectionPageState();
}

class _EditSectionPageState extends State<EditSectionPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _photoUrl;
  String?
      _oldFirstPhotoUrl; // hadi awel photo kima nkon dkholt lel page bah kima neteka 3la icon remove yb9a url mkhabi hna wna7ih mn firebase
  LessonAdminCubit? _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = LessonAdminCubit.get(context);
    _nameController.text = widget.section.name ?? '';
    _descriptionController.text = widget.section.description ?? '';
    _photoUrl = widget.section.photo;
    _oldFirstPhotoUrl = widget.section.photo;
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
      Map<String, dynamic> updatedSection = {
        'name': _nameController.text,
        'description': _descriptionController.text,
        'photo': _photoUrl,
      };
      LessonAdminCubit.get(context).updateSection(
          data: updatedSection,
          sectionId: widget.section.id!,
          deleteOldImage: _oldFirstPhotoUrl);
    }
  }

  void _removePhoto() {
    setState(() {
      _photoUrl = null;
      _cubit!.resetImageSection();
    });
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
          if (LessonAdminCubit.get(context).state is! UpdateSectionLoading) {
            Navigator.pop(context);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              if (LessonAdminCubit.get(context).state
                  is! UpdateSectionLoading) {
                Navigator.pop(context);
              }
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title:
              const Text('Edit Section', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              vertical: verticalPadding, horizontal: horizontalPadding),
          child: BlocConsumer<LessonAdminCubit, LessonAdminState>(
            listener: (context, state) {
              if (state is UpdateSectionGood) {
                CategoryCubit.get(context).getAllSection();
                Navigator.pop(context);
                showToast(
                    msg: 'Section updated successfully',
                    state: ToastStates.success);
              } else if (state is UpdateSectionBad) {
                showToast(
                    msg: 'Failed to update section. Please try again later.',
                    state: ToastStates.error);
              }
            },
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Edit Section',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      "Update the details for your section.",
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
                    SizedBox(height: screenHeight * 0.04),
                    _cubit!.imageCompress != null || _photoUrl != null
                        ? Stack(
                            alignment: Alignment.topRight,
                            children: [
                              SizedBox(
                                  height: 200,
                                  child: ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(15.0),
                                      ),
                                      child: _cubit!.imageCompress != null
                                          ? Image.file(_cubit!.imageCompress!)
                                          : _photoUrl != null
                                              ? Image.network(
                                                  _photoUrl!,
                                                  fit: BoxFit.cover,
                                                  // width: double.infinity,
                                                )
                                              : null)),
                              IconButton(
                                icon:
                                    const Icon(Icons.close, color: Colors.red),
                                onPressed: _removePhoto,
                              ),
                            ],
                          )
                        : Container(
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
                        // Implement photo upload logic
                        _cubit!.imagePickerSection(ImageSource.gallery);
                      },
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    state is UpdateSectionLoading
                        ? const Center(child: CircularProgressIndicator())
                        : buildSubmitButton(
                            context, _submitForm, 'Update Section'),
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
