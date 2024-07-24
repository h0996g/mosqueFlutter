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
        borderRadius: BorderRadius.circular(12),
        color: isSelected ? Colors.blueAccent.withOpacity(0.1) : Colors.white,
        border: isSelected
            ? Border.all(color: Colors.blueAccent, width: 2)
            : Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: ListTile(
        leading: Icon(
          isPlaying ? Icons.play_arrow : Icons.play_circle_outline,
          size: 30,
          color: isPlaying ? Colors.blueAccent : Colors.grey,
        ),
        title: Text(
          lesson.title ?? '',
          style: TextStyle(
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.blueAccent : Colors.black,
          ),
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}
