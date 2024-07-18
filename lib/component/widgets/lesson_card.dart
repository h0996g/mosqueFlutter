import 'package:flutter/material.dart';
import 'package:mosque/model/section_model.dart';

class LessonCard extends StatelessWidget {
  final Lesson lesson;
  final bool isPlaying;
  final bool isCompleted;
  final bool isSelected;

  const LessonCard({
    super.key,
    required this.lesson,
    required this.isPlaying,
    required this.isCompleted,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ]
            : null,
      ),
      child: ListTile(
        leading: Icon(
          isPlaying ? Icons.play_arrow : Icons.play_circle_outline,
          size: 30,
        ),
        title: Text(
          lesson.title ?? '',
          style: const TextStyle(fontSize: 16),
        ),
        subtitle: Text(
          lesson.duration ?? '',
          style: const TextStyle(fontSize: 12),
        ),
        trailing: Icon(
          isCompleted ? Icons.check_circle : Icons.lock,
          color: isCompleted ? Colors.green : null,
          size: 24,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}
