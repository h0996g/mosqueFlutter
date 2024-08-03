import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosque/component/widgets/answer_card.dart';
import 'package:mosque/component/widgets/next_button.dart';
import 'package:mosque/component/widgets/result_screen.dart';
import 'package:mosque/generated/l10n.dart';
import 'package:mosque/model/section_model.dart';
import 'package:mosque/screen/userScreens/lesson/cubit/lesson_cubit.dart';

class QuizScreen extends StatefulWidget {
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
  Set<int> selectedAnswers = {};
  int questionIndex = 0;
  int score = 0;
  int remainingSeconds = 10;
  Timer? timer;
  LessonCubit? lessonCubit;
  List<Quiz> quiz = [];
  bool showCorrectAnswer = false;

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
        checkAnswer();
      }
    });
  }

  void pickAnswer(int value) {
    if (!showCorrectAnswer) {
      setState(() {
        if (selectedAnswers.contains(value)) {
          selectedAnswers.remove(value);
        } else {
          selectedAnswers.add(value);
        }
      });
    }
  }

  void checkAnswer() {
    timer?.cancel();
    setState(() {
      showCorrectAnswer = true;
    });
    calculateScore();
  }

  void calculateScore() {
    final question = quiz[questionIndex];
    Set<int> correctAnswers = Set.from(question.correctAnswerIndex!);
    if (selectedAnswers.isNotEmpty && correctAnswers.isNotEmpty) {
      if (selectedAnswers.length == correctAnswers.length &&
          selectedAnswers.containsAll(correctAnswers)) {
        score++;
      }
    }
  }

  void goToNextQuestion() {
    if (questionIndex < quiz.length - 1) {
      setState(() {
        questionIndex++;
        selectedAnswers.clear();
        remainingSeconds = 10;
        showCorrectAnswer = false;
      });
      startTimer();
    } else {
      navigateToResultScreen();
    }
  }

  void navigateToResultScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => ResultScreen(
          idLesson: widget.lessonId,
          idSection: widget.sectionId,
          scorePercentage: (score / quiz.length) * 100,
          onQuizCompleted: () {
            widget.onQuizCompleted(score);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        title: Text(
          S.of(context).quizTitle,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: BlocConsumer<LessonCubit, LessonState>(
        listener: (context, state) {
          if (state is GetQuizGood) {
            quiz = state.quiz;
          }
        },
        builder: (context, state) {
          if (state is GetQuizLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetQuizBad) {
            return Center(
              child: Text(
                S.of(context).errorLoadingQuiz,
                style: const TextStyle(color: Colors.black),
              ),
            );
          } else {
            if (quiz.isEmpty) {
              return ResultScreen(
                idLesson: widget.lessonId,
                idSection: widget.sectionId,
                scorePercentage: 100,
                onQuizCompleted: () {
                  widget.onQuizCompleted(score);
                },
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      quiz[questionIndex].question!,
                      style: const TextStyle(
                        fontSize: 21,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      S.of(context).timeRemaining(remainingSeconds),
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: quiz[questionIndex].options!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => pickAnswer(index),
                          child: AnswerCard(
                            currentIndex: index,
                            question: quiz[questionIndex].options![index],
                            isSelected: selectedAnswers.contains(index),
                            selectedAnswers: selectedAnswers,
                            correctAnswerIndex:
                                quiz[questionIndex].correctAnswerIndex!,
                            showCorrectAnswer: showCorrectAnswer,
                          ),
                        );
                      },
                    ),
                    showCorrectAnswer
                        ? RectangularButton(
                            onPressed: goToNextQuestion,
                            label: questionIndex == quiz.length - 1
                                ? S.of(context).finish
                                : S.of(context).next,
                          )
                        : RectangularButton(
                            onPressed:
                                selectedAnswers.isNotEmpty ? checkAnswer : null,
                            label: S.of(context).checkAnswer,
                          ),
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }
}
