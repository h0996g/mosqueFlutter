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
      child: Material(
        elevation: 4.0, // Added shadow
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white, // Light background color
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: showCorrectAnswer
                  ? (isCorrectAnswer
                      ? Colors.green
                      : (isWrongAnswer ? Colors.red : Colors.grey[300]!))
                  : (isSelected
                      ? Colors.blue
                      : Colors.grey[300]!), // Softer border colors
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  question,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87, // Improved contrast
                    fontWeight: FontWeight.w500, // Slightly bolder font
                  ),
                  softWrap: true, // Wrap text to the next line
                ),
              ),
              const SizedBox(width: 10),
              if (showCorrectAnswer)
                isCorrectAnswer
                    ? buildCorrectIcon()
                    : (isWrongAnswer
                        ? buildWrongIcon()
                        : const SizedBox.shrink())
              else if (isSelected)
                buildSelectedIcon(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCorrectIcon() => CircleAvatar(
        radius: 15,
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      );

  Widget buildWrongIcon() => CircleAvatar(
        radius: 15,
        backgroundColor: Colors.red,
        child: const Icon(
          Icons.close,
          color: Colors.white,
        ),
      );

  Widget buildSelectedIcon() => CircleAvatar(
        radius: 15,
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      );
}
