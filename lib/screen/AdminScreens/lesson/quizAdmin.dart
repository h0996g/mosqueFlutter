import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosque/component/components.dart';
import 'package:mosque/model/section_model.dart';
import 'package:mosque/screen/AdminScreens/lesson/cubit/lesson_cubit.dart';
import 'package:mosque/generated/l10n.dart';

class QuizEditorScreen extends StatefulWidget {
  final String lessonId;

  const QuizEditorScreen({super.key, required this.lessonId});

  @override
  _QuizEditorScreenState createState() => _QuizEditorScreenState();
}

class _QuizEditorScreenState extends State<QuizEditorScreen> {
  List<Quiz> quizQuestions = [];

  @override
  void initState() {
    super.initState();
    LessonAdminCubit.get(context).getQuiz(lessonID: widget.lessonId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewQuestion,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        actions: [
          IconButton(
            color: Colors.blue,
            icon: const Icon(Icons.save),
            onPressed: () {
              LessonAdminCubit.get(context)
                  .updateQuiz(lessonId: widget.lessonId, quiz: quizQuestions)
                  .then((value) {
                if (LessonAdminCubit.get(context).state is UpdateQuizGood) {
                  showToast(
                      msg: S.of(context).quizUpdatedSuccessfully,
                      state: ToastStates.success);
                  Navigator.pop(context);
                } else {
                  showToast(
                      msg: S.of(context).errorUpdatingQuiz,
                      state: ToastStates.error);
                }
              });
            },
          ),
        ],
        title: Text(
          S.of(context).quizEditorTitle,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BlocConsumer<LessonAdminCubit, LessonAdminState>(
        listener: (context, state) {
          if (state is GetQuizGood) {
            setState(() {
              quizQuestions = state.quiz;
            });
          }
        },
        builder: (context, state) {
          if (state is GetQuizLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetQuizBad) {
            return const Center(child: Text('Error loading quiz'));
          } else {
            return ListView.builder(
              itemCount: quizQuestions.length,
              itemBuilder: (context, index) {
                return QuestionCard(
                  quiz: quizQuestions[index],
                  onEdit: () => _editQuestion(index),
                  onDelete: () => _deleteQuestion(index),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _addNewQuestion() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => QuestionEditScreen(
          quiz: Quiz(question: '', options: [], correctAnswerIndex: []),
          onSave: (newQuiz) {
            setState(() {
              quizQuestions.add(newQuiz);
            });
            // TODO: Implement API call to add new question
          },
        ),
      ),
    );
  }

  void _editQuestion(int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => QuestionEditScreen(
          quiz: quizQuestions[index],
          onSave: (editedQuiz) {
            setState(() {
              quizQuestions[index] = editedQuiz;
            });
            // TODO: Implement API call to update question
          },
        ),
      ),
    );
  }

  void _deleteQuestion(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).deleteQuestionTitle),
        content: Text(S.of(context).deleteQuestionContent),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(S.of(context).cancel),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                quizQuestions.removeAt(index);
              });
              // TODO: Implement API call to delete question
              Navigator.of(context).pop();
            },
            child:
                Text(S.of(context).delete, style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class QuestionCard extends StatelessWidget {
  final Quiz quiz;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const QuestionCard({
    super.key,
    required this.quiz,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              quiz.question ?? '',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 18),
            ...List.generate(quiz.options?.length ?? 0, (index) {
              final isCorrect =
                  quiz.correctAnswerIndex?.contains(index) ?? false;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Icon(
                      isCorrect
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      color: isCorrect ? Colors.green : Colors.grey,
                      size: 22,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        quiz.options?[index] ?? '',
                        style: TextStyle(
                          color: isCorrect ? Colors.green : Colors.grey,
                          fontWeight:
                              isCorrect ? FontWeight.bold : FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton.icon(
                  icon: const Icon(Icons.edit, size: 20),
                  label: Text(S.of(context).editQuestion),
                  onPressed: onEdit,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.blueGrey,
                    side: const BorderSide(color: Colors.blueGrey),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                OutlinedButton.icon(
                  icon: const Icon(Icons.delete, size: 20),
                  label: Text(S.of(context).delete),
                  onPressed: onDelete,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionEditScreen extends StatefulWidget {
  final Quiz quiz;
  final Function(Quiz) onSave;

  const QuestionEditScreen(
      {super.key, required this.quiz, required this.onSave});

  @override
  _QuestionEditScreenState createState() => _QuestionEditScreenState();
}

class _QuestionEditScreenState extends State<QuestionEditScreen> {
  late TextEditingController _questionController;
  late List<TextEditingController> _optionControllers;
  late List<bool> _correctAnswers;

  @override
  void initState() {
    super.initState();
    _questionController = TextEditingController(text: widget.quiz.question);
    _optionControllers = List.generate(
      widget.quiz.options?.length ?? 0,
      (index) => TextEditingController(text: widget.quiz.options?[index] ?? ''),
    );
    _correctAnswers = List.generate(
      widget.quiz.options?.length ?? 0,
      (index) => widget.quiz.correctAnswerIndex?.contains(index) ?? false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        actions: [
          IconButton(
            color: Colors.blue,
            icon: const Icon(Icons.save),
            onPressed: _saveQuestion,
          ),
        ],
        title: Text(
          widget.quiz.id == null
              ? S.of(context).addQuestion
              : S.of(context).editQuestion,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _questionController,
              decoration: InputDecoration(
                labelText: S.of(context).question,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              S.of(context).options,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ..._buildOptionFields(),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: _addOption,
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(S.of(context).addOption,
                  style: const TextStyle(fontSize: 16, color: Colors.blue)),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildOptionFields() {
    return List.generate(_optionControllers.length, (index) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _optionControllers[index],
                decoration: InputDecoration(
                  labelText: '${S.of(context).option} ${index + 1}',
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Checkbox(
              value: _correctAnswers[index],
              onChanged: (value) {
                setState(() {
                  _correctAnswers[index] = value ?? false;
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _removeOption(index),
            ),
          ],
        ),
      );
    });
  }

  void _addOption() {
    setState(() {
      _optionControllers.add(TextEditingController());
      _correctAnswers.add(false);
    });
  }

  void _removeOption(int index) {
    setState(() {
      _optionControllers.removeAt(index);
      _correctAnswers.removeAt(index);
    });
  }

  void _saveQuestion() {
    final editedQuiz = Quiz(
      id: widget.quiz.id,
      question: _questionController.text,
      options: _optionControllers.map((controller) => controller.text).toList(),
      correctAnswerIndex: _correctAnswers
          .asMap()
          .entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .toList(),
    );

    widget.onSave(editedQuiz);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _questionController.dispose();
    for (var controller in _optionControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
