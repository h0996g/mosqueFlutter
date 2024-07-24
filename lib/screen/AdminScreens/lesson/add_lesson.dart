import 'package:flutter/material.dart';
import 'package:mosque/component/components.dart';
// Import other necessary packages and files

class AddNewLessonPage extends StatelessWidget {
  AddNewLessonPage({Key? key}) : super(key: key);

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final urlVideoController = TextEditingController();
  final durationController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
        child: Form(
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
              SizedBox(height: screenHeight * 0.02),
              buildUploadButton(
                icon: Icons.upload_file,
                label: "Upload Supplement PDF",
                onPressed: () {
                  // Implement photo upload logic
                  print('Uploading lesson PDF...');
                },
              ),
              SizedBox(height: screenHeight * 0.04),
              buildSubmitButton(context, () {}, "Create Lesson"),
            ],
          ),
        ),
      ),
    );
  }
}
