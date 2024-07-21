import 'package:flutter/material.dart';
import 'package:mosque/component/components.dart';

class AddSectionScreen extends StatefulWidget {
  const AddSectionScreen({Key? key}) : super(key: key);

  @override
  _AddSectionScreenState createState() => _AddSectionScreenState();
}

class _AddSectionScreenState extends State<AddSectionScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _photoUrl;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Here you would typically call a method to add the section
      // For example:
      // HomeAdminCubit.get(context).addSection(
      //   name: _nameController.text,
      //   description: _descriptionController.text,
      //   photo: _photoUrl,
      // );

      print('Name: ${_nameController.text}');
      print('Description: ${_descriptionController.text}');
      print('Photo URL: $_photoUrl');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Section added successfully')),
      );

      Navigator.pop(context);
    }
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
          // title: const Text('Add New Section'),
          // backgroundColor: Colors.blue,
          ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            vertical: verticalPadding, horizontal: horizontalPadding),
        child: Form(
          key: _formKey,
          child: Column(
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
              buildUploadButton(
                icon: Icons.photo,
                label: "Upload Section Photo",
                onPressed: () {
                  // Implement photo upload logic
                  print('Uploading section photo...');
                },
              ),
              SizedBox(height: screenHeight * 0.04),
              buildSubmitButton(context, _submitForm, 'Add Section'),
            ],
          ),
        ),
      ),
    );
  }
}
