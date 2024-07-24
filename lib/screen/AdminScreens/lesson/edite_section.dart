import 'package:flutter/material.dart';
import 'package:mosque/component/components.dart';
import 'package:mosque/model/section_model.dart';

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

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.section.name ?? '';
    _descriptionController.text = widget.section.description ?? '';
    _photoUrl = widget.section.photo;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      print('Name: ${_nameController.text}');
      print('Description: ${_descriptionController.text}');
      print('Photo URL: $_photoUrl');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Section updated successfully')),
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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
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
        child: Form(
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
              buildSubmitButton(context, _submitForm, 'Update Section'),
            ],
          ),
        ),
      ),
    );
  }
}
