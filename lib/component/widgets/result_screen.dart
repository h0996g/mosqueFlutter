import 'package:flutter/material.dart';
import 'package:mosque/generated/l10n.dart';
import 'package:mosque/screen/userScreens/home/cubit/home_user_cubit.dart';

class ResultScreen extends StatefulWidget {
  final double scorePercentage;
  final String idSection;
  final String idLesson;
  final VoidCallback onQuizCompleted;

  const ResultScreen({
    super.key,
    required this.scorePercentage,
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
    _animation = Tween<double>(begin: 0, end: widget.scorePercentage / 100)
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
            Text(
              S.of(context).yourScore,
              style: const TextStyle(
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
                    Text(
                      '${(_animation.value * 100).toInt()}%',
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () async {
                if (widget.scorePercentage >= 50) {
                  await HomeUserCubit.get(context)
                      .updateLessonCompletionStatus(
                    idlesson: widget.idLesson,
                    idSection: widget.idSection,
                    score: widget.scorePercentage.toInt(),
                  )
                      .then((value) {
                    widget.onQuizCompleted();
                    Navigator.pop(context);
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
              child: Text(
                S.of(context).continuee,
                style: const TextStyle(
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
