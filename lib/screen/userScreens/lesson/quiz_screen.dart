import 'package:flutter/material.dart';
import 'package:mosque/component/widgets/answer_card.dart';
import 'package:mosque/component/widgets/next_button.dart';
import 'package:mosque/model/section_model.dart';
import 'package:mosque/screen/userScreens/lesson/result_screen.dart';

class QuizScreen extends StatefulWidget {
  final Lesson lesson;
  final Function(int) onQuizCompleted;

  const QuizScreen({
    super.key,
    required this.lesson,
    required this.onQuizCompleted,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int? selectedAnswerIndex;
  int questionIndex = 0;
  int score = 0;

  void pickAnswer(int value) {
    selectedAnswerIndex = value;
    final question = widget.lesson.quize[questionIndex];
    if (question.correctAnswerIndex.contains(selectedAnswerIndex)) {
      score++;
    }
    setState(() {});
  }

  void goToNextQuestion() {
    if (questionIndex < widget.lesson.quize.length - 1) {
      questionIndex++;
      selectedAnswerIndex = null;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.lesson.quize[questionIndex];
    bool isLastQuestion = questionIndex == widget.lesson.quize.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              question.question,
              style: const TextStyle(
                fontSize: 21,
              ),
              textAlign: TextAlign.center,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: question.options.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: selectedAnswerIndex == null
                      ? () => pickAnswer(index)
                      : null,
                  child: AnswerCard(
                    currentIndex: index,
                    question: question.options[index],
                    isSelected: selectedAnswerIndex == index,
                    selectedAnswerIndex: selectedAnswerIndex,
                    correctAnswerIndex: question.correctAnswerIndex,
                  ),
                );
              },
            ),
            // Next Button
            isLastQuestion
                ? RectangularButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (_) => ResultScreen(
                            idLesson: widget.lesson.id,
                            idSection: widget.lesson.section,
                            score: score,
                            totalQuestions: widget.lesson.quize.length,
                            onQuizCompleted: () {
                              widget.onQuizCompleted(score);
                            },
                          ),
                        ),
                      );
                    },
                    label: 'Finish',
                  )
                : RectangularButton(
                    onPressed:
                        selectedAnswerIndex != null ? goToNextQuestion : null,
                    label: 'Next',
                  ),
          ],
        ),
      ),
    );
  }
}
