// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mosque/model/section_model.dart';
// import 'package:mosque/screen/AdminScreens/lesson/cubit/lesson_cubit.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mosque/model/section_model.dart';
// import 'package:mosque/screen/AdminScreens/lesson/cubit/lesson_cubit.dart';

// class QuizEditorScreen extends StatefulWidget {
//   final String lessonId;

//   const QuizEditorScreen({super.key, required this.lessonId});

//   @override
//   _QuizEditorScreenState createState() => _QuizEditorScreenState();
// }

// class _QuizEditorScreenState extends State<QuizEditorScreen> {
//   List<Quiz> quizList = [];
//   LessonAdminCubit? lessonCubit;

//   @override
//   void initState() {
//     super.initState();
//     lessonCubit = LessonAdminCubit.get(context);
//     lessonCubit?.getQuiz(lessonID: widget.lessonId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Quiz Editor'),
//       ),
//       body: BlocConsumer<LessonAdminCubit, LessonAdminState>(
//         listener: (context, state) {
//           if (state is GetQuizGood) {
//             quizList = state.quiz;
//           }
//         },
//         builder: (context, state) {
//           if (state is GetQuizLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is GetQuizBad) {
//             return const Center(child: Text('Error loading quiz'));
//           } else if (state is GetQuizGood) {
//             return ListView.builder(
//               itemCount: quizList.length,
//               itemBuilder: (context, index) {
//                 return QuizItem(
//                   quiz: quizList[index],
//                   onDelete: () {
//                     setState(() {
//                       quizList.removeAt(index);
//                     });
//                   },
//                   onSave: (updatedQuiz) {
//                     setState(() {
//                       quizList[index] = updatedQuiz;
//                     });
//                   },
//                 );
//               },
//             );
//           } else {
//             return const Center(child: Text('No quiz data available'));
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showDialog(
//             context: context,
//             builder: (context) {
//               return QuizEditorDialog(
//                 onSave: (newQuiz) {
//                   setState(() {
//                     quizList.add(newQuiz);
//                   });
//                 },
//               );
//             },
//           );
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

// class QuizItem extends StatelessWidget {
//   final Quiz quiz;
//   final VoidCallback onDelete;
//   final Function(Quiz) onSave;

//   const QuizItem({
//     super.key,
//     required this.quiz,
//     required this.onDelete,
//     required this.onSave,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: ListTile(
//         title: Text(quiz.question ?? ''),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: quiz.options!
//               .asMap()
//               .entries
//               .map((entry) => Text(
//                     '${entry.key + 1}. ${entry.value} ${quiz.correctAnswerIndex!.contains(entry.key) ? '(Correct)' : ''}',
//                   ))
//               .toList(),
//         ),
//         trailing: IconButton(
//           icon: const Icon(Icons.delete),
//           onPressed: onDelete,
//         ),
//         onTap: () {
//           showDialog(
//             context: context,
//             builder: (context) {
//               return QuizEditorDialog(
//                 quiz: quiz,
//                 onSave: onSave,
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class QuizEditorDialog extends StatefulWidget {
//   final Quiz? quiz;
//   final Function(Quiz) onSave;

//   const QuizEditorDialog({
//     super.key,
//     this.quiz,
//     required this.onSave,
//   });

//   @override
//   _QuizEditorDialogState createState() => _QuizEditorDialogState();
// }

// class _QuizEditorDialogState extends State<QuizEditorDialog> {
//   late TextEditingController questionController;
//   late List<TextEditingController> optionControllers;
//   late List<bool> correctAnswers;

//   @override
//   void initState() {
//     super.initState();
//     questionController =
//         TextEditingController(text: widget.quiz?.question ?? '');
//     optionControllers = widget.quiz?.options != null
//         ? widget.quiz!.options!
//             .map((option) => TextEditingController(text: option))
//             .toList()
//         : [TextEditingController()];
//     correctAnswers = widget.quiz?.correctAnswerIndex != null
//         ? List.generate(widget.quiz!.options!.length,
//             (index) => widget.quiz!.correctAnswerIndex!.contains(index))
//         : [false];
//   }

//   @override
//   void dispose() {
//     questionController.dispose();
//     for (var controller in optionControllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }

//   void addOption() {
//     setState(() {
//       optionControllers.add(TextEditingController());
//       correctAnswers.add(false);
//     });
//   }

//   void removeOption(int index) {
//     setState(() {
//       optionControllers.removeAt(index);
//       correctAnswers.removeAt(index);
//     });
//   }

//   void saveQuiz() {
//     final question = questionController.text;
//     final options =
//         optionControllers.map((controller) => controller.text).toList();
//     final correctAnswerIndex = correctAnswers
//         .asMap()
//         .entries
//         .where((entry) => entry.value)
//         .map((entry) => entry.key)
//         .toList();

//     final newQuiz = Quiz(
//       question: question,
//       options: options,
//       correctAnswerIndex: correctAnswerIndex,
//       id: widget.quiz?.id,
//     );

//     widget.onSave(newQuiz);
//     Navigator.of(context).pop();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Edit Quiz'),
//       content: SingleChildScrollView(
//         child: Column(
//           children: [
//             TextField(
//               controller: questionController,
//               decoration: const InputDecoration(labelText: 'Question'),
//             ),
//             const SizedBox(height: 10),
//             Column(
//               children: List.generate(optionControllers.length, (index) {
//                 return Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         controller: optionControllers[index],
//                         decoration:
//                             InputDecoration(labelText: 'Option ${index + 1}'),
//                       ),
//                     ),
//                     Checkbox(
//                       value: correctAnswers[index],
//                       onChanged: (value) {
//                         setState(() {
//                           correctAnswers[index] = value ?? false;
//                         });
//                       },
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.remove),
//                       onPressed: () => removeOption(index),
//                     ),
//                   ],
//                 );
//               }),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: addOption,
//               child: const Text('Add Option'),
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: const Text('Cancel'),
//         ),
//         ElevatedButton(
//           onPressed: saveQuiz,
//           child: const Text('Save'),
//         ),
//       ],
//     );
//   }
// }
