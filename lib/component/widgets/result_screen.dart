import 'package:confetti/confetti.dart';
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
  late ConfettiController _confettiController;

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

    _confettiController =
        ConfettiController(duration: const Duration(seconds: 5));
    if (widget.scorePercentage >= 50) {
      _confettiController.play();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isSuccess = widget.scorePercentage >= 50;
    String message = isSuccess
        ? S.of(context).congratulations
        : S.of(context).focusAndTryAgain;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
              const SizedBox(height: 16),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomPaint(
                        size: const Size(200, 200),
                        painter: CirclePainter(_animation.value, isSuccess),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${(_animation.value * 100).toInt()}%',
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Icon(
                            isSuccess ? Icons.check_circle : Icons.error,
                            size: 48,
                            color: isSuccess ? Colors.green : Colors.red,
                          ),
                        ],
                      ),
                      if (isSuccess)
                        ConfettiWidget(
                          confettiController: _confettiController,
                          blastDirectionality: BlastDirectionality.explosive,
                          shouldLoop: false,
                          numberOfParticles:
                              50, // Increased number of particles
                          gravity: 0.1, // Slower falling confetti
                          emissionFrequency: 0.05, // Frequent emission
                          colors: const [
                            Colors.green,
                            Colors.blue,
                            Colors.pink,
                            Colors.orange,
                            Colors.purple
                          ],
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 25),
              Text(
                message,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: isSuccess ? Colors.green : Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
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
                  foregroundColor: Colors.black87,
                  backgroundColor: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: Colors.grey[300]!,
                    ),
                  ),
                ),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      S.of(context).continuee,
                      style: TextStyle(
                          letterSpacing: 1.5, // Adjusted letter spacing
                          fontSize: 28, // Adjusted font size
                          fontWeight: FontWeight.w500, // Medium weight font
                          color: Colors.black87),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final double value;
  final bool isSuccess;

  CirclePainter(this.value, this.isSuccess);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..strokeWidth = 28
      ..style = PaintingStyle.stroke
      ..shader = LinearGradient(
        colors: isSuccess
            ? [Colors.green, Colors.lightGreen]
            : [Colors.red, Colors.orange],
        stops: [0.0, value],
      ).createShader(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2,
      ));

    final Paint backgroundPaint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 28
      ..style = PaintingStyle.stroke;

    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2;

    canvas.drawCircle(center, radius, backgroundPaint);
    double sweepAngle = 2 * 3.141592653589793 * value;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.141592653589793 / 2,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return oldDelegate.value != value || oldDelegate.isSuccess != isSuccess;
  }
}
