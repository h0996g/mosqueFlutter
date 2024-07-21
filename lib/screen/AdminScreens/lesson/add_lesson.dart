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
          // title: const Text('Add New Lesson'),
          // backgroundColor: Colors.white,
          ),
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
              // Container(
              //   width: double.infinity,
              //   height: 56, // Fixed height for consistency
              //   decoration: BoxDecoration(
              //     gradient: LinearGradient(
              //       colors: [Colors.blue.shade400, Colors.blue.shade700],
              //       begin: Alignment.centerLeft,
              //       end: Alignment.centerRight,
              //     ),
              //     borderRadius: BorderRadius.circular(8),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.blue.withOpacity(0.3),
              //         spreadRadius: 1,
              //         blurRadius: 4,
              //         offset: const Offset(0, 2),
              //       ),
              //     ],
              //   ),
              //   child: Material(
              //     color: Colors.transparent,
              //     child: InkWell(
              //       borderRadius: BorderRadius.circular(8),
              //       onTap: () {
              //         if (formKey.currentState!.validate()) {
              //           // Implement lesson creation logic
              //           print("Creating new lesson");
              //           // You can add your lesson creation logic here
              //         }
              //       },
              //       child: const Center(
              //         child: Text(
              //           "Create Lesson",
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 18,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),

              buildSubmitButton(context, () {}, "Create Lesson"),
            ],
          ),
        ),
      ),
    );
  }
}
