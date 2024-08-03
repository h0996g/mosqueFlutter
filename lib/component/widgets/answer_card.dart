import 'package:flutter/material.dart';

class AnswerCard extends StatelessWidget {
  const AnswerCard({
    super.key,
    required this.question,
    required this.isSelected,
    required this.currentIndex,
    required this.correctAnswerIndex,
    required this.selectedAnswers,
    required this.showCorrectAnswer,
  });

  final String question;
  final bool isSelected;
  final List<int> correctAnswerIndex;
  final Set<int> selectedAnswers;
  final int currentIndex;
  final bool showCorrectAnswer;

  @override
  Widget build(BuildContext context) {
    bool isCorrectAnswer = correctAnswerIndex.contains(currentIndex);
    bool isWrongAnswer = !isCorrectAnswer && isSelected;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: 70,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: showCorrectAnswer
                ? (isCorrectAnswer
                    ? Colors.green
                    : (isWrongAnswer ? Colors.red : Colors.grey[600]!))
                : (isSelected ? Colors.blue : Colors.grey[600]!),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                question,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 10),
            if (showCorrectAnswer)
              isCorrectAnswer
                  ? buildCorrectIcon()
                  : (isWrongAnswer ? buildWrongIcon() : const SizedBox.shrink())
            else if (isSelected)
              buildSelectedIcon(),
          ],
        ),
      ),
    );
  }

  Widget buildCorrectIcon() => const CircleAvatar(
        radius: 15,
        backgroundColor: Colors.green,
        child: Icon(
          Icons.check,
          color: Colors.white,
        ),
      );

  Widget buildWrongIcon() => const CircleAvatar(
        radius: 15,
        backgroundColor: Colors.red,
        child: Icon(
          Icons.close,
          color: Colors.white,
        ),
      );

  Widget buildSelectedIcon() => const CircleAvatar(
        radius: 15,
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.check,
          color: Colors.white,
        ),
      );
}
