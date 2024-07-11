import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosque/screen/userScreens/home/cubit/home_user_cubit.dart';

import 'package:mosque/screen/userScreens/lesson/cubit/lesson_cubit.dart';

class ResultScreen extends StatefulWidget {
  final int score;
  final String idSection;
  final String idLesson;
  final int totalQuestions;
  final VoidCallback onQuizCompleted;

  const ResultScreen({
    super.key,
    required this.score,
    required this.totalQuestions,
    required this.onQuizCompleted,
    required this.idSection,
    required this.idLesson,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation =
        Tween<double>(begin: 0, end: widget.score / widget.totalQuestions)
            .animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Your Score',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 32),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: CircularProgressIndicator(
                        value: _animation.value,
                        strokeWidth: 20,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          HSVColor.fromAHSV(
                            1,
                            _animation.value * 120,
                            1,
                            1,
                          ).toColor(),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          '${(_animation.value * 100).toInt()}%',
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${widget.score} / ${widget.totalQuestions}',
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () {
                if (widget.score / widget.totalQuestions >= 0.5) {
                  LessonCubit.get(context)
                      .updateLessonCompletionStatus(
                    idlesson: widget.idLesson,
                    idSection: widget.idSection,
                    score: (widget.score / widget.totalQuestions * 100).toInt(),
                  )
                      .then((value) {
                    HomeUserCubit.get(context).getMyInfo().then((value) {
                      widget.onQuizCompleted();
                      Navigator.pop(context);
                    });
                  });
                } else {
                  widget.onQuizCompleted();
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
