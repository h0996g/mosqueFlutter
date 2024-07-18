import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosque/component/widgets/answer_card.dart';
import 'package:mosque/component/widgets/next_button.dart';
import 'package:mosque/component/widgets/result_screen.dart';
import 'package:mosque/model/section_model.dart';
import 'package:mosque/screen/userScreens/lesson/cubit/lesson_cubit.dart';

class QuizScreen extends StatefulWidget {
  // final Lesson lesson;
  final String lessonId;
  final String sectionId;
  final Function(int) onQuizCompleted;

  const QuizScreen({
    super.key,
    required this.lessonId,
    required this.onQuizCompleted,
    required this.sectionId,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int? selectedAnswerIndex;
  int questionIndex = 0;
  int score = 0;
  int remainingSeconds = 10;
  Timer? timer;
  LessonCubit? lessonCubit;
  List<Quiz> quiz = [];

  @override
  void initState() {
    super.initState();
    lessonCubit = LessonCubit.get(context);
    lessonCubit?.getQuiz(lessonID: widget.lessonId);
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        goToNextQuestion();
      }
    });
  }

  void pickAnswer(int value) {
    selectedAnswerIndex = value;
    final question = quiz[questionIndex];
    if (question.correctAnswerIndex!.contains(selectedAnswerIndex)) {
      score++;
    }
    setState(() {});
  }

  void goToNextQuestion() {
    timer?.cancel();
    if (questionIndex < quiz.length - 1) {
      questionIndex++;
      selectedAnswerIndex = null;
      remainingSeconds = 10;
      startTimer();
    } else {
      // Last question, go to result screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            idLesson: widget.lessonId,
            idSection: widget.sectionId,
            score: score,
            totalQuestions: quiz.length,
            onQuizCompleted: () {
              widget.onQuizCompleted(score);
            },
          ),
        ),
      );
    }
    setState(() {});
  }

  // late final Quiz question;
  // late bool isLastQuestion;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.black,
        title: const Text(
          'Quiz',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocConsumer<LessonCubit, LessonState>(
        listener: (context, state) {
          if (state is GetQuizGood) {
            quiz = state.quiz;
            // question = quiz[questionIndex];
            //  questionIndex == quiz.length - 1 = questionIndex == quiz.length - 1;
          }
        },
        builder: (context, state) {
          if (state is GetQuizLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetQuizBad) {
            return const Center(
              child: Text('Error loading quiz'),
            );
          } else if (state is GetQuizGood) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    quiz[questionIndex].question!,
                    style: const TextStyle(
                      fontSize: 21,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Time remaining: $remainingSeconds seconds',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: quiz[questionIndex].options!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: selectedAnswerIndex == null
                            ? () => pickAnswer(index)
                            : null,
                        child: AnswerCard(
                          currentIndex: index,
                          question: quiz[questionIndex].options![index],
                          isSelected: selectedAnswerIndex == index,
                          selectedAnswerIndex: selectedAnswerIndex,
                          correctAnswerIndex:
                              quiz[questionIndex].correctAnswerIndex!,
                        ),
                      );
                    },
                  ),
                  // Next Button
                  questionIndex == quiz.length - 1
                      ? RectangularButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => ResultScreen(
                                  idLesson: widget.lessonId,
                                  idSection: widget.sectionId,
                                  score: score,
                                  totalQuestions: quiz.length,
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
                          onPressed: selectedAnswerIndex != null
                              ? goToNextQuestion
                              : null,
                          label: 'Next',
                        ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('Error loading quiz'),
            );
          }
        },
      ),
    );
  }
}
